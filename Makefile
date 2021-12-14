VERSION=0.1.1
CC=cc
INSTALL=install
CFLAGS=$(shell pkg-config --cflags sqlite3 libpcre) -fPIC
LIBS=$(shell pkg-config --libs libpcre)
prefix=/usr

.PHONY : install dist clean

pcre2.so : pcre2.c
	${CC} -shared -o $@ ${CFLAGS} -W -Werror $^ ${LIBS}

install : pcre2.so
	sudo ${INSTALL} -p $^ ${prefix}/lib/sqlite3/pcre2.so

dist : clean
	mkdir sqlite3-pcre2-${VERSION}
	cp -f pcre2.c Makefile readme.txt sqlite3-pcre2-${VERSION}
	tar -czf sqlite3-pcre2-${VERSION}.tar.gz sqlite3-pcre2-${VERSION}

clean :
	-rm -f pcre2.so
