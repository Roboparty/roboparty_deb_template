#!/bin/sh
set -eu

if [ "$#" -lt 2 ] || [ "$#" -gt 3 ]; then
    echo "Usage: $0 <debian-package-name> <cmake-package-name> [description]" >&2
    echo "Example: $0 roboparty-foo roboparty_foo 'RoboParty foo driver'" >&2
    exit 1
fi

debian_name=$1
cmake_name=$2
description=${3:-RoboParty package}

case "$debian_name" in
    *[!a-z0-9+.-]*|'')
        echo "Invalid Debian package name: $debian_name" >&2
        exit 1
        ;;
esac

case "$cmake_name" in
    *[!A-Za-z0-9_]*|'')
        echo "Invalid CMake package name: $cmake_name" >&2
        exit 1
        ;;
esac

escape_sed() {
    printf '%s' "$1" | sed 's/[\\&|]/\\&/g'
}

debian_replacement=$(escape_sed "$debian_name")
cmake_replacement=$(escape_sed "$cmake_name")
description_replacement=$(escape_sed "$description")

for file in CMakeLists.txt package.xml debian/changelog debian/control debian/copyright \
    include/roboparty_package/roboparty_package.hpp \
    src/roboparty_package.cpp; do
    sed -i \
        -e "s|roboparty-package|$debian_replacement|g" \
        -e "s|roboparty_package|$cmake_replacement|g" \
        -e "s|RoboParty package template|$description_replacement|g" \
        "$file"
done

sed -i "s|Roboparty/roboparty_deb_template|Roboparty/$debian_replacement|" debian/copyright

old_header=include/roboparty_package/roboparty_package.hpp
new_header="include/$cmake_name/$cmake_name.hpp"
mkdir -p "include/$cmake_name"
mv "$old_header" "$new_header"
rmdir include/roboparty_package
mv src/roboparty_package.cpp "src/$cmake_name.cpp"

sed -i \
    -e "s|src/roboparty_package.cpp|src/$cmake_name.cpp|" \
    -e "s|roboparty_package/roboparty_package.hpp|$cmake_name/$cmake_name.hpp|" \
    CMakeLists.txt "src/$cmake_name.cpp"

printf '# %s\n\n%s\n' "$debian_name" "$description" > README.md

rm -- "$0"
rmdir scripts 2>/dev/null || true

echo "Initialized $debian_name ($cmake_name)."
echo "Review debian/control, package.xml and .github/workflows/build-deb.yml before committing."
