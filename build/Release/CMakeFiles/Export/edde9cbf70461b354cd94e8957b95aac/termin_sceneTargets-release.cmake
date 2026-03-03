#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "termin_scene::termin_scene" for configuration "Release"
set_property(TARGET termin_scene::termin_scene APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(termin_scene::termin_scene PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libtermin_scene.so"
  IMPORTED_SONAME_RELEASE "libtermin_scene.so"
  )

list(APPEND _cmake_import_check_targets termin_scene::termin_scene )
list(APPEND _cmake_import_check_files_for_termin_scene::termin_scene "${_IMPORT_PREFIX}/lib/libtermin_scene.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
