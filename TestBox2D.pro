QT += quick

CONFIG +=  c++1z

DEFINES += QT_DEPRECATED_WARNINGS

SOURCES += \
        gamecontroller.cpp \
        imageprovider.cpp \
        main.cpp

HEADERS += \
    gamecontroller.hpp \
    imageprovider.hpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

INCLUDEPATH += ../qml-box2d/Box2D
include(../qml-box2d/box2d-static.pri)

ANDROID_ABIS = armeabi-v7a

