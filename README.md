# dotfiles

These are my configuration files for unix-like systems.


## Why do this?

Personal configuration files (or dotfiles) tend to only grow in
complexity as time goes on. In time, a veritable heap of workarounds,
dependencies, and niceties is accumulated, and changes are made for
reasons that later become intractible. I got tired of keeping all this
straight, and manually managing these across systems on which I do
work became tedious.

Version control brings syncable, commented, and versioned changesets
to the table; it simply makes sense from a maintainance standpoint.

Maybe you'll get some use out of me publishing this, too.


## Branches and target systems

Not all of the systems I work with have the same feature sets, usually
due to outdated software. The main branch is kept clean of conditional
code, and configured for the latest versions of software when
possible.  Distro-specific branches serve to collect the changesets
needed for alternative, or older systems. Still, I make no guarantees
when it comes to that any branches beside the main one.


## Deployment

There's a script called `dotdeploy`, which I wrote in a
bout of not-invented-here syndrome. It's used to getting these configs
where they're supposed to be.

You'll want to clone this repo somewhere; I personally use
~/.dotfiles.  There needs to be a file in a DSL describing deployment
that ends in .deploy, and which is then processed by the script.
sourced.

It's not particularly documented, but see the repo's .deploy files and
the script for an example of how to use this and extend it yourself.


## License

Copyright (C) 2017 Konrad Tegtmeier

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
