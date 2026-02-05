# Home Assistant Add-on: timekpr-nExT web UI addon

## Configuration Options
### admin_users: 
A list of usernames that are granted administrative privileges within the application. These users are identified by their username string. At least one user shall be defined.

### ssh_private_key: 
(Optional) A field intended to store or reference the private SSH key used for authenticating connections to the remote Timekpr servers. The application stores keys in the /data/ssh_keys directory to facilitate secure communication. Files can be uploaded later during the server config.

### mqtt: 
(Optional) This section configures the connection to an MQTT broker for Home Assistant integration and status updates:

 -  #### server:

&emsp; The hostname or IP address of your MQTT broker.

 -  #### port: 
&emsp; The port number used by the MQTT broker (e.g., 1883).

 -  #### base_topic: 
&emsp;The root MQTT topic prefix (e.g., timekpr) under which all messages, such as server status and user statistics, will be published.

### log_level: 
(Optional) Sets the verbosity of the application logs. Options include debug, info, warning, error, and fatal. This helps in troubleshooting by controlling how much detail is sent to the Home Assistant add-on logs.
