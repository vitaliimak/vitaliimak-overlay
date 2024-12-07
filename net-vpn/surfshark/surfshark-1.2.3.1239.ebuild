# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit pax-utils unpacker

MY_PV="$(ver_cut 1-3)-$(ver_cut 4)_amd64"

DESCRIPTION="Surfshark VPN Linux client"
HOMEPAGE="https://surfshark.com"
SRC_URI="
	amd64? ( https://ocean.surfshark.com/debian/pool/main/s/${PN}/${PN}_${MY_PV}.deb )
"

LICENSE="SurfShark"
SLOT="0"
KEYWORDS="~amd64"
IUSE="pax_kernel"
RESTRICT="mirror strip"

RDEPEND="
	net-vpn/openvpn
	sys-libs/glibc
"
DEPEND="${RDEPEND}"
S="${WORKDIR}"

DOCS="changelog copyright"

src_unpack() {
	unpack_deb ${A}
}

src_prepare() {
	mkdir ${S}/usr/bin
	cp ${S}/opt/Surfshark/surfshark ${S}/usr/bin/
	#rm _gpgbuilder || die
	mv usr/share/doc/${PN}/* . || die
	rm -rf usr/share || die
	gunzip changelog.gz || die
	default
}

src_install() {
	dobin usr/bin/${PN}
	use pax_kernel && pax-mark -m "${ED%/}/usr/bin/${PN}"
	default
}

pkg_postinst() {
	echo
	elog "Thanks for installing SurfShark."
	elog "Don't forget to create an account and purchase a plan"
	elog "before running the SurfShark client".
	elog "See https://surfshark.com/signup for more details."
	elog "Also, you must run the ${PN} binary as root."
	echo
}

