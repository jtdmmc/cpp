cmake_minimum_required(VERSION 3.16)

project(QtDemo VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick REQUIRED)


#资源文件
set(CMAKE_AUTORCC ON) # 这个要写上
set(QRC_FILE resources/resource.qrc) # 可能有多个QRC文件，我这里就写了一个，这行是把所有的QRC文件名赋值给 QRC_FILE变量（变量名自己取）
qt_add_resources(QRC ${QRC_FILE}) # 用这个函数把这些QRC文件添加进来

#源文件
# 查找指定目录下的所有.cpp与.h文件 并存放到指定变量名SRCS中
file(GLOB SRCS "${CMAKE_SOURCE_DIR}/src/*.cpp" "${CMAKE_SOURCE_DIR}/src/*.h")
qt_add_executable(appQtDemo
    main.cpp
    ${SRCS}
    ${QRC}
)

#QML文件
qt_add_qml_module(appQtDemo
    URI QtDemo
    VERSION 1.0
    QML_FILES
    main.qml
    components/TabControlD.qml
    components/TabControlS.qml
    components/MyButton.qml
    components/MyText.qml
    views/ComponentsDemo.qml
    views/MvdDemo.qml
    views/TabControlSDemo.qml
    views/CppExtensionDemo1.qml
    views/CppExtensionDemo2.qml
    views/3DDemo.qml
    views/ShaderDemo.qml
)

set_target_properties(appQtDemo PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_compile_definitions(appQtDemo
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(appQtDemo
    PRIVATE Qt6::Quick)
