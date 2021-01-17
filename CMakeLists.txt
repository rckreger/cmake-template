
cmake_minimum_required (VERSION 3.18)
project ("cmake-template" LANGUAGES  C CXX)



#This will add compiler defines globally
#add_definitions(-DFOO -DBAR ...)

set(MY_TRACE_METHOD FALSE)
set(MY_DEBUG TRUE)
set(MY_INFO FALSE)
set(MY_INFO_CMAKE TRUE)

include(${CMAKE_SOURCE_DIR}/cmake_helpers.cmake)

print_properties("root 1")

print_compiler_info()
print_project_info()

add_subdirectory("myapp")
add_subdirectory("mylibrary")

print_properties("root 2")
