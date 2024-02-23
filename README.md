# Docker SDRReceiver

Docker container for [SDRReceiver](https://github.com/jeroenbeijer/SDRReceiver).

---

This container is based on the absolutely fantastic [jlesage/baseimage-gui](https://hub.docker.com/r/jlesage/baseimage-gui). All the hard work has been done by them, for advanced usage I suggest you check out the [README](https://github.com/jlesage/docker-baseimage-gui/blob/master/README.md) from [jlesage/baseimage-gui](https://hub.docker.com/r/jlesage/baseimage-gui).

---

## Ports

Ports `5800 5900 6003` are exposed by default in this container.

| Port | Mapping to host | Description |
|------|-----------------|-------------|
| `5800` | Mandatory | Port used to access the application's GUI via the web interface.|
| `5900` | Optional  | Port used to access the application's GUI via the VNC protocol.  Optional if no VNC client is used. |
| `6003` | Mandatory | Port used to serve ZMQ data to JAERO. |

## Volumes

SDRReceiver configuration file is mounted in container as startup argument. REQUIRED!

## Up-and-Running with `docker-compose`

- An example [`docker-compose.yml`](docker-compose.yml) file can be found in this repository.
- The accompanying environment variable values are defined in the [`.env`](.env) file in this repository.

Once you have [installed Docker](https://github.com/sdr-enthusiasts/docker-install), you can follow these lines of code to get up and running in very little time:

```bash
mkdir -p docker-sdrreceiver
cd docker-sdrreceiver
wget https://raw.githubusercontent.com/sdr-enthusiasts/docker-sdrreceiver/main/docker-compose.yml
wget https://raw.githubusercontent.com/sdr-enthusiasts/docker-sdrreceiver/main/.env
```
- Add SDRReceiver ini file to  docker-sdrreceiver directory. 
- Edit the `docker-compose.yml` and `.env` files and make any changes as needed. Please configure ALL variables in `.env`. Very important that CONFIG_FILE setting matches SDRReceiver ini file added in previous step.

Start the Container

```bash
docker compose up -d
```
- Browse to `http://your-host-ip:5800` to access the GUI.
