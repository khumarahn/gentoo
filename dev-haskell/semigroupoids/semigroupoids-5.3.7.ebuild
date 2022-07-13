# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.1.1.9999
#hackport: flags: +doctests

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Semigroupoids: Category sans id"
HOMEPAGE="https://github.com/ekmett/semigroupoids"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="+comonad +containers +contravariant +distributive +tagged +unordered-containers"

RDEPEND=">=dev-haskell/base-orphans-0.8.4:=[profile?] <dev-haskell/base-orphans-1:=[profile?]
	>=dev-haskell/bifunctors-5.5.9:=[profile?] <dev-haskell/bifunctors-6:=[profile?]
	>=dev-haskell/transformers-compat-0.5:=[profile?] <dev-haskell/transformers-compat-0.8:=[profile?]
	>=dev-lang/ghc-8.4.3:=
	comonad? ( >=dev-haskell/comonad-5.0.8:=[profile?] <dev-haskell/comonad-6:=[profile?] )
	contravariant? ( >=dev-haskell/contravariant-1.5.3:=[profile?] <dev-haskell/contravariant-2:=[profile?] )
	distributive? ( >=dev-haskell/distributive-0.5.2:=[profile?] <dev-haskell/distributive-1:=[profile?] )
	tagged? ( >=dev-haskell/tagged-0.8.6.1:=[profile?] <dev-haskell/tagged-1:=[profile?] )
	unordered-containers? ( >=dev-haskell/hashable-1.2.7.0:=[profile?] <dev-haskell/hashable-1.5:=[profile?]
				>=dev-haskell/unordered-containers-0.2.8.0:=[profile?] <dev-haskell/unordered-containers-0.3:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag comonad comonad) \
		$(cabal_flag containers containers) \
		$(cabal_flag contravariant contravariant) \
		$(cabal_flag distributive distributive) \
		--flag=doctests \
		$(cabal_flag tagged tagged) \
		$(cabal_flag unordered-containers unordered-containers)
}
