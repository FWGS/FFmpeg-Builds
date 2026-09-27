ARG GH_REPO=ghcr.io/fwgs/ffmpeg-builds
ARG BASE_TAG_SUFFIX=
FROM $GH_REPO/base:latest${BASE_TAG_SUFFIX}

ARG NDK_VERSION=r30
ARG NDK_SHA1=5107f898313790e449e87eee2183d9a20602dee9

RUN \
    retry-tool wget -q -O /ndk.zip "https://dl.google.com/android/repository/android-ndk-${NDK_VERSION}-linux.zip" && \
    echo "${NDK_SHA1}  /ndk.zip" | sha1sum -c && \
    unzip -q /ndk.zip -d /opt && \
    rm /ndk.zip && \
    mv /opt/android-ndk-${NDK_VERSION} /opt/android-ndk && \
    cd /opt/android-ndk && \
    rm -rf prebuilt python-packages shader-tools simpleperf

ENV FFBUILD_TOOLCHAIN=arm-linux-androideabi \
    FFBUILD_CLANG_TRIPLE=armv7a-linux-androideabi \
    FFBUILD_ANDROID_ABI=armeabi-v7a \
    FFBUILD_ANDROID_API=21 \
    FFBUILD_RUST_TARGET=armv7-linux-androideabi \
    ANDROID_NDK_HOME=/opt/android-ndk \
    ANDROID_NDK_ROOT=/opt/android-ndk

# Provide traditional, unversioned cross-toolchain names on top of the NDK
RUN \
    cd /opt/android-ndk/toolchains/llvm/prebuilt/linux-x86_64/bin && \
    ln -s "${FFBUILD_CLANG_TRIPLE}${FFBUILD_ANDROID_API}-clang" "${FFBUILD_TOOLCHAIN}-clang" && \
    ln -s "${FFBUILD_CLANG_TRIPLE}${FFBUILD_ANDROID_API}-clang++" "${FFBUILD_TOOLCHAIN}-clang++" && \
    ln -s ld.lld "${FFBUILD_TOOLCHAIN}-ld" && \
    for t in ar nm ranlib strip objcopy objdump readelf size strings addr2line; do \
        ln -s "llvm-$t" "${FFBUILD_TOOLCHAIN}-$t"; \
    done && \
    mkdir /opt/ffbuild

ADD toolchain.cmake /toolchain.cmake
ADD cross.meson /cross.meson

ENV PATH="/opt/android-ndk/toolchains/llvm/prebuilt/linux-x86_64/bin:${PATH}" \
    FFBUILD_TARGET_FLAGS="--pkg-config=pkg-config --cross-prefix=${FFBUILD_TOOLCHAIN}- --enable-cross-compile --enable-pic --arch=arm --cpu=armv7-a --enable-neon --target-os=android" \
    FFBUILD_CROSS_PREFIX="${FFBUILD_TOOLCHAIN}-" \
    FFBUILD_PREFIX=/opt/ffbuild \
    FFBUILD_DESTDIR=/opt/ffdest \
    FFBUILD_DESTPREFIX=/opt/ffdest/opt/ffbuild \
    FFBUILD_CMAKE_TOOLCHAIN=/toolchain.cmake \
    PKG_CONFIG=pkg-config \
    PKG_CONFIG_LIBDIR=/opt/ffbuild/lib/pkgconfig:/opt/ffbuild/share/pkgconfig \
    CC="${FFBUILD_TOOLCHAIN}-clang" \
    CXX="${FFBUILD_TOOLCHAIN}-clang++" \
    LD="${FFBUILD_TOOLCHAIN}-ld" \
    AR="${FFBUILD_TOOLCHAIN}-ar" \
    RANLIB="${FFBUILD_TOOLCHAIN}-ranlib" \
    NM="${FFBUILD_TOOLCHAIN}-nm" \
    STRIP="${FFBUILD_TOOLCHAIN}-strip" \
    CFLAGS="-I/opt/ffbuild/include -O2 -pipe -fPIC -DPIC -D_FORTIFY_SOURCE=2 -fstack-protector-strong" \
    CXXFLAGS="-I/opt/ffbuild/include -O2 -pipe -fPIC -DPIC -D_FORTIFY_SOURCE=2 -fstack-protector-strong -static-libstdc++" \
    LDFLAGS="-L/opt/ffbuild/lib -O2 -pipe -fstack-protector-strong -Wl,-z,relro,-z,now -static-libstdc++" \
    STAGE_CFLAGS="-fvisibility=hidden" \
    STAGE_CXXFLAGS="-fvisibility=hidden"
