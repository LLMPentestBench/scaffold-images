FROM ubuntu:24.04 AS image-fetch

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        skopeo && \
    update-ca-certificates

ARG PRELOAD_IMAGE=xoxruns/sandboxed_kali

RUN mkdir -p /images && \
    skopeo copy \
      --override-os linux \
      docker://docker.io/${PRELOAD_IMAGE} \
      docker-archive:/image.tar:${PRELOAD_IMAGE}

FROM llmptb-baseimage:latest

WORKDIR /root

RUN curl -fsSL https://raw.githubusercontent.com/xoxruns/deadend-cli/v0.1.15/install.sh | bash -s -- --version v0.1.15 && \
     apt-get update && apt-get install -y ca-certificates fonts-liberation libatk-bridge2.0-0 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgbm1 libgcc1 libglib2.0-0 libgtk-3-0 libnspr4 libnss3 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 lsb-release wget xdg-utils libasound2t64 \
     && rm -rf /var/lib/apt/lists/*

COPY config.json /root/.cache/deadend/config.json

COPY --from=image-fetch /image.tar /preload/images/sandboxed_kali.tar

COPY docker-preload.service /etc/systemd/system/docker-preload.service
COPY docker-preload.sh /usr/local/bin/docker-preload.sh
RUN chmod +x /usr/local/bin/docker-preload.sh && \
    systemctl enable docker-preload.service