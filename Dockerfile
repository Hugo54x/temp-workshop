#########################################
#*   LOCKED INSTALL FOR LIVE ENVIRONMENTS
#########################################
FROM mambaorg/micromamba:0.24-buster-slim as live

COPY --chown=$MAMBA_USER:$MAMBA_USER requirements.lock /tmp/requirements.lock

RUN micromamba install --yes --name base -f /tmp/requirements.lock --extra-safety-checks && \
    micromamba clean --all --yes

COPY --chown=$MAMBA_USER:$MAMBA_USER jupyterlab/src/ /tmp/src/

WORKDIR /tmp/src/

ENTRYPOINT ["/usr/local/bin/_entrypoint.sh", "python", "main.py"]

FROM live as test-live

WORKDIR /tmp/src/

ENTRYPOINT ["/usr/local/bin/_entrypoint.sh", "python", "-m", "unittest", "main.py", "-f"]

#########################################
#*   LOOSER INSTALL FOR DEV ENVIRONMENTS
#########################################
FROM mambaorg/micromamba:0.24-buster-slim as dev

COPY --chown=$MAMBA_USER:$MAMBA_USER requirements.yml /tmp/requirements.yml
COPY --chown=$MAMBA_USER:$MAMBA_USER entrypoint.sh /tmp/entrypoint.sh

RUN micromamba install --yes --name base -f /tmp/requirements.yml --extra-safety-checks && \
    micromamba clean --all --yes

WORKDIR $HOME

USER root
RUN chmod +x /tmp/entrypoint.sh && \
    apt update && \
    apt install -y sudo && \
    rm -rf /var/lib/apt/lists/* && \
    echo "$MAMBA_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    usermod -aG sudo $MAMBA_USER
USER $MAMBA_USER

RUN echo "cd ~/" >> ~/.bashrc

ENV JUPYTER_ENABLE_LAB=yes
ENV JUPYTER_TOKEN=""
ENV JUPYTER_PASSWORD=""
ENV LISTEN_ADDRESS="0.0.0.0"
ENV JUPYTER_PORT=8888
ENV RESTARTABLE=yes
ENV GRANT_SUDO=yes
ENV NB_USER=$MAMBA_USER
ENV CHOWN_HOME=yes
ENV SHELL=/bin/bash

EXPOSE ${JUPYTER_PORT}

ENTRYPOINT ["/usr/local/bin/_entrypoint.sh", "./entrypoint.sh"]

#########################################
#*   PRE-PACKED DOCKER CONTAINER
#########################################
FROM mambaorg/micromamba:0.24.0 as pre-packed-sample

COPY --chown=$MAMBA_USER:$MAMBA_USER jupyterlab/src/ /tmp/src/

RUN micromamba install --yes --name base --channel conda-forge --extra-safety-checks \
      python=3.10.5 \
      numba=0.55.2  \
      numpy=1.22.4 && \
    micromamba clean --all --yes

WORKDIR /tmp/src/

ENTRYPOINT ["/usr/local/bin/_entrypoint.sh", "python", "main.py"]

FROM pre-packed-sample as test-pre-packed-sample

WORKDIR /tmp/src/

ENTRYPOINT ["/usr/local/bin/_entrypoint.sh", "python", "-m", "unittest", "main.py", "-f"]
