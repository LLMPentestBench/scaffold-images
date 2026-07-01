## Base Image
The base image with the proxy setup has a few notable features. First, the AI endpoint is available at:
- `http://llmproxy/v1`
- `http://litellm:4000/v1`
- `http://localhost:4000/v1`
- `https://api.openai.com/v1`
    - This requires trusting CA `/usr/local/share/ca-certificates/my_ca.crt`, included in `ca-certificates.crt`

This endpoint is a LiteLLM instance. See the LiteLLM documentation for the exact specification of the endpoints.

The base image has systemctl and Docker installed. If you want to run a subcontainer, it is recommended to pull that image at build-time, see [deadend-cli](deadend-cli/Dockerfile) for an example. If that subcontainer requires a connection to the LLM, we recommend adding a host gateway to the subcontainer (`--add-host=host.docker.internal:host-gateway` or `"host.docker.internal:host-gateway"` in Docker Compose `extra_hosts`).

Other installed utilities include:
- `git`
- `curl`
- `wget`
- `unzip`
- `make`
- `uv`
- `nvm`

## Initialization

If the image requires any initialization before the start of the run, it can be done through a service. If that initialization is loading a Docker image, you can put a Docker archive .tar file in `/preload/images`, which will automatically be loaded by the base image. See [deadend-cli](deadend-cli/Dockerfile) for an example. Be aware that, at build time, the Docker daemon (and systemd) is not available.

At this stage, the challenge details are not available.

## Running

The command defined by the CTFd plugin scaffold file will be executed to indicate the start of this phase. At this time, the challenge file(s) will be available in `/llmptb/input/challenge.json` and any possible files in `/llmptb/input/files/*`. The format of the `challenge.json` file is as follows:
```json
{
    "name": "my challenge",
    "description": "hack into this site, good luck",
    "category": "web",
    "connection_info": "https://google.com",
    "flag_format": "Trojan\\{.{6,}\\}",
    "files": [
        "context.js"
    ],
}
```

## Termination

After the defined timeout, the container will be stopped. After this, the file `/llmptb/output/flag.txt` will be read, and it's contents matched with the challenge's flag(s). This means the file should contain only one flag. It may have leading or trailing whitespace, this is removed before submission.

Any other files in `/llmptb/output/*` will be stored as artifacts for the run.