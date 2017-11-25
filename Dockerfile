FROM ubuntu:xenial

# fix stupid issue that was causing hashsum mismatch
RUN rm -rf /var/lib/apt/lists/*

# install core utils
RUN apt-get update && \
    apt-get install -y \
        software-properties-common \
        curl \
        git \
        python3 \
        python3-pip

# install extra utils
RUN add-apt-repository ppa:neovim-ppa/stable && \
    add-apt-repository ppa:fish-shell/release-2 && \
    apt-get update && \
    apt-get install -y neovim fish && \
    pip3 install --upgrade neovim && \
    curl -sfLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
    curl -sLo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher && \
    /usr/bin/fish -c 'fisher install boss'

ENV TERM xterm-256color
ENV SHELL /usr/bin/fish

CMD ["fish"]
