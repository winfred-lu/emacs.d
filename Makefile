EMACS = emacs

VENDOR = $(filter-out vendor/csharp-mode-0.8.5.el, $(wildcard vendor/*.el))
VENDOR += $(wildcard vendor/evil-matchit/*.el)
VENDOR += vendor/autopair/autopair.el
FILES = $(VENDOR) $(wildcard wf/*.el)
ELCFILES = $(FILES:.el=.elc)

DIRS = . $(shell find vendor -maxdepth 1 -type d)
LOADPATH = $(foreach d, $(DIRS), -L $d)

.PHONY: all clean

all: $(ELCFILES)
	$(MAKE) -C vendor/evil
	$(MAKE) -C vendor/git-modes
	$(MAKE) -C vendor/magit
	cd vendor/yasnippet && rake compile

clean:
	rm -f *~
	rm -f \#*\#
	rm -f .depend
	rm -f $(ELCFILES)

$(ELCFILES): %.elc: %.el
	$(EMACS) --batch -Q $(LOADPATH) -f batch-byte-compile $<
