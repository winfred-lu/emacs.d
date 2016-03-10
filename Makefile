EMACS = emacs

FILES = $(wildcard wf/*.el)
ELCFILES = $(FILES:.el=.elc)

DIRS = . $(shell find elpa -maxdepth 1 -type d)
LOADPATH = $(foreach d, $(DIRS), -L $d)
LOADPATH += -L /usr/share/emacs/site-lisp/python-mode

.PHONY: all clean

all: $(ELCFILES)

clean:
	rm -f *~
	rm -f \#*\#
	rm -f .depend
	rm -f $(ELCFILES)

$(ELCFILES): %.elc: %.el
	$(EMACS) --batch -Q $(LOADPATH) -f batch-byte-compile $<
