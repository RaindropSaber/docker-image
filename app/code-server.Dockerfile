FROM raindropsaber/ubuntu


RUN curl -fsSL https://code-server.dev/install.sh | sh \
    && code-server --install-extension MS-CEINTL.vscode-language-pack-zh-hans
  # RUN nohup code-server --auth none --bind-addr 0.0.0.0:8080 >~/code-server/out.log 2>&1 &

