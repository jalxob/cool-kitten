#!/usr/bin/env bash

# check to see if cleancss is installed
command -v cleancss >/dev/null 2>&1 || {
  echo 'cleancss is required. run: sudo npm install clean-css -g' >&2; exit 1;
}

# check to see if uglifyjs is installed
command -v uglifyjs >/dev/null 2>&1 || {
  echo 'uglifyjs is required. run: sudo npm install uglify-js -g' >&2; exit 1;
}

# find the folder that this script is in. this is the root of the project
scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# short css and js directories
cssDir="$scriptDir/css"
jsDir="$scriptDir/js"

# concat the files and output the minified version
cat "$cssDir/normalize.css" "$cssDir/grid.css" "$cssDir/style.css" | cleancss -o "$cssDir/style.min.css"

echo "compiled >> css/style.min.css"

# grab all the js files and concat them with uglifyjs
uglifyjs "$jsDir/jquery.stellar.min.js" "$jsDir/waypoints.min.js" "$jsDir/jquery.easing.1.3.js" "$jsDir/scripts.js" -o "$jsDir/scripts.min.js"

echo "compiled >> js/scripts.min.js"

exit 0