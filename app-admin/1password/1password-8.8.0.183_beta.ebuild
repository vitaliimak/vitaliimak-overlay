# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV="$(ver_cut 1-3)-$(ver_cut 4).BETA.x64"
#MY_PV="${MY_PV/_BETA}"
#MY_P="${P}.x64"

DESCRIPTION="1Password command-line tool"
HOMEPAGE="
https://1password.com/
https://releases.1password.com/linux/"
#SRC_URI="https://downloads.1password.com/linux/tar/stable/x86_64/${MY_P}.tar.gz"
#SRC_URI="https://downloads.1password.com/linux/tar/beta/x86_64/1password-8.7.0-49.BETA.x64.tar.gz"
SRC_URI="https://downloads.1password.com/linux/tar/beta/x86_64/${PN}-${MY_PV}.tar.gz"

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

S="${WORKDIR}/${PN}-${MY_PV}"

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
	newins com.1password.1Password.policy.tpl com.1password.1Password.policy
#	doins com.1password.1Password.policy.tpl
}
