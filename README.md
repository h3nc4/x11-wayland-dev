# X11 Wayland Dev

The build toolchain for the C window-manager stack: [dwm](https://github.com/h3nc4/dwm),
[st](https://github.com/h3nc4/st), [dmenu](https://github.com/h3nc4/dmenu),
[sxac](https://github.com/h3nc4/sxac) and [dwl](https://github.com/h3nc4/dwl).

Those five are forks of programs that share a compiler, an Xlib stack and, for dwl, wlroots.
Each used to install its own apt list in CI, so five lists drifted apart and none of them
was pinned. This image is that list, in one place, published under a build id.

## Use

Build a checkout without installing anything on the host:

```sh
docker run --rm \
  --user "$(id -u):$(id -g)" \
  -v "${PWD}:/workspaces" \
  h3nc4/x11-wayland-dev:1 \
  make
```

`--user` keeps the object files owned by the caller. In CI the same image is the job
container, and in an editor it is the `.devcontainer.json` image of each repository.

## Versions

The tag is an integer that only CI writes, bumped on every push that changes the image.
`.github/VERSION` holds the last published id, and each consumer pins that id. Renovate
opens the bump in the five repositories once a new id exists.

wlroots decides the Debian base. dwl builds against the version Debian packages, so moving
to a newer base means porting dwl first. Everything else follows the base.

## License

<!-- vale off -->

X11 Wayland Dev is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

X11 Wayland Dev is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with X11 Wayland Dev. If not, see <https://www.gnu.org/licenses/>.
