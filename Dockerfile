ARG nvidia_cudagl_version=10.2-devel-ubuntu18.04

FROM nvidia/cudagl:${nvidia_cudagl_version}
ENV DEBIAN_FRONTEND=noninteractive

# [1] zsh (https://github.com/robbyrussell/oh-my-zsh)
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
        wget \
        curl \
        git \
        zsh
SHELL ["/bin/zsh", "-c"]
RUN wget http://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh

# [2] pyenv (https://github.com/pyenv/pyenv/wiki/common-build-problems)
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
        make \
        build-essential \
        libssl-dev \
        zlib1g-dev \
        libbz2-dev \
        libreadline-dev \
        libsqlite3-dev \
        wget \
        curl \
        llvm \
        libncurses5-dev \
        libncursesw5-dev \
        xz-utils \
        tk-dev \
        libffi-dev \
        liblzma-dev \
        python-openssl \
        git
RUN curl https://pyenv.run | zsh && \
    echo '' >> /root/.zshrc && \
    echo 'export PATH="/root/.pyenv/bin:$PATH"' >> /root/.zshrc && \
    echo 'eval "$(pyenv init -)"' >> /root/.zshrc && \
    echo 'eval "$(pyenv virtualenv-init -)"' >> /root/.zshrc
RUN source /root/.zshrc && \
    pyenv install 3.6.7 && \
    pyenv global 3.6.7

# X window and window manager
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        xvfb \
        x11vnc \
        python-opengl \
        icewm \
        screen
COPY start_vnc.sh /root/

# clean cache
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /root
CMD ["zsh"]
