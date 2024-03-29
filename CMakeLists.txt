cmake_minimum_required(VERSION 3.5)

project(provodnik VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Widgets Positioning Sql Qml Quick Location)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Widgets Positioning Sql Qml Quick Location)

set(PROJECT_SOURCES
    main.cpp


    database_manager.h
    database_manager.cpp
    map_manager.h
    map_manager.cpp
    main.qml
)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(provodnik
        MANUAL_FINALIZATION
        ${PROJECT_SOURCES}

        qml.qrc

    )
else()
    if(ANDROID)
        add_library(provodnik SHARED
            ${PROJECT_SOURCES}
        )
    else()
        add_executable(provodnik
            ${PROJECT_SOURCES}
        )
    endif()
endif()

target_link_libraries(provodnik PRIVATE Qt${QT_VERSION_MAJOR}::Widgets Qt${QT_VERSION_MAJOR}::Sql Qt${QT_VERSION_MAJOR}::Qml Qt${QT_VERSION_MAJOR}::Positioning Qt${QT_VERSION_MAJOR}::Quick Qt${QT_VERSION_MAJOR}::Location)  # Добавляем Positioning

if(QT_VERSION_MAJOR EQUAL 6)
    qt_finalize_executable(provodnik)
endif()

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
if(${QT_VERSION} VERSION_LESS 6.1.0)
  set(BUNDLE_ID_OPTION MACOSX_BUNDLE_GUI_IDENTIFIER com.example.provodnik)
endif()
set_target_properties(provodnik PROPERTIES
    ${BUNDLE_ID_OPTION}
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

include(GNUInstallDirs)
install(TARGETS provodnik
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

if(QT_VERSION_MAJOR EQUAL 6)
    qt_finalize_executable(provodnik)
endif()
