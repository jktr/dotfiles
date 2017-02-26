# dotfiles

These are my configuration files for unix-like systems.


## Why do this ?

I got tired of trying to keep all the configs, the
workarounds and the dependencies therein, the obscure
changes, and the experimental features straight.  Then I
realized that version control is the proper tool for this
job, and I migrated everyting into this repo.  Now its
centralized, (relatively) easy to manage, and properly
versioned. It simply makes sense from a maintainance
point-of-view.


## Branches and target systems

Not all systems I work with have the same feature sets.
There are branches for specific systems I work on (or have
worked on), in case workarounds are needed for that system.
The usual cause for these workaround is outdated software.
There's no guarantee that any branches they're even remotely
up-to-date, though.

| branch          | system   | version |
| --------------- | -------- | ------- |
| `archlinux`     | Arch     | latest  |
| `debian-jessie` | Debian   | testing |
| `opensuse-42.1` | OpenSuSE | 42.1    |


## Deployment

I mentioned deployment earlier.  The script `dotdeploy`
(written in a bout of not-invented-here syndrome) takes care
of getting the files where they're supposed to be. To do so,
you must have a definition of the deployment process in a
file ending in `.deploy`, which is then sourced.

See the repo's `.deploy` files and the script for examples
on the DSL used, and how to extend it yourself.


## License

Copyright (C) 2016 mustangflyer

Files in this repository are free software: you can
redistribute and/or modify them under the terms of the GNU
General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your
option) any later version.

These files are distributed in the hope that they will be
useful, but WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.  See the GNU General Public License for more
details.

You should have received a copy of the GNU General Public
License along with this repository. If not, see
<http://www.gnu.org/licenses/>.
