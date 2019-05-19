PREFIX=~/opt/gnat
GNATMAKE=gnatmake
ifdef PREFIX
### Use another gnatmake
  GNATMAKE=$(PREFIX)/bin/gnatmake
endif
GNATCOMPILE=$(GNATMAKE) -gnat2012 -gnatwa
SRCS:=$(wildcard *.adb)
TARGETS:=$(patsubst %.adb,%,$(SRCS))

all : $(TARGETS)

% : %.adb
	$(GNATCOMPILE) $<


clean:
	rm -f *~ *.ali *.o *.class

cleanall: clean
	rm -f $(TARGETS)


.PHONY: clean cleanall

