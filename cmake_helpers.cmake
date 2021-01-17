
#This method will output the name of the level_name passed in and the value
#of the message passed in.
#Outputs: [level_name] -- ${message}
macro(log_message level_name message)
   if( ${${level_name}} )
      message ("[${level_name}] -- ${message}")
   endif()
endmacro()

function( add_library project_name )
   log_message(MY_TRACE_METHOD "Entering ${CMAKE_CURRENT_FUNCTION}")

   log_message(MY_DEBUG "add_library function was called")
   log_message(MY_DEBUG "arg is ${project_name}")

   log_message(MY_TRACE_METHOD "Leaving ${CMAKE_CURRENT_FUNCTION}")
endfunction()

function(log_submodule_folders project_name root_folder) 
   log_message(MY_TRACE_METHOD "Entering ${CMAKE_CURRENT_FUNCTION}")
   
   log_message(MY_INFO "(${project_name}) Start Sub Module")
   log_message(MY_INFO "(${project_name})   Gethered files from:  ${CMAKE_CURRENT_SOURCE_DIR}")
   log_message(MY_INFO "(${project_name})   Root Project dir =    ${PROJECT_SOURCE_DIR}")
   log_message(MY_INFO "(${project_name}) End Sub Module")

   log_message(MY_TRACE_METHOD "Leaving ${CMAKE_CURRENT_FUNCTION}")
endfunction()

function(print_project_info) 
   log_message(MY_TRACE_METHOD "Entering ${CMAKE_CURRENT_FUNCTION}")

   log_message(MY_DEBUG "CMAKE_PROJECT_NAME = ${CMAKE_PROJECT_NAME}")
   log_message(MY_DEBUG "VARIABLES = ${VARIABLES}")
   log_message(MY_DEBUG "CMAKE_CURRENT_LIST_DIR = ${CMAKE_CURRENT_LIST_DIR}")
   log_message(MY_DEBUG "CMAKE_CURRENT_LIST_DIR = ${CMAKE_CURRENT_LIST_DIR}")

   log_message(MY_TRACE_METHOD "Leaving ${CMAKE_CURRENT_FUNCTION}")
endfunction()

function(print_compiler_info) 
   log_message(MY_TRACE_METHOD "Entering ${CMAKE_CURRENT_FUNCTION}")

   log_message(MY_DEBUG "Compiler:       ${CMAKE_CXX_COMPILER}")
   log_message(MY_DEBUG "CompilerID:     ${CMAKE_CXX_COMPILER_ID} version ${CMAKE_CXX_COMPILER_VERSION}")
   log_message(MY_DEBUG "Compiler flags: ${CMAKE_CXX_FLAGS}")
   log_message(MY_DEBUG "System name:    ${CMAKE_SYSTEM_NAME}")
   log_message(MY_DEBUG "System version: ${CMAKE_SYSTEM_VERSION}")
   log_message(MY_DEBUG "Languages:      ${ENABLED_LANGUAGES}")

   log_message(MY_TRACE_METHOD "Leaving ${CMAKE_CURRENT_FUNCTION}")
endfunction()

function(print_properties project_name)
   if(MY_TRACE_)
      message ("${project_name}  CMAKE_PROPERTY_LIST = ${CMAKE_PROPERTY_LIST}")
   endif()
endfunction(print_properties)

#This function will enable a precompiled headers for a visual studio project
function(enable_pch project_name header_name cpp_name source_list)
   log_message(MY_TRACE_METHOD "Entering ${CMAKE_CURRENT_FUNCTION}")
   if (MSVC)
      #Set use pch
       foreach( cpp_file ${source_list} )
           set_source_files_properties(
               ${cpp_file}
               PROPERTIES
               COMPILE_FLAGS "/Yu${header_name}"
               )
              log_message(MY_DEBUG "(${project_name}) set USE    pch on file ${cpp_file}")
       endforeach( cpp_file ${source_list} )
       #Set create pch
       set_source_files_properties("${cpp_name}"
           PROPERTIES
           COMPILE_FLAGS "/Yc${header_name}"
           )
       log_message(MY_DEBUG "(${project_name}) set CREATE pch on file ${cpp_name}")
   else()
      log_message(MY_WARNING "(${project_name}) platform doesn't support pch")
   endif (MSVC)
   log_message(MY_TRACE_METHOD "Leaving ${CMAKE_CURRENT_FUNCTION}")
endfunction(enable_pch)
