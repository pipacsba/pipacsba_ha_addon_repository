# Home Assistant Add-on: timekpr-nExT web UI addon

# This is the EDGE (Unstable version), it may break / not start. Not recommended for normal users.

## How to use
The goal is to control the timekpr-nExT instance from Home assistant via this addon.

For setup options please visit https://github.com/adambie/timekpr-webui, and look for "3. Remote System Configuration"

Additionally after the ssh key config I have deleted the user password ("sudo passwd -d `timekpr-remote`)

From the config it only needs the private key to connect to the timekpr-nExT instance via ssh.
Imprtant, the complete content of the private key file shall be added, including the BEGIN and END lines (maybe easier to do it in YAML mode):

ssh_private_key: |
  -----BEGIN OPENSSH PRIVATE KEY-----
  base64encodedkeyhere
  -----END OPENSSH PRIVATE KEY-----
