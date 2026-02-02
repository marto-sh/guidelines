FROM nixos/nix:latest

# Enable flakes
RUN echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf

# Create non-root user for development
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN addgroup -g $USER_GID $USERNAME \
    && adduser -D -u $USER_UID -G $USERNAME -s /bin/bash $USERNAME \
    && mkdir -p /home/$USERNAME \
    && chown -R $USERNAME:$USERNAME /home/$USERNAME

# Allow user to use nix
RUN mkdir -p /etc/nix \
    && echo "trusted-users = root $USERNAME" >> /etc/nix/nix.conf

USER $USERNAME
WORKDIR /workspaces

# Pre-warm the nix cache with common packages
# This is optional but speeds up first container start
