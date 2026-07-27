FROM llmptb-baseimage:latest

WORKDIR /root

RUN uv python install 3.12 && uv tool install cai-framework==0.5.10

COPY vars.env /root/.env
COPY set_key.sh /root/set_key.sh

RUN chmod +x /root/set_key.sh
