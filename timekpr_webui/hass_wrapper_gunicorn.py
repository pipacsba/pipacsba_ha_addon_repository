import os
import re
from flask import session, redirect, url_for, request

# IMPORT YOUR ORIGINAL APP
from app import app

# --- 1. GUNICORN WORKER FIX (CRITICAL) ---
# Ensure all workers share the same secret key.
# If we don't do this, workers cannot validate each other's session cookies.
# We prioritize an env var, otherwise we set a static fallback.
app.secret_key = os.environ.get('FLASK_SECRET_KEY', 'hass_ingress_static_secret_key')

# --- 2. AUTHENTICATION BYPASS ---
@app.before_request
def force_autologin():
    # Only set the session if it's missing to avoid re-signing cookies on every request
    if not session.get('logged_in'):
        session['logged_in'] = True
    
    # Redirect root logic
    if request.path == '/':
        return redirect(url_for('dashboard'))

#@app.before_request
#def force_ingress_path():
#    if not request.path.startswith(request.script_root):
#        return redirect(request.script_root + request.path)


# --- 3. HOME ASSISTANT INGRESS MIDDLEWARE ---
class IngressMiddleware:
    def __init__(self, app):
        self.app = app

    def __call__(self, environ, start_response):
        # 1. Capture Ingress Path
        script_name = (environ.get('HTTP_X_INGRESS_PATH', '') )
        if script_name:
            environ['SCRIPT_NAME'] = script_name
            path_info = environ['PATH_INFO']
            if path_info.startswith(script_name):
                environ['PATH_INFO'] = path_info[len(script_name):]
        return self.app(environ, start_response)


app.wsgi_app = IngressMiddleware(app.wsgi_app)

# This block is ignored by Gunicorn but useful for local testing
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
