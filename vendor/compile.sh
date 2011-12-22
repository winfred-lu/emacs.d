#!/bin/sh

(cd evil && make)
(cd magit && make)

if type rake > /dev/null 2>&1; then
	(cd yasnippet && rake compile)
fi

emacs --batch -Q -f batch-byte-compile color-theme.el
emacs --batch -Q -f batch-byte-compile smart-tab/smart-tab.el

