FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
PROJECT_SRC_DIR := "${THISDIR}/${PN}"

SRC_URI = "git://github.com/openbmc/phosphor-host-ipmid"
SRCREV = "ebc53cb165ea26aa48f0bbf01d9bce0e4abb0b7d"

SRC_URI += "file://phosphor-ipmi-host.service \
            file://host-ipmid-whitelist.conf \
            file://0010-fix-get-system-GUID-ipmi-command.patch \
            file://0053-Fix-keep-looping-issue-when-entering-OS.patch \
            file://0056-add-SetInProgress-to-get-set-boot-option-cmd.patch \
            file://0059-Move-Set-SOL-config-parameter-to-host-ipmid.patch \
            file://0060-Move-Get-SOL-config-parameter-to-host-ipmid.patch \
            file://0062-Update-IPMI-Chassis-Control-command.patch \
            file://0063-Save-the-pre-timeout-interrupt-in-dbus-property.patch \
            file://0064-Update-provisioning-mode-filter-logic.patch \
            file://0001-Modify-Get-Lan-Configuration-IP-Address-Source-to-us.patch \
            file://0002-Fixed-issue-in-setLan-command-for-IP-source.patch \
            file://0003-Fix-for-return-CC-in-setLan-command-cases.patch \
            "

EXTRA_OECONF_append = " --disable-i2c-whitelist-check"
EXTRA_OECONF_append = " --enable-transport-oem=yes"
EXTRA_OECONF_append = " --disable-boot-flag-safe-mode-support"

RDEPENDS_${PN}_remove = "clear-once"

# remove the softpoweroff service since we do not need it
SYSTEMD_SERVICE_${PN}_remove += " \
    xyz.openbmc_project.Ipmi.Internal.SoftPowerOff.service"

SYSTEMD_LINK_${PN}_remove += " \
    ../xyz.openbmc_project.Ipmi.Internal.SoftPowerOff.service:obmc-host-shutdown@0.target.requires/xyz.openbmc_project.Ipmi.Internal.SoftPowerOff.service \
    "
FILES_${PN}_remove = " \
    ${systemd_unitdir}/system/obmc-host-shutdown@0.target.requires/ \
    ${systemd_unitdir}/system/obmc-host-shutdown@0.target.requires/xyz.openbmc_project.Ipmi.Internal.SoftPowerOff.service \
    "

do_configure_append(){
    cp -f ${WORKDIR}/host-ipmid-whitelist.conf ${S}
}

do_compile_prepend(){
    cp -f ${PROJECT_SRC_DIR}/transporthandler_oem.cpp ${S}
}

do_install_append(){
    rm -f ${D}/${bindir}/phosphor-softpoweroff
    rm -f ${S}/transporthandler_oem.cpp
}
