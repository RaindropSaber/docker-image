FROM raindropsaber/ubuntu

RUN curl -fsSL https://code-server.dev/install.sh | sh 


COPY ./config.yaml .config/code-server/config.yaml
ADD ./code-server.tgz .local/share/
RUN sudo chown -R 1000:1000 /home/raindrop/.local/share/

CMD ["-c","code-server"]