Read the article [Learning Ada 5](FIXME).

# Humans are animals

Try 

    gnatmake -gnat12 -gnatwa -gnatwe test_humans.adb

or similar.

Just

    make

to make all examples — fix the `PREFIX` in the Makefile in case that's not where your GNAT is located. Comment out `PREFIX` if you know `gnatmake` will be found in the PATH.

