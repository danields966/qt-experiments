QT += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++14

SOURCES += \
    src/main.cpp \
    src/lineedits/lineedits.cpp \
    src/calculator/button.cpp \
    src/calculator/calculator.cpp \
    src/dragdroprobot/coloritem.cpp \
    src/dragdroprobot/robot.cpp \
    src/hexeditor/hexwindow.cpp \
    src/hexeditor/optionsdialog.cpp \
    src/hexeditor/searchdialog.cpp \
    src/hexeditor/qhexedit/qhexedit.cpp \
    src/hexeditor/qhexedit/chunks.cpp \
    src/hexeditor/qhexedit/commands.cpp

HEADERS += \
    src/main.h \
    src/lineedits/lineedits.h \
    src/calculator/button.h \
    src/calculator/calculator.h \
    src/dragdroprobot/coloritem.h \
    src/dragdroprobot/robot.h \
    src/hexeditor/hexwindow.h \
    src/hexeditor/optionsdialog.h \
    src/hexeditor/searchdialog.h \
    src/hexeditor/qhexedit/qhexedit.h \
    src/hexeditor/qhexedit/chunks.h \
    src/hexeditor/qhexedit/commands.h

RESOURCES = \
    src/hexeditor/qhexedit.qrc

FORMS += \
    src/hexeditor/optionsdialog.ui \
    src/hexeditor/searchdialog.ui

GO_SOURCE_PATH = "$$PWD/goLib/goLib.go"
GO_LIB_PATH = "$$PWD/goLib/goLib.a"
win32 {
    GOOS = "windows"
}
linux {
    GOOS = "linux"
}
macx {
    GOOS = "darwin"
}
contains(QT_ARCH, i386) {
    GOARCH = "386"
} else {
    contains(QT_ARCH, arm64) {
        GOARCH = "arm64"
    } else {
        GOARCH = "amd64"
    }
}

system(GOOS=$${GOOS} GOARCH=$${GOARCH} go build -o $${GO_LIB_PATH} -buildmode c-archive $${GO_SOURCE_PATH})
exists($${GO_LIB_PATH}) {
    LIBS += $${GO_LIB_PATH}
    DEFINES += GOLANG_LIB=1
} else {
    message("Skipping Golang library for build")
}

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
