FROM postgres 

# install pged25519
ENV PGED25519_VERSION=v0.2

RUN pged25519Dependencies="git \
    ca-certificates \
    build-essential" \
    && apt-get update \
    && apt-get install -y --no-install-recommends ${pged25519Dependencies} \
    && apt-get install -y postgresql-server-dev-all \
    && apt-get install -y build-essential \
    && cd /tmp \
    && git clone https://gitlab.com/dwagin/pg_ed25519.git \
    && cd pg_ed25519 \
    && make install \
    && apt-get clean \
    && apt-get remove -y ${pged25519Dependencies} \
    && apt-get autoremove -y \
    && rm -rf /tmp/pged25519 /var/lib/apt/lists/* /var/tmp/*


# install pged25519
ENV PGJWTED25519_VERSION=v0.2

RUN pgjwted25519Dependencies="git \
    ca-certificates \
    build-essential" \
    && apt-get update \
    && apt-get install -y --no-install-recommends ${pgjwted25519Dependencies} \
    && apt-get install -y postgresql-server-dev-all \
    && apt-get install -y build-essential \	
    && cd /tmp \
    && git clone https://gitlab.com/dwagin/pgjwt_ed25519.git \
    && cd pgjwt_ed25519 \
    && make install \
    && apt-get clean \
    && apt-get remove -y ${pgjwted25519Dependencies} \
    && apt-get autoremove -y \
    && rm -rf /tmp/pgjwted25519 /var/lib/apt/lists/* /var/tmp/*




