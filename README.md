# X11 Wayland Dev

The build toolchain for the C window-manager stack: [dwm](https://github.com/h3nc4/dwm),
[st](https://github.com/h3nc4/st), [dmenu](https://github.com/h3nc4/dmenu) and
[sxac](https://github.com/h3nc4/sxac).

Those four are forks of programs sharing a compiler and an Xlib stack. Each used to install its
own apt list in CI, so four lists drifted apart and each went unpinned. This image is that list,
in one place, published under a build id.

[dwl](https://github.com/h3nc4/dwl) was the fifth. It is archived and stays pinned to tag 3, so
it no longer follows this image.

## Use

Build a checkout without installing anything on the host:

```sh
docker run --rm \
  --user "$(id -u):$(id -g)" \
  -v "${PWD}:/workspaces" \
  h3nc4/x11-wayland-dev:8 \
  make
```

`--user` keeps the object files owned by the caller. In CI the same image is the job
container, and in an editor it is the `.devcontainer.json` image of each repository.

## Versions

The tag is an integer that only CI writes, bumped on every push that changes the image.
`.github/VERSION` holds the last published id, and each consumer pins that id. Renovate
opens the bump in the four live repositories once a new id exists. Read `.github/VERSION` for
the current tag rather than trusting the example above.

The base is `debian:sid`, and wlroots is why. dwl 0.8 needed wlroots-0.19, which sid alone
carries, since trixie stopped at 0.18 and forky moved to 0.20. The consumer that requirement existed for is archived, while the Wayland packages and the sid
base are both still here. Dropping them would free the base to move to a stable release. It
would also rebuild all four consumers, which makes it a deliberate change rather than a passing
one.

## License

<!-- vale off -->

X11 Wayland Dev is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

X11 Wayland Dev is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with X11 Wayland Dev. If not, see <https://www.gnu.org/licenses/>.
