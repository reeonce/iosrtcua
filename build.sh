#!/bin/bash

export DEVPATH=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer
ARCHS="i386 x86_64"
for arch in $ARCHS
do
  ARCH="-arch $arch" CFLAGS="-O2 -m32 -mios-simulator-version-min=5.0" LDFLAGS="-O2 -m32 -mios-simulator-version-min=5.0" ./configure-iphone
  make dep && make clean && make
done

export DEVPATH=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer
ARCHS="armv7 armv7s arm64"

for arch in $ARCHS
do
  ARCH="-arch $arch" ./configure-iphone
  make dep && make clean && make
done

LIBS="pjlib/lib/libpj pjlib-util/lib/libpjlib-util pjnath/lib/libpjnath pjmedia/lib/libpjmedia pjmedia/lib/libpjsdp pjmedia/lib/libpjmedia-codec pjmedia/lib/libpjmedia-audiodev third_party/lib/libsrtp"

rm -rf ios_libs;
mkdir ios_libs;
for lib in $LIBS
do
  outputlib="${lib}-apple-darwin_ios.a";
  libtool -o $outputlib ${lib}-i386-apple-darwin_ios.a ${lib}-x86_64-apple-darwin_ios.a ${lib}-armv7-apple-darwin_ios.a ${lib}-armv7s-apple-darwin_ios.a ${lib}-arm64-apple-darwin_ios.a

  libname=$(basename $outputlib);
  cp $outputlib ios_libs/${libname};
done

# projectPath="$HOME/workspace/myproject"
# HEADERS="pjlib pjlib-util pjnath pjmedia"
# for header in $HEADERS; do cp -r $header/include $projectPath/iosrtcua/headers/$header; done
