FROM llmptb-baseimage:latest

WORKDIR /root

RUN uv python install 3.12 && \
    git clone -n https://github.com/aliasrobotics/cai ~/cai && \
    cd ~/cai && \
    git checkout 559de8fcbc2b44f3b0360f35ffdc2bb975e7d7e4

COPY cai.diff cai.diff

RUN cd ~/cai && \
    git apply ~/cai.diff && \
    uv tool install .

COPY vars.env /root/.env
COPY set_key.sh /root/set_key.sh

RUN chmod +x /root/set_key.sh
