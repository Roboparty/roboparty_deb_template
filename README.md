# RoboParty Debian Package Template

Template for native Ubuntu 24.04 Debian packages built on amd64 and arm64.
The example project is intentionally small and can be built before it is
customized.

## Create a repository

Select "Use this template" on GitHub, or run:

    gh repo create Roboparty/roboparty-example \
      --template Roboparty/roboparty_deb_template \
      --public \
      --clone

Initialize the generated repository:

    ./scripts/init-template.sh \
      roboparty-example \
      roboparty_example \
      "RoboParty example package"

Then review the package-specific build dependencies in debian/control and
.github/workflows/build-deb.yml.

## Build

    dpkg-buildpackage -us -uc -b

Tags use the upstream version without the Debian revision. For example,
debian/changelog version 0.1.0-1 is released with tag v0.1.0.
