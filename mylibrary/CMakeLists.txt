# Note that headers are optional, and do not affect add_library, but they will not
# show up in IDEs unless they are listed in add_library.

set(MYAPP_NAME mylibrary)
set(MYAPP_VERSION 9.0.0)

include(${CMAKE_SOURCE_DIR}/cmake_helpers.cmake)
log_submodule_folders(${MYAPP_NAME} ${CMAKE_SOURCE_DIR})

file(GLOB_RECURSE  HEADER_LIST CONFIGURE_DEPENDS "${CMAKE_SOURCE_DIR}/*.hpp")
file(GLOB_RECURSE  CPP_LIST    CONFIGURE_DEPENDS "${CMAKE_SOURCE_DIR}/*.cpp")
file(GLOB_RECURSE  H_LIST      CONFIGURE_DEPENDS "${CMAKE_SOURCE_DIR}/*.h")

if(NOT APPLE)
   set(CMAKE_INSTALL_RPATH $ORIGIN)
endif()

set(CMAKE_CXX_VISIBILITY_PRESET hidden)
set(CMAKE_VISIBILITY_INLINES_HIDDEN 1)

#include(generateexportheader)
#  Make the shared dll, or so.  If you remove the SHARED then it would be based on the target including it.
#  But that is not supported for now.
add_library(${MYAPP_NAME} SHARED ${CPP_LIST} ${HEADER_LIST} ${ICO_LIST} ${H_LIST} ${MC_LIST})

#generate_export_header(${MYAPP_NAME})

#target_compile_features(${LIBRARY_NAME} PRIVATE cxx_std_17)

#PRIVATE - use only for this specified build target
#PUBLIC - use it for specified target and for targets which links with this project
#INTERFACE -- use it only for targets which links with the current project
include_directories("${CMAKE_CURRENT_SOURCE_DIR}")

if (MSVC)
   #Set use pch
    foreach( cpp_file ${CPP_LIST} )
        set_source_files_properties(
            ${cpp_file}
            PROPERTIES
            COMPILE_FLAGS "/Yustdafx.h")
            message(TRACE "set use pch on file ${cpp_file}")
    endforeach( cpp_file ${CPP_LIST} )

    #Set create pch
    set_source_files_properties("stdafx.cpp"
        PROPERTIES
        COMPILE_FLAGS "/Ycstdafx.h")
    message(TRACE "set create pch on file stdafx.cpp")

   #this file creates a really big obj output, so the default computer mem size must be increased for this file
   set_source_files_properties("pdd/json/json_spirit_reader.cpp"
      PROPERTIES
      COMPILE_FLAGS "/bigobj /Zm200"
      )
endif (MSVC)


# This depends on (header only) boost
#target_link_libraries(modern_library PRIVATE Boost::boost)

# All users of this library will need at least C++11
#target_compile_features(${LIBRARY_NAME} PUBLIC cxx_std_11)
if(UNIX)

#   set_target_properties(
#      ${LIBRARY_NAME} CMAKE_DEBUG_TARGET_PROPERTIES
#      SOVERSION 9
#      VERSION ${pdd_version})

#   set_target_properties(
#      ${LIBRARY_NAME} CMAKE_DEBUG_TARGET_PROPERTIES
#      SOVERSION 9
#      VERSION ${pdd_version})

      #Create the <library>ProjConfigVersion.cmake file and configure it for sematic versioning.
   write_basic_package_version_file(
      ${LIBRARY_NAME}ConfigVersion.cmake
      VERSION ${pdd_version}
      COMPATIBILTY SameMajorVersion)
endif(UNIX)


if(WIN32)

   set(Boost_INCLUDE_DIRS    ${PROJECT_SOURCE_DIR}/vcpkg/installed/x64-windows/include)
   include_directories(${Boost_INCLUDE_DIRS})
   link_directories(${Boost_LIBRARY_DIRS})
   
   #find_package(Boost 1.75.0 COMPONENTS filesystem regex)
   #set(BOOST_LIBRARYDIR    ${PROJECT_SOURCE_DIR}/vcpkg/installed/x64-windows/lib)
   #set(BOOST_ROOT         ${PROJECT_SOURCE_DIR}/vcpkg/installed/x64-windows/lib)
   #include_directories(${Boost_INCLUDE_DIRS}) 


   include_directories(${PROJECT_SOURCE_DIR}/vcpkg/installed/x64-windows/include)
   message("Including folder include_directories(${PROJECT_SOURCE_DIR}/vcpkg/installed/x64-windows/include)")

   #set(Boost_USE_STATIC_LIBS        ON)
   #set(Boost_USE_MULTITHREADED      ON)
   #set(Boost_USE_STATIC_RUNTIME    OFF)

#   target_link_libraries(${LIBRARY_NAME} ${PROJECT_SOURCE_DIR}/vcpkg/installed/x64-windows/lib/ACE.lib)
#   target_link_libraries(${LIBRARY_NAME} ${Boost_LIBRARIES})
#   target_link_libraries(${LIBRARY_NAME} ${PROJECT_SOURCE_DIR}/vcpkg/installed/x64-windows/lib/log4cplus.lib)

   #Copy bin files so it will run
#   configure_file("${PROJECT_SOURCE_DIR}/vcpkg/installed/x64-windows/bin/ACE.dll" "${CMakeProject1_BINARY_DIR}/ACE.dll" COPYONLY)
#   configure_file("${PROJECT_SOURCE_DIR}/vcpkg/installed/x64-windows/bin/log4cplus.dll" "${CMakeProject1_BINARY_DIR}/log4cplus.dll" COPYONLY)
endif()

# This will put the files in the generated IDE in the proper order.
#source_group(
#  TREE "${PROJECT_SOURCE_DIR}/mylibrary"
#  PREFIX "src"
#  FILES ${CPP_LIST} ${HEADER_LIST} ${ICO_LIST} ${H_LIST} ${MC_LIST})

if(UNIX)
   include(GNUInstallDirs)
   install(TARGETS ${LIBRARY_NAME},
	   RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
		        COMPONENT	  ${LIBRARY_NAME}_Runtime
	   LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
		        COMPONENT	         ${LIBRARY_NAME}_Runtime
			     NAMELINK_COMPONENT ${LIBRARY_NAME}_Development
	   ARCHIVE DESTINATION        ${CMAKE_INSTALL_LIBDIR}
		        COMPONENT	         ${LIBRARY_NAME}_Development
   )
endif(UNIX)

#The CMake fragment will generate a file in the
#``${CMAKE_CURRENT_BINARY_DIR}`` called ``somelib_export.h`` containing the
#macros ``SOMELIB_EXPORT``, ``SOMELIB_NO_EXPORT``, ``SOMELIB_DEPRECATED``,
#``SOMELIB_DEPRECATED_EXPORT`` and ``SOMELIB_DEPRECATED_NO_EXPORT``.

