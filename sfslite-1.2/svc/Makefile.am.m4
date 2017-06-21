dnl $Id: Makefile.am.m4 1754 2006-05-19 20:59:19Z max $
dnl
dnl Process this file with GNU m4 to get Makefile.am.
dnl (Using m4 greatly simplifies the rules for autogenerated RPC files.)
dnl
## Process this file with automake to produce Makefile.in
## Do not edit this file directly.  It is generated from Makefile.am.m4

noinst_HEADERS = 

sfslib_LTLIBRARIES = libsvc.la

dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl
dnl                                                                 dnl
dnl                MACROS FOR AUTOGENERATED RPC FILES               dnl
dnl                                                                 dnl
dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl

SUFFIXES = .x .C .h
.x.h:
	-$(RPCC) -h -DSFSSVC $< || rm -f $@
.x.C:
	-$(RPCC) -c -DSFSSVC $< || rm -f $@
$(RPCC):
	@:

define(`rpcmk_xfiles',)dnl
define(`rpcmk_headers',)dnl
define(`rpcmk_sources',)dnl
define(`rpcmk_built', `rpcmk_headers rpcmk_sources')dnl
define(`rpcmk',
changequote([[, ]])dnl
[[dnl
define(`rpcmk_xfiles', rpcmk_xfiles $1.x)dnl
define(`rpcmk_headers', rpcmk_headers $1.h)dnl
define(`rpcmk_sources', rpcmk_sources $1.C)dnl
$1.h: $1.x # $(RPCC)
$1.C: $1.x # $(RPCC)
$1.o: $1.h
$1.lo: $1.h
]]changequote)dnl

dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl
dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl

rpcmk(nfs_prot)
rpcmk(nfs3_prot)
rpcmk(nfs3exp_prot)
rpcmk(nfs3close_prot)
rpcmk(mount_prot)
rpcmk(sfs_prot)
rpcmk(sfsauth_prot)
rpcmk(sfsagent)
rpcmk(sfscd_prot)
rpcmk(nfsmounter)
rpcmk(rex_prot)
rpcmk(auth_helper_prot)
rpcmk(test_arpc_prot)

nfs3_prot.h: nfs3_ext.x
nfs3exp_prot.o nfs3exp_prot.lo: nfs3_prot.h
sfscd_prot.o sfscd_prot.lo: nfsmounter.h

if UVFS
uvfs_prot.x: 
	$(LN_S) $(top_srcdir)/uvfs/common/uvfs_prot.x .
	-$(RPCC) -h -DSFSSVC uvfs_prot.x || rm -f uvfs_prot.h
uvfs_prot.o uvfs_prot.lo: uvfs_prot.h
UVFS_CFILES = uvfs_prot.C
UVFS_HFILES = uvfs_prot.h
else
uvfs_prot.x: 
	@:
UVFS_CFILES =
UVFS_HFILES =
uvfs_prot.h:
	@rm -f uvfs_prot.x
	@: > $@
uvfs_prot.C:
	@rm -f uvfs_prot.x
	@: > $@
endif

$(DEP_FILES): rpcmk_headers

EXTRA_DIST = Makefile.am.m4 .cvsignore
libsvc_la_SOURCES = rpcmk_sources $(UVFS_CFILES)

sfsinclude_HEADERS = rpcmk_xfiles nfs3_ext.x rpcmk_headers $(UVFS_HFILES)

if REPO
svc_repo_OBJECTS = $(libsvc_la_OBJECTS) \
	$(LIBSFSCRYPT) $(LIBARPC) $(LIBASYNC)
stamp-svc-repo: $(svc_repo_OBJECTS)
	-$(CXXLINK) $(svc_repo_OBJECTS)
	@rm -f a.out
	touch $@
libsvc_la_DEPENDENCIES = stamp-svc-repo uvfs_prot.h
else
libsvc_la_DEPENDENCIES = uvfs_prot.h
endif

dist-hook:
	cd $(distdir) && rm -f rpcmk_built uvfs_prot.x uvfs_prot.h uvfs_prot.C

.PHONY: rpcclean
rpcclean:
	rm -f rpcmk_built

CLEANFILES = core *.core *~ *.rpo stamp-svc-repo rpcmk_built \
		uvfs_prot.x uvfs_prot.h uvfs_prot.C
MAINTAINERCLEANFILES = Makefile.in Makefile.am

$(srcdir)/Makefile.am: $(srcdir)/Makefile.am.m4
	@rm -f $(srcdir)/Makefile.am~
	$(M4) $(srcdir)/Makefile.am.m4 > $(srcdir)/Makefile.am~
	mv -f $(srcdir)/Makefile.am~ $(srcdir)/Makefile.am
