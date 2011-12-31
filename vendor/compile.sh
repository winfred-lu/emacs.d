#!/bin/sh

dir=`dirname $0`

(cd $dir/evil && make)
(cd $dir/magit && make)

if type rake > /dev/null 2>&1; then
	(cd $dir/yasnippet && rake compile)
fi

emacs --batch -Q -f batch-byte-compile $dir/autopair.el
emacs --batch -Q -f batch-byte-compile $dir/color-theme.el
emacs --batch -Q -f batch-byte-compile $dir/smart-tab/smart-tab.el

