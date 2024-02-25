# qt-experiments

## Qt 5.15 static build instructions for Linux:

### Ubuntu 16.04

Install requirements:

    sudo apt update
    sudo apt upgrade
    
    sudo apt install git p7zip-full qtcreator
    
    sudo apt install libgl1-mesa-dev libglu1-mesa-dev mesa-common-dev libglu1-mesa-dev libdrm-dev libxdamage-dev libglapi-mesa libglapi-mesa libxext6 libxxf86vm-dev libc6-dev libssl-dev libfontconfig1-dev libfreetype6-dev libx11-dev libx11-xcb-dev libxext-dev libxfixes-dev libxi-dev libxrender-dev libxcb1-dev libxcb-glx0-dev libxcb-keysyms1-dev libxcb-image0-dev libxcb-shm0-dev libxcb-icccm4-dev libxcb-sync-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-randr0-dev libxcb-render-util0-dev libxcb-util-dev libxcb-xinerama0 libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev libpulse-dev libasound2-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libwayland-dev

Clone Qt 5.15:

    git clone -b 5.15 https://code.qt.io/qt/qt5.git
    mv qt5 Qt-5.15
    cd Qt-5.15
    git clone -b 5.15 https://code.qt.io/qt/qtbase.git

Or:

    wget http://danields966.ru:9724/Qt-5.15.7z
    7z x Qt-5.15.7z
    cd Qt-5.15

Apply patch to remove xinerama:

    cd ..
    git clone -b testing https://github.com/danields966/qt-experiments.git
    cp qt-experiments/remove-xinerama.patch Qt-5.15/qtbase/
    cd Qt-5.15/qtbase
    git apply remove-xinerama.patch
    cd ..

Compile Qt:

    git submodule foreach --recursive "git clean -dfx"
    
    ./configure -v -prefix "/usr/local/Qt-5.15-release" -platform linux-g++-64 -no-avx -c++std c++14 -static -optimize-size -release -opensource -confirm-license -fontconfig -system-freetype -bundled-xcb-xinput -nomake examples -nomake tests -nomake tools -no-cups -no-dbus -no-gif -no-iconv -no-icu -no-opengl -no-openssl -no-openvg -no-pch -no-sql-sqlite -make libs -qt-harfbuzz -qt-libjpeg -qt-libpng -qt-pcre -qt-zlib -skip wayland -skip qt3d -skip qtactiveqt -skip qtandroidextras -skip qtcharts -skip qtconnectivity -skip qtdatavis3d -skip qtdeclarative -skip qtdoc -skip qtdocgallery -skip qtfeedback -skip qtgamepad -skip qtgraphicaleffects -skip qtimageformats -skip qtlocation -skip qtlottie -skip qtmacextras -skip qtmultimedia -skip qtnetworkauth -skip qtpim -skip qtpurchasing -skip qtqa -skip qtquick3d -skip qtquickcontrols -skip qtquickcontrols2 -skip qtquicktimeline -skip qtremoteobjects -skip qtrepotools -skip qtscript -skip qtscxml -skip qtsensors -skip qtserialbus -skip qtserialport -skip qtspeech -skip qtsvg -skip qtsystems -skip qttools -skip qttranslations -skip qtvirtualkeyboard -skip qtwayland -skip qtwebchannel -skip qtwebengine -skip qtwebglplugin -skip qtwebsockets -skip qtwebview -skip qtwinextras -skip qtx11extras -skip qtxmlpatterns
    
    make
    sudo rm -rf /usr/local/Qt-5.15-release/
    sudo make install

For 32-bit just replace configure argument `-platform linux-g++-64` to `-platform linux-g++-32`

Example of shared requirements of compiled binary with this setup:

    ldd qt-experiments

