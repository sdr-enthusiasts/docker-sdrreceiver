# Docker SDRReceiver

Docker container for running [SDRReceiver](https://github.com/jeroenbeijer/SDRReceiver).

---
This container is based on the absolutely fantastic [jlesage/baseimage-gui](https://hub.docker.com/r/jlesage/baseimage-gui). All the hard work has been done by them, for advanced usage I suggest you check out the [README](https://github.com/jlesage/docker-handbrake/blob/master/README.md) from [jlesage/baseimage-gui](https://hub.docker.com/r/jlesage/baseimage-gui).
---

## Ports

Ports `5800 5900 6003` are exposed by default in this container.

| Port | Mapping to host | Description |
|------|-----------------|-------------|
| `5800` | MANDATORY | Port used to access the application's GUI via the web interface.|
| `5900` | Optional | Port used to access the application's GUI via the VNC protocol.  Optional if no VNC client is used. |
| `6003` | MANDATORY | Port used to serve ZMQ data |

## Volumes

SDRReceiver configuration file is mounted in container as startup argument. REQUIRED!

## Up-and-Running with `docker-compose`

- An example [`docker-compose.yml`](docker-compose.yml) file can be found in this repository.
- The accompanying environment variable values are defined in the [`.env`](.env) file in this repository.
- Add SDRReceiver ini file to the cloned directory. 
- Edit the `docker-compose.yml` and `.env` files and make any changes as needed. Please configure ALL variables in `.env`. Very important that CONFIG_FILE setting matches SDRReceiver configuration name.
- Browse to `http://your-host-ip:5800` to access the GUI.
