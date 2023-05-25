FROM ubuntu:22.04

RUN apt update \
    && apt install -y sudo \
    && useradd -m raindrop -s /bin/bash \
    && adduser raindrop sudo \
    && echo "raindrop ALL=(ALL) NOPASSWD:ALL" | tee /etc/sudoers

# 调节时区
ENV DEBIAN_FRONTEND=noninteractive
RUN apt install -y tzdata \
    && ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

USER raindrop
WORKDIR /home/raindrop


RUN sudo apt install -y git wget curl net-tools openssh-server


# 安装ZSH
RUN sudo apt install -y zsh \
    && git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh \  
    && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
    && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting \
    && sed -i "s/plugins=(git.*)$/plugins=(git zsh-syntax-highlighting zsh-autosuggestions)/" ~/.zshrc \
    && sudo usermod -s /bin/zsh raindrop

# 安装vim
RUN sudo apt install -y vim \
    && echo "set nu" >> ~/.vimrc

# 安装nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash \
    && export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")" \
    &&  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node \
    && nvm i 18


# 清除apt缓存
RUN sudo apt autoremove \
    && sudo apt clean -y \
    && sudo rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/bin/zsh"]