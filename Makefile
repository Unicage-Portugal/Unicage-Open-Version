# The MIT License
#
# Copyright (C) 2012-2022 Universal Shell Programming Laboratory
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

NAME=		unicage-open-version

PREFIX?=	/usr/local
BINDIR?=	${PREFIX}/bin
TUKDIR?=	${PREFIX}/share/${NAME}
DATDIR?=	${TUKDIR}/devel
MANDIR=		${DATDIR}/man
DOCDIR=		${DATDIR}/doc

COMMANDS=1bai block_getlast calclock calsed cap cgi-name check_attr_name check_cmp_name check_date_name check_dble_name check_inlist_name check_need_name cjoin0 cjoin1 cjoin1x cjoin2 cjoin2x comma count ctail dayslash delf delr divsen exist extname filehame formhame fromcsv fsed getfirst getlast gyo haba han isdate join0 join1 join1x join2 join2x joinx juni kasan keta keycut loopj loopx maezero man2 map marume mdate mime-read mojihame msort nameread numchar plus rank ratio retu rjson self selr sm2 sm4 sm5 tarr tateyoko tcat tocsv uconv ulock unmap up3 wjson xmldir yarr ycat yobi ysum zen

MANUAL=1bai.txt block_getlast.txt calclock.txt calsed.txt cap.txt cgi-name.txt check_attr_name.txt check_cmp_name.txt check_date_name.txt check_dble_name.txt check_inlist_name.txt check_need_name.txt cjoin0.txt cjoin1.txt cjoin1x.txt cjoin2.txt cjoin2x.txt comma.txt count.txt ctail.txt dayslash.txt delf.txt delr.txt divsen.txt exist.txt extname.txt filehame.txt formhame.txt fromcsv.txt fsed.txt getfirst.txt getlast.txt gyo.txt haba.txt han.txt isdate.txt join0.txt join1.txt join1x.txt join2.txt join2x.txt joinx.txt juni.txt kasan.txt keta.txt keycut.txt loopj.txt loopx.txt maezero.txt man2.txt map.txt marume.txt mdate.txt mime-read.txt mojihame.txt msort.txt nameread.txt numchar.txt plus.txt rank.txt ratio.txt retu.txt rjson.txt self.txt selr.txt sm2.txt sm4.txt sm5.txt tarr.txt tateyoko.txt tcat.txt tocsv.txt uconv.txt ulock.txt unmap.txt up3.txt wjson.txt xmldir.txt yarr.txt ycat.txt yobi.txt ysum.txt zen.txt

DOC=		LICENSE README.md

INSTALL?=	/usr/bin/install
MKDIR?=		/bin/mkdir -p
RMDIR?=		/bin/rmdir
RM?=		/bin/rm -f

TODAY!=		date "+%Y%m%d"

INSTALL_PROGRAM=${INSTALL} -m ${BINMODE}
INSTALL_DOCS=	${INSTALL} -m ${DOCMODE}
BINMODE=	555
DOCMODE=	444

all:
	@echo "Run 'make install' to install"
	@echo "    PREFIX=${PREFIX}"
	@echo "    BINDIR=${BINDIR}"
	@echo "    TUKDIR=${TUKDIR}"
	@echo "    DATDIR=${DATDIR}"
	@echo "    MANDIR=${MANDIR}"
	@echo "    DOCDIR=${DOCDIR}"

test: # Run tests for shell scripts only.
	@path=$$(mktemp -d); \
	echo > /dev/null "If gsed exists, use it instead of sed. (only if running on macOS)"; \
	uname | awk '$$0 == "Darwin" {exit 1}' || ln -s $$(which gsed) $$path/sed; \
	for test_script in $$(echo TEST/* | tr ' ' '\n' | grep -e '\/[^.]*\.test$$'); do \
		PATH=$$path:$$PATH "$${test_script}" "$$(pwd)/COMMANDS"; \
		if [ "$$?" -ne 0 ]; then \
			echo "test for $$(basename "$${test_script}" .sh)" failed.; \
			exit 1; \
		fi; \
	done; \
	echo Tests are finished successfully.; \
	rm -r "$$path";

install:
	${MKDIR} ${DESTDIR}${BINDIR}
	@for i in ${COMMANDS}; \
	do \
		echo ${INSTALL_PROGRAM} COMMANDS/$${i} ${DESTDIR}${BINDIR}; \
		${INSTALL_PROGRAM} COMMANDS/$${i} ${DESTDIR}${BINDIR}; \
	done
	${MKDIR} ${DESTDIR}${DOCDIR}
	@for i in ${DOC}; \
	do \
		echo ${INSTALL_DOCS} $${i} ${DESTDIR}${DOCDIR}; \
		${INSTALL_DOCS} $${i} ${DESTDIR}${DOCDIR}; \
	done
	${MKDIR} ${DESTDIR}${MANDIR}
	@for i in ${MANUAL}; \
	do \
		echo ${INSTALL_DOCS} MANUAL/$${i} ${DESTDIR}${MANDIR}; \
		${INSTALL_DOCS} MANUAL/$${i} ${DESTDIR}${MANDIR}; \
	done

uninstall:
	@for i in ${COMMANDS}; \
	do \
		echo ${RM} ${DESTDIR}${BINDIR}/$${i}; \
		${RM} ${DESTDIR}${BINDIR}/$${i}; \
	done
	@for i in ${DOC}; \
	do \
		echo ${RM} ${DESTDIR}${DOCDIR}/$${i}; \
		${RM} ${DESTDIR}${DOCDIR}/$${i}; \
	done
	@for i in ${MANUAL}; \
	do \
		echo ${RM} ${DESTDIR}${MANDIR}/$${i}; \
		${RM} ${DESTDIR}${MANDIR}/$${i}; \
	done
	${RMDIR} ${DESTDIR}${DOCDIR}
	${RMDIR} ${DESTDIR}${MANDIR}
	${RMDIR} ${DESTDIR}${DATDIR}
	${RMDIR} ${DESTDIR}${TUKDIR}

package: clean
	${MKDIR} ${NAME}-${TODAY}
	cp -Rp COMMANDS MANUAL LICENSE Makefile README.md ${NAME}-${TODAY}
	tar vcf ${NAME}-${TODAY}.tar ${NAME}-${TODAY}
	bzip2 ${NAME}-${TODAY}.tar
	rm -rf ${NAME}-${TODAY}

clean:
	rm -rf ${NAME}-${TODAY}*

.PHONY: install test
