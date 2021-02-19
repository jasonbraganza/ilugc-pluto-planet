FROM alpine
LABEL maintainer="janusworx <jason@janusworx.com>"



# Install base packages
RUN apk update
RUN apk upgrade
RUN set -ex \
    && apk add --no-cache \
    autoconf \
    bash \
    bison \
    bzip2 \
    bzip2-dev \
    ca-certificates \
    coreutils \
    curl \
    gcc \
    g++ \
    git \
    gdbm-dev \
    glib-dev \
    libc-dev \
    libffi-dev \
    libxml2-dev \
    libxslt-dev \
    linux-headers \
    make \
    ncurses-dev \
    openssl-dev \
    procps \
    readline-dev \
    yaml-dev \
    zlib-dev \
    sqlite \
    sqlite-libs \
    sqlite-dev \
    wget



# Set working directory and a some environment variables
WORKDIR /root
COPY --chown=root:root [".profile", "/root/"]
COPY --chown=root:root [".bashrc", "/root/"]
COPY --chown=root:root ["runplanet.sh", "/root/"]
# Set bash to be the shell
SHELL ["/bin/bash","-l","-c"]

# Install rbenv
RUN git clone https://github.com/rbenv/rbenv.git /root/.rbenv
ENV PATH /root/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH
RUN eval "$(rbenv init -)"


# Install ruby build
RUN git clone https://github.com/rbenv/ruby-build.git /root/.rbenv/plugins/ruby-build
ENV PATH /root/.rbenv/plugins/ruby-build/bin:$PATH
RUN git clone https://github.com/rbenv/rbenv-gem-rehash.git /root/.rbenv/plugins/rbenv-gem-rehash

RUN exec $SHELL

# Install ruby via rbenv
RUN rbenv install 3.0.0
RUN rbenv global 3.0.0
RUN rbenv rehash
RUN gem install pluto
RUN pluto install news


# Program related stuff

ENTRYPOINT ["bash", "/root/runplanet.sh"]