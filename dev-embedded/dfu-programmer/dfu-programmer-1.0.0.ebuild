# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools udev

DESCRIPTION="A Device Firmware Update based USB programmer for Atmel chips"
HOMEPAGE="
	https://dfu-programmer.github.io/
	https://sourceforge.net/projects/dfu-programmer/
	https://github.com/dfu-programmer/dfu-programmer
"

SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64"

RDEPEND="
	acct-group/plugdev
	virtual/libusb:1
	virtual/udev
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	default

	eautoreconf
}

src_install() {
	default

	cat <<-EOF > 70-dfu-programmer.rules
	#
	# do not edit this file, it will be overwritten on update
	#
	EOF
	printf 'SUBSYSTEM=="usb", ACTION=="add", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="%s", MODE="660", GROUP="plugdev", SYMLINK+="dfu-%%n"\n' \
		2ff{a,b,9,7,4,3} >> 70-dfu-programmer.rules

	udev_dorules 70-dfu-programmer.rules
}

pkg_postinst() {
	udev_reload

	elog "To update device firmware as user you must be in the plugdev group:"
	elog
	elog "usermod -aG plugdev <user>"
}

pkg_postrm() {
	udev_reload
}
