# Copyright (C) 2026  Henrique Almeida
# This file is part of X11 Wayland Dev.
#
# X11 Wayland Dev is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# X11 Wayland Dev is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with X11 Wayland Dev.  If not, see <https://www.gnu.org/licenses/>.

################################################################################
# One toolchain for dwm, st, dmenu, sxac and dwl, so each of those repositories pins
# one tag instead of keeping its own apt list.

FROM debian:sid-slim@sha256:17d1843dae9ca66f1617c1e464f40d06059ccefb0c606e8b54687f253af1684e

ARG USER="dev"
ARG UID="1000"
ARG GID="1000"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq

# git and gnupg are the release path: `make dist.built`, then a detached signature.
RUN apt-get install --no-install-recommends -y -qq \
  ca-certificates \
  git \
  gnupg \
  gzip \
  less \
  make \
  tar

RUN apt-get install --no-install-recommends -y -qq \
  gcc \
  libc6-dev \
  pkg-config

# X11. Xft and Xinerama for dwm and dmenu, bidi and harfbuzz for st, XTest for sxac.
RUN apt-get install --no-install-recommends -y -qq \
  libfribidi-dev \
  libharfbuzz-dev \
  libx11-dev \
  libxft-dev \
  libxinerama-dev \
  libxkbfile-dev \
  libxtst-dev

# Wayland, for dwl. The wlroots version is the constraint on the Debian base above: dwl 0.8
# needs wlroots-0.19, which only sid carries, since trixie stopped at 0.18 and forky is on 0.20.
RUN apt-get install --no-install-recommends -y -qq \
  libfcft-dev \
  libinput-dev \
  libwayland-dev \
  libwlroots-0.19-dev \
  libxcb-icccm4-dev \
  libxcb1-dev \
  libxkbcommon-dev \
  wayland-protocols \
  xwayland

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /var/log/* /tmp/*

# For the dev container's interactive shell. CI runs as root, and a one-shot
# `docker run` should pass --user so build output is not left root-owned.
# sid-slim ships no adduser, so these come from passwd instead.
RUN groupadd --gid "${GID}" "${USER}" && \
  useradd --uid "${UID}" --gid "${GID}" \
  --shell "/bin/bash" --create-home "${USER}"

# A bind-mounted tree owned by another uid is refused otherwise.
RUN git config --system --add safe.directory '*'

WORKDIR /workspaces
CMD ["/bin/bash"]
