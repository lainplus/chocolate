PREFIX ?= /usr/local
CPPFLAGS += -D_GNU_SOURCE -D_LINUX_PORT -Imissing
MANPREFIX ?= ${PREFIX}/share/man
RELEASE = 1.0
EXTRA_SRC = missing/strlcpy.c missing/kqueue_inotify.c

all: chocolate

test: chocolate_spec chocolate
	@echo "running unit tests"
	@./chocolate_spec

gcc-lint: clean
	@CPPFLAGS="-std=c89 -pedantic -Wall -Wpointer-arith -Wbad-function-cast" make test

regress:
	@echo "running functional tests"
	@./system_test.sh

chocolate: chocolate.c ${EXTRA_SRC}
	${CC} ${CFLAGS} ${CPPFLAGS} ${EXTRA_SRC} chocolate.c -o $@ ${LDFLAGS}

chocolate_spec: chocolate_spec.c chocolate.c ${EXTRA_SRC}
	${CC} ${CFLAGS} ${CPPFLAGS} ${EXTRA_SRC} chocolate.c -o $@ ${LDFLAGS}

clean:
	rm -f chocolate chocolate_spec *.o

distclean: clean
	rm -f Makefile

install: chocolate
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@mkdir -p ${DESTDIR}${MANPREFIX}/man1
	install chocolate ${DESTDIR}${PREFIX}/bin

uninstall:
	rm ${DESTDIR}${PREFIX}/bin/chocolate

.PHONY: all test gcc-lint regress clean distclean install uninstall
