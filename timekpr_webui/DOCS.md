# Home Assistant Add-on: timekpr-nExT web UI addon

## How to use
This web ui is based on the https://github.com/adambie/timekpr-webui.
The goal is to control the timekpr-nExT instance from Home assistant via this addon.

For setup options please visit https://github.com/adambie/timekpr-webui, and look for "3. Remote System Configuration"

Additionally after the ssh key config I have deleted the user password ("sudo passwd -d `timekpr-remote`)

From the config it only needs the private key to connect to the timekpr-nExT instance via ssh.
Imprtant, the complete content of the provate key file shall be added, including the BEGIN and END lines (maybe easier to do it in YAML mode):

ssh_private_key: |
  -----BEGIN OPENSSH PRIVATE KEY-----
  base64encodedkeyhere
  -----END OPENSSH PRIVATE KEY-----
