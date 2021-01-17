set(MYAPP_NAME myapp)

include(${CMAKE_SOURCE_DIR}/cmake_helpers.cmake)
log_submodule_folders(${MYAPP_NAME} ${CMAKE_SOURCE_DIR})

file(GLOB_RECURSE  HEADER_LIST CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/*.hpp")
file(GLOB_RECURSE  HEADER_LIST CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/*.h")
file(GLOB_RECURSE  CPP_LIST    CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp")

add_executable(myapp ${HEADER_LIST} ${CPP_LIST} ${H_LIST})

#add_dependencies(mylibrary)
#target_compile_features(${MD_NAME} PRIVATE cxx_std_17)

enable_pch("${MYAPP_NAME}" "stdafx.h" "stdafx.cpp" "${CPP_LIST}" )

if(UNIX)
   #find_package(Boost 1.71.0 COMPONENTS filesystem regex)
   include_directories(${Boost_INCLUDE_DIRS}) 
   include_directories("/usr/local/include") 
   link_directories("/usr/local/lib")
   # Add source to this project's executable.
   #add_executable (${MD_NAME} "app.cpp" "app.hpp")
   target_link_libraries(${MD_NAME} ${Boost_LIBRARIES})
   target_link_libraries(${MD_NAME} libACE-6.4.5.so)
   target_link_libraries(${MD_NAME} liblog4cplus.so)
   #target_link_libraries(${MD_NAME} /usr/local/lib/liblog4cplusU-3.0.so)
endif()

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

   #add_executable (${PROJECT_NAME} "CMakeProject1.cpp" "CMakeProject1.h")
   #target_link_libraries(CMakeProject1 ${Boost_LIBRARIES})
   #target_link_libraries(${MD_NAME} ${PROJECT_SOURCE_DIR}/vcpkg/installed/x64-windows/lib/ACE.lib)
   #target_link_libraries(${MD_NAME} ${Boost_LIBRARIES})
   #target_link_libraries(${MD_NAME} ${PROJECT_SOURCE_DIR}/vcpkg/installed/x64-windows/lib/log4cplus.lib)

   #Copy bin files so it will run
#   configure_file("${PROJECT_SOURCE_DIR}/vcpkg/installed/x64-windows/bin/ACE.dll" "${CMakeProject1_BINARY_DIR}/ACE.dll" COPYONLY)
#   configure_file("${PROJECT_SOURCE_DIR}/vcpkg/installed/x64-windows/bin/log4cplus.dll" "${CMakeProject1_BINARY_DIR}/log4cplus.dll" COPYONLY)

endif(WIN32)

# source_group(
#     TREE "${PROJECT_SOURCE_DIR}/md-app"
#     PREFIX "src"
#     FILES ${MD_CPP_LIST} ${MD_HEADER_LIST} ${MD_ICO_LIST} ${MD_H_LIST} ${MD_MC_LIST})
