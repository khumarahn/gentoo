# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
EGO_PN="github.com/docker/libnetwork"

if [[ ${PV} == *9999 ]]; then
	inherit golang-vcs
else
	EGIT_COMMIT=5c6a95bfb20c61571a00f913c6b91959ede84e8d
	SRC_URI="https://github.com/docker/libnetwork/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"
	inherit golang-vcs-snapshot
fi

DESCRIPTION="Docker container networking"
HOMEPAGE="https://github.com/docker/libnetwork"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

S=${WORKDIR}/${P}/src/${EGO_PN}

# needs dockerd
RESTRICT="strip test"

src_compile() {
	GOPATH="${WORKDIR}/${P}" go build -o "bin/docker-proxy" ./cmd/proxy || die
}

src_install() {
	dodoc README.md CHANGELOG.md
	dobin bin/docker-proxy
}
