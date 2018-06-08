PREFIX=~/opt/gnat
GNATMAKE=gnatmake
ifdef PREFIX
### Use another gnatmake
  GNATMAKE=$(PREFIX)/bin/gnatmake
endif
GNATCOMPILE=$(GNATMAKE) -gnat2012 -gnatwa
TESTS=test_humans oriented_test

all : $(TESTS)

test_humans: test_humans.adb animals.adb animals.ads animals-humans.adb animals-humans.ads
	$(GNATCOMPILE) $<

oriented_test: oriented_test.adb oriented.adb oriented.ads
	$(GNATCOMPILE) $<

clean:
	rm -f *~ *.ali *.o *.class

cleanall: clean
	rm -f $(TESTS)


.PHONY: clean cleanall
