FROM jlesage/baseimage-gui:debian-11-v4.5.3

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008
RUN set -x && \
    TEMP_PACKAGES=() && \
    KEPT_PACKAGES=() && \

    # General tools to get and build packages
    TEMP_PACKAGES+=(build-essential) && \
    TEMP_PACKAGES+=(automake) && \
    TEMP_PACKAGES+=(autoconf) && \
    KEPT_PACKAGES+=(ca-certificates) && \
    TEMP_PACKAGES+=(cmake) && \
    TEMP_PACKAGES+=(git) && \
    TEMP_PACKAGES+=(pkg-config) && \

   # dependencies for rtl-sdr
    TEMP_PACKAGES+=(libusb-1.0-0-dev) && \
    KEPT_PACKAGES+=(libusb-1.0-0) && \

    # Dependencies for SDRReceiver
    KEPT_PACKAGES+=(curl) && \
    TEMP_PACKAGES+=(qtmultimedia5-dev) && \
    KEPT_PACKAGES+=(libqt5multimedia5-plugins) && \
    KEPT_PACKAGES+=(libqt5svg5) && \
    TEMP_PACKAGES+=(libqt5svg5-dev) && \
    KEPT_PACKAGES+=(libqt5sql5) && \
    KEPT_PACKAGES+=(libqt5sql5-sqlite) && \
    TEMP_PACKAGES+=(qtbase5-dev) && \
    KEPT_PACKAGES+=(qtchooser) && \
    TEMP_PACKAGES+=(qt5-qmake) && \
    TEMP_PACKAGES+=(qtbase5-dev-tools) && \
    TEMP_PACKAGES+=(libcpputest-dev) && \
    KEPT_PACKAGES+=(cpputest) && \
    TEMP_PACKAGES+=(libzmq3-dev) && \
    KEPT_PACKAGES+=(libzmq5) && \
    TEMP_PACKAGES+=(libvorbis-dev) && \
    KEPT_PACKAGES+=(libvorbisfile3) && \
    TEMP_PACKAGES+=(libogg-dev) && \
    KEPT_PACKAGES+=(libogg0) && \
    TEMP_PACKAGES+=(libqcustomplot-dev) && \
    KEPT_PACKAGES+=(libqcustomplot2.0) && \
    TEMP_PACKAGES+=(wget) && \
    KEPT_PACKAGES+=(unzip) && \

    apt-get update && \
    apt-get install -y --no-install-recommends \
        "${KEPT_PACKAGES[@]}" \
        "${TEMP_PACKAGES[@]}" \
        && \

    # RTLSDR - Clone and build

    git clone --branch master --depth 1 --single-branch https://gitea.osmocom.org/sdr/rtl-sdr.git /src/rtl-sdr && \
    mkdir -p /src/rtl-sdr/build && \
    pushd /src/rtl-sdr/build && \
    git rev-parse HEAD > /CONTAINER_VERSION && \
    cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DDETACH_KERNEL_DRIVER=ON \
    -DINSTALL_UDEV_RULES=ON \
    ../ \
    && \
    make -j "$(nproc)" && \
    make install && \
    popd && \
    ldconfig && \

    # SDRReceiver
    git clone --depth 1 --single-branch https://github.com/jeroenbeijer/SDRReceiver.git /src/sdrreceiver && \
    pushd /src/sdrreceiver && \
    qmake && \
    make -j "$(nproc)" && \
    make install && \
    popd && \
    ldconfig && \

    # Clean up
    apt-get remove -y "${TEMP_PACKAGES[@]}" && \
    apt-get autoremove -y && \
    rm -rf /src/* /tmp/* /var/lib/apt/lists/* && \
    find /var/log -type f -exec truncate --size=0 {} \; && \

    set-cont-env APP_NAME "SDRReceiver"

EXPOSE 5800 5900 6003

COPY rootfs/ /
