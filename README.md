# dotfiles

These are my configuration files for UNIX based systems.


## Why do this ?

I got tired of trying to figure out opaque config changes
that I made far too long ago, and that those changes are
strewn across the entire /home/$USER tree. As a result,
I put them all in a central and cloneable directory from 
which they're easily deployable. Also, it's all versioned
properly via git. It simply makes sense from a maintainance
point-of-view.


## Branches and target systems

Not all systems I work with have the same feature sets. Thus
there are branches for specific systems, of which each one
is a subset of **master**, and may contain some additional
workarounds.

| branch   | system   | version |
| -------- | -------- | ------- |
| `master` | Arch     | latest  |
| `laptop` | Debian   | testing |
| `work`   | OpenSuSE | 42.1    |


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
