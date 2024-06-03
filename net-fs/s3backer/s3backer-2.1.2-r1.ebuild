# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="A filesystem that contains a single file backed by Amazon S3"
HOMEPAGE="https://github.com/archiecobbs/s3backer"
SRC_URI="https://github.com/archiecobbs/s3backer/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nbd"

# This patch adds --enable-nbd option in configure and removes
# installing files in /run. It is upstream and should be removed
# with the next version bump
PATCHES=( "${FILESDIR}/nbd-econf.diff" )

RDEPEND="
	dev-libs/expat
	dev-libs/openssl:0=
	net-misc/curl
	sys-fs/fuse:0
	sys-libs/zlib
	nbd? ( sys-block/nbd sys-block/nbdkit )
"
DEPEND="${RDEPEND}
	elibc_musl? ( sys-libs/queue-standalone )
"
BDEPEND="
	virtual/pkgconfig
"

src_prepare() {
	default

	sed -e "/docdir=/s:packages/\$(PACKAGE):${PF}:" \
		-e "/doc_DATA=/d" \
		-i Makefile.am || die

	eautoreconf
}

src_configure() {
	econf $(use_enable nbd)
}

#src_compile() {
#	emake CFLAGS="${CFLAGS}"
#}
