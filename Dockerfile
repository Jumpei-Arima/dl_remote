ARG nvidia_cudagl_version=10.2-devel-ubuntu18.04
ARG python_version=3.6.7
ARG zsh_theme=bureau

FROM nvidia/cudagl:${nvidia_cudagl_version}
ENV DEBIAN_FRONTEND=noninteractive

# [1] zsh (https://github.com/ohmyzsh/ohmyzsh)
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
        wget \
        curl \
        git \
        zsh
SHELL ["/bin/zsh", "-c"]
RUN wget http://github.com/ohmyzsh/ohmyzsh/raw/master/tools/install.sh -O - | zsh
ARG zsh_theme
ENV ZSH_THEME=${zsh_theme}
RUN sed -i 's/robbyrussell/${ZSH_THEME}/' /root/.zshrc
ENV DISABLE_AUTO_UPDATE=true

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
    echo 'eval "$(pyenv init -)"' >> /root/.zshrc
ENV PATH=/root/.pyenv/shims:/root/.pyenv/bin:$PATH
ARG python_version
ENV PYTHON_VERSION=${python_version}
RUN pyenv install ${PYTHON_VERSION} && \
    pyenv global ${PYTHON_VERSION}
RUN pip install -U pip

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