Output:

	linux-vdso.so.1 (0x00007ffffdff5000)
	libfontconfig.so.1 => /usr/lib/x86_64-linux-gnu/libfontconfig.so.1 (0x00007fcd924e2000)
	libfreetype.so.6 => /usr/lib/x86_64-linux-gnu/libfreetype.so.6 (0x00007fcd9222e000)
	libxcb-icccm.so.4 => /usr/lib/x86_64-linux-gnu/libxcb-icccm.so.4 (0x00007fcd92029000)
	libxcb-image.so.0 => /usr/lib/x86_64-linux-gnu/libxcb-image.so.0 (0x00007fcd91e24000)
	libxcb-shm.so.0 => /usr/lib/x86_64-linux-gnu/libxcb-shm.so.0 (0x00007fcd91c21000)
	libxcb-keysyms.so.1 => /usr/lib/x86_64-linux-gnu/libxcb-keysyms.so.1 (0x00007fcd91a1e000)
	libxcb-randr.so.0 => /usr/lib/x86_64-linux-gnu/libxcb-randr.so.0 (0x00007fcd9180e000)
	libxcb-render-util.so.0 => /usr/lib/x86_64-linux-gnu/libxcb-render-util.so.0 (0x00007fcd9160a000)
	libxcb-render.so.0 => /usr/lib/x86_64-linux-gnu/libxcb-render.so.0 (0x00007fcd913fd000)
	libxcb-shape.so.0 => /usr/lib/x86_64-linux-gnu/libxcb-shape.so.0 (0x00007fcd911f9000)
	libxcb-sync.so.1 => /usr/lib/x86_64-linux-gnu/libxcb-sync.so.1 (0x00007fcd90ff2000)
	libxcb-xfixes.so.0 => /usr/lib/x86_64-linux-gnu/libxcb-xfixes.so.0 (0x00007fcd90dea000)
	libxcb-xkb.so.1 => /usr/lib/x86_64-linux-gnu/libxcb-xkb.so.1 (0x00007fcd90bce000)
	libxcb.so.1 => /usr/lib/x86_64-linux-gnu/libxcb.so.1 (0x00007fcd909a6000)
	libxkbcommon-x11.so.0 => /usr/lib/x86_64-linux-gnu/libxkbcommon-x11.so.0 (0x00007fcd9079e000)
	libxkbcommon.so.0 => /usr/lib/x86_64-linux-gnu/libxkbcommon.so.0 (0x00007fcd9055f000)
	libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007fcd9035b000)
	libglib-2.0.so.0 => /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0 (0x00007fcd90044000)
	libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007fcd8fe25000)
	libstdc++.so.6 => /usr/lib/x86_64-linux-gnu/libstdc++.so.6 (0x00007fcd8fa9c000)
	libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007fcd8f6fe000)
	libgcc_s.so.1 => /lib/x86_64-linux-gnu/libgcc_s.so.1 (0x00007fcd8f4e6000)
	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fcd8f0f5000)
	/lib64/ld-linux-x86-64.so.2 (0x00007fcd93526000)
	libexpat.so.1 => /lib/x86_64-linux-gnu/libexpat.so.1 (0x00007fcd8eec3000)
	libpng16.so.16 => /usr/lib/x86_64-linux-gnu/libpng16.so.16 (0x00007fcd8ec91000)
	libz.so.1 => /lib/x86_64-linux-gnu/libz.so.1 (0x00007fcd8ea74000)
	libxcb-util.so.1 => /usr/lib/x86_64-linux-gnu/libxcb-util.so.1 (0x00007fcd8e86e000)
	libXau.so.6 => /usr/lib/x86_64-linux-gnu/libXau.so.6 (0x00007fcd8e66a000)
	libXdmcp.so.6 => /usr/lib/x86_64-linux-gnu/libXdmcp.so.6 (0x00007fcd8e464000)
	libpcre.so.3 => /lib/x86_64-linux-gnu/libpcre.so.3 (0x00007fcd8e1f3000)
	libbsd.so.0 => /lib/x86_64-linux-gnu/libbsd.so.0 (0x00007fcd8dfde000)
	librt.so.1 => /lib/x86_64-linux-gnu/librt.so.1 (0x00007fcd8ddd6000)

