SUMMARY = "Settings"

SRC_URI = "git://git@github.com/Intel-BMC/provingground.git;protocol=ssh"
SRCREV = "4611d8dcba0c0dc92156bbafdb50607aaff122ab"
PV = "0.1+git${SRCPV}"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${INTELBASE}/COPYING.apache-2.0;md5=34400b68072d710fecd0a2940a0d1658"

SYSTEMD_SERVICE_${PN} = "settings.service"

DEPENDS = "boost \
           nlohmann-json \
           sdbusplus"

S = "${WORKDIR}/git/settings"
inherit cmake systemd

EXTRA_OECMAKE = "-DYOCTO=1"
