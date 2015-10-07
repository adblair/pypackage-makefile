Python Packaging Makefile
=========================

This repo contains a Makefile that provides rules for releasing Python packages in a painless manner, using [Bumpversion][bumpversion].

Basic usage:

- To make a new release, run `make release`.
- To make a new developmental release, run `make release-dev`.
- After adding the first backwards-compatible new feature since the last release, run `make bump-minor`.
- After adding the first backwards-incompatible new feature since the last release, run `make bump-major`.

Aims/principles:

- Version numbers should conform to [PEP 0440][pep0440] and [Semantic Versioning][semver].
- The current package version number should normally represent a developmental release, e.g. *1.2.0.dev0*, except for the particular commits that correspond to specific full releases.
- For every extant release, there should be a corresponding Git tag on the precise commit used to generated the distributed package.

Example workflow, for a package starting at version 0.0.0.dev0:

- Make some commits for the first release.
- Run `make release`
    - Version gets bumped from 0.0.0.dev0 to 0.0.0.
    - Last commit gets tagged as *v0.0.0* and uploaded to PyPI.
    - Version gets bumped again from 0.0.0 to 0.0.1.dev0.
- Add one or more backwards-compatible new features.
- Run `make bump-minor`.
    - Version gets bumped from 0.0.1.dev0 to 0.1.0.dev0.
- Refine new features.
- Run `make release`:
    - Version gets bumped from 0.1.0.dev0 to 0.1.0.
    - Last commit gets tagged as *v0.1.0* and uploaded to PyPI.
    - Version gets bumped again from 0.1.0 to 0.1.1.dev0.
- Find bugs, make some bug-fixing commits.
- Run `make release`:
    - Version gets bumped from 0.1.1.dev0 to 0.1.1.
    - Last commit gets tagged as *v0.1.1* and uploaded to PyPI.
    - Version gets bumped again from 0.1.1 to 0.1.2.dev0.
- Add one or more backwards-incompatible new features.
- Run `make bump-major`.
    - Version gets bumped from 0.1.2.dev0 to 1.0.0.dev0.
- Refine new features.
- Want to share current development version, so...
- Run `make release-dev`.
    - Last commit gets tagged as *v1.0.0.dev0* and uploaded to PyPI.
    - Version gets bumped from 1.0.0.dev0 to 1.0.0.dev1.
- Make more changes.
- Want to share another development version, so...
- Run `make release-dev`.
    - Last commit gets tagged as *v1.0.0.dev1* and uploaded to PyPI.
    - Version gets bumped from 1.0.0.dev1 to 1.0.0.dev2.
- Finalise new features.
- Run `make release`:
    - Version gets bumped from 1.0.0.dev2 to 1.0.0.
    - Last commit gets tagged as *v1.0.0* and uploaded to PyPI.
    - Version gets bumped again from 1.0.0 to 1.0.1.dev0.
- *etc.*


[pep0440]: https://www.python.org/dev/peps/pep-0440/
[semver]: http://semver.org/
[bumpversion]: https://github.com/peritus/bumpversion