## Qt 5.15 static build instructions for Windows 11 (MinGW 8.1.0):

Install the following requirements:

* 7-Zip 19.00
* Git 2.37.1
* Python 3.7.9
* Strawberry Perl 5.26.0.1

Clone Qt 5.15:

    git clone -b 5.15 https://code.qt.io/qt/qt5.git
    ren qt5 "Qt-5.15"
    cd Qt-5.15
    git clone -b 5.15 https://code.qt.io/qt/qtbase.git
    cd ..

Or:

    $ProgressPreference = "SilentlyContinue"
    $QtDistro = "Qt-5.15"
    $QtDistro7z = "$QtDistro.7z"
    Invoke-WebRequest "http://danields966.ru:9724/$QtDistro7z" -OutFile "$QtDistro7z"
    & 'C:\Program Files\7-Zip\7z.exe' x $QtDistro7z -o"."

Download and add MinGW distro to PATH:

32-bit:

    $ProgressPreference = "SilentlyContinue"
    $MinGWDistro7z = "i686-8.1.0-release-posix-dwarf-rt_v6-rev0.7z"
    Invoke-WebRequest "http://danields966.ru:9724/$MinGWDistro7z" -OutFile "$MinGWDistro7z"
    & 'C:\Program Files\7-Zip\7z.exe' x $MinGWDistro7z -o"."
    $env:PATH = "$PWD\mingw32\bin;" + $env:PATH

64-bit:

    $ProgressPreference = "SilentlyContinue"
    $MinGWDistro7z = "x86_64-8.1.0-release-posix-seh-rt_v6-rev0.7z"
    Invoke-WebRequest "http://danields966.ru:9724/$MinGWDistro7z" -OutFile "$MinGWDistro7z"
    & 'C:\Program Files\7-Zip\7z.exe' x $MinGWDistro7z -o"."
    $env:PATH = "$PWD\mingw64\bin;" + $env:PATH

Compile Qt:

    cd Qt-5.15
    git submodule foreach --recursive "git clean -dfx"
    
    ./configure -v -prefix "C:\Qt\Qt-5.15-debug-and-release" -platform win32-g++ -no-avx -c++std c++14 -static -optimize-size -static-runtime -debug-and-release -opensource -confirm-license -nomake examples -nomake tests -nomake tools -no-angle -no-cups -no-dbus -no-fontconfig -no-gif -no-iconv -no-icu -no-incredibuild-xge -no-opengl -no-openssl -no-openvg -no-pch -no-sql-sqlite -no-ssl -make libs -qt-freetype -qt-harfbuzz -qt-libjpeg -qt-libpng -qt-pcre -qt-zlib -skip qt3d -skip qtactiveqt -skip qtandroidextras -skip qtcharts -skip qtconnectivity -skip qtdatavis3d -skip qtdeclarative -skip qtdoc -skip qtdocgallery -skip qtfeedback -skip qtgamepad -skip qtgraphicaleffects -skip qtimageformats -skip qtlocation -skip qtlottie -skip qtmacextras -skip qtmultimedia -skip qtnetworkauth -skip qtpim -skip qtpurchasing -skip qtqa -skip qtquick3d -skip qtquickcontrols -skip qtquickcontrols2 -skip qtquicktimeline -skip qtremoteobjects -skip qtrepotools -skip qtscript -skip qtscxml -skip qtsensors -skip qtserialbus -skip qtserialport -skip qtspeech -skip qtsvg -skip qtsystems -skip qttools -skip qttranslations -skip qtvirtualkeyboard -skip qtwayland -skip qtwebchannel -skip qtwebengine -skip qtwebglplugin -skip qtwebsockets -skip qtwebview -skip qtwinextras -skip qtx11extras -skip qtxmlpatterns
    
    mingw32-make
    mingw32-make install