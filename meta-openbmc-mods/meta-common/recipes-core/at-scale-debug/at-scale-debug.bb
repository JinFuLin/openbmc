inherit obmc-phosphor-systemd

SUMMARY = "At Scale Debug Service"
DESCRIPTION = "At Scale Debug Service exposes remote JTAG target debug capabilities"

LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://LICENSE;md5=0d1c657b2ba1e8877940a8d1614ec560"


inherit cmake
DEPENDS = "sdbusplus openssl libpam"

do_configure[depends] += "virtual/kernel:do_shared_workdir"

SRC_URI = "git://github.com/Intel-BMC/at-scale-debug;protocol=ssh"

SRCREV = "acf016bebe2cada610eb4aab7b97fdcd03e2200d"
S = "${WORKDIR}/git"

SYSTEMD_SERVICE_${PN} += "com.intel.AtScaleDebug.service"

# Specify any options you want to pass to cmake using EXTRA_OECMAKE:
EXTRA_OECMAKE = "-DBUILD_UT=OFF"

CFLAGS_append = " -I ${STAGING_KERNEL_DIR}/include/uapi"
CFLAGS_append = " -I ${STAGING_KERNEL_DIR}/include/"
