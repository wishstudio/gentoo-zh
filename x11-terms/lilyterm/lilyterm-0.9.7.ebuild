# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit versionator autotools

MY_P=${PN}-$(replace_version_separator 3 '~')

DESCRIPTION="A light and easy to use libvte based X Terminal Emulator"
HOMEPAGE="http://lilyterm.luna.com.tw"
SRC_URI="${HOMEPAGE}/file/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND=">=x11-libs/gtk+-2.10
	>=x11-libs/vte-0.13
	>=dev-libs/glib-2.14"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

S=${WORKDIR}/${MY_P}
RESTRICT="mirror"

src_prepare() {
	sed -e '/examplesdir/s/\$(PACKAGE)/&-\${PV}/' \
		-i data/Makefile.am || die "sed failed"

	./autogen.sh || die "autogen.sh failed with exit code $?"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README TODO || die "dodoc failed"
}
