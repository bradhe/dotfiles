echo $1
rhino ~/scripts/rhinoed_jslint.js $1 | fgrep -e 'Unexpected' --color=always
