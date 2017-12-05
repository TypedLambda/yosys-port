# $FreeBSD$

PORTNAME=	yosys
DISTVERSION=	0.7
CATEGORIES=	cad
MASTER_SITES=	GITHUB

MAINTAINER=	Arne.Ehrlich@groknet.de
COMMENT=	Framework for Verilog RTL synthesis

USE_GITHUB=	yes
GH_ACCOUNT=	cliffordwolf
DISTVERSIONPREFIX=  yosys-

LICENSE=ISCL

USES= gmake readline pkgconfig shebangfix tcl

BUILD_DEPENDS=$(LOCALBASE)/bin/bash:shells/bash $(LOCALBASE)/bin/gawk:lang/gawk

LIB_DEPENDS=libffi.so:devel/libffi

MAKE_ARGS= \
	   TCL_VERSION=tcl$(TCL_VER) \
	   TCL_INCLUDE=$(TCL_INCLUDEDIR) \
	   __LINUX__=1 \
	   ABCREV=default

CXXFLAGS += -I/usr/local/include -I/usr/local/include/readline $(FFI_CFLAGS)
CFLAGS += -I/usr/local/include -I/usr/local/include/readline $(FFI_CFLAGS)
LDFLAGS  += -L/usr/local/lib $(FFI_LDLAGS)  

SHEBANG_LANG=bash

post-install:
.for l in bin/yosys-filterlib bin/yosys bin/yosys-abc
	${STRIP_CMD} ${STAGEDIR}${PREFIX}/${l}
.endfor

.include <bsd.port.mk>
