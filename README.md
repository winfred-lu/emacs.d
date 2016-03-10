Emacs Envionment
=============

Installation
-----------

	$ git clone git://github.com/winfred-lu/emacs.d.git ~/.emacs.d
	$ cd ~/.emacs.d

Uncomment the line to install all the listed packages during Emacs starts up
	$ sed -i -r 's#(;)(.*wf-chk-pkg.*)#\2#' init.el
	$ emacs

Comment the line out
	$ sed -i -r 's#(.*wf-chk-pkg.*)#;\1#' init.el

Speed Up (Optional)
-----------

Byte-compile everything to speed up Emacs startup:

	$ make

Usage
-----------

	$ emacs
