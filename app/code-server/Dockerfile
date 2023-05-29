FROM raindropsaber/ubuntu


RUN curl -fsSL https://code-server.dev/install.sh | sh \
    && code-server --install-extension ms-ceintl.vscode-language-pack-zh-hans

COPY ./config.yaml .config/code-server/config.yaml

# code-server --auth none --bind-addr 0.0.0.0:8080 --locale zh-cn