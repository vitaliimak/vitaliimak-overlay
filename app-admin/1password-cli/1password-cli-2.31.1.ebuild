# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The world’s most-loved password manager CLI"
HOMEPAGE="https://1password.com"
SRC_URI="amd64? ( https://cache.agilebits.com/dist/1P/op2/pkg/v${PV}/op_linux_amd64_v${PV}.zip )"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"

RESTRICT="mirror strip test bindist"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="app-arch/unzip"

QA_PREBUILT="usr/bin/op"

S=${WORKDIR}

src_install() {
  dobin op
}
