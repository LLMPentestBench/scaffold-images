FROM ubuntu:24.04 AS image-fetch

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        skopeo && \
    update-ca-certificates

RUN mkdir -p /images && \
    skopeo copy \
      --override-os linux \
      docker://docker.io/yohannesgk/mini-kali-slim@sha256:0e4a4dcaad713f822a153e457f69fab5f3ff3073605e4a4aa9cd8e804d86d270 \
      docker-archive:/image.tar:yohannesgk/mini-kali-slim:latest

FROM llmptb-baseimage:latest

WORKDIR /root

RUN git clone https://github.com/yohannesgk/blacksmith.git && \
    cd blacksmith && \
    git checkout 8f60810766ddb0b622e8231dd547ccf08ef2fca4

COPY changes.diff /root/changes.diff

RUN cd /root/blacksmith && \
    git apply /root/changes.diff && \
    cd /root/blacksmith/blacksmithAI && \
    uv sync && \
    uv add prompt_toolkit

COPY set_key.sh /root/set_key.sh
COPY config.json /root/blacksmith/blacksmithAI/config.json

COPY init.service /etc/systemd/system/blacksmith-init.service
COPY init.sh /usr/local/bin/blacksmith-init.sh

RUN chmod +x /root/set_key.sh && \
    rm /root/changes.diff && \
    chmod +x /usr/local/bin/blacksmith-init.sh && \
    systemctl enable blacksmith-init.service

COPY --from=image-fetch /image.tar /preload/images/mini-kali-slim.tar