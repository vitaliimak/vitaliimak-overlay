# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_P="${P}.x64"

DESCRIPTION="1Password command-line tool"
HOMEPAGE="
https://1password.com/
https://releases.1password.com/linux/"
SRC_URI="https://downloads.1password.com/linux/tar/stable/x86_64/${MY_P}.tar.gz"

LICENSE="1password"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RESTRICT="primaryuri strip"

DEPEND="
	dev-libs/nss
	sys-auth/polkit
	x11-libs/gtk+:3
	x11-libs/libXScrnSaver"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_install() {
	insinto "/opt/${PN}"
	doins -r *

	fperms 0775 "/opt/${PN}/${PN}"
	dosym "/opt/${PN}/${PN}" "/usr/bin/${PN}"

#	if use examples ; then
#		dodir /usr/share/doc/${PN}/
#		cp "${S}"/resources/custom_allowed_browsers "${S}"/usr/share/doc/${PN}/ || die
#	fi

	insinto /usr/share/polkit-1/actions
	doins com.1password.1Password.policy
}
