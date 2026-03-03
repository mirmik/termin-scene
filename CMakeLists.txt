cmake_minimum_required(VERSION 3.14)
project(termin_scene VERSION 0.1.0 LANGUAGES C)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

option(TERMIN_SCENE_BUILD_SHARED "Build shared library" ON)
option(TERMIN_SCENE_BUILD_TESTS "Build tests" ON)

# Dependencies
find_package(termin_base REQUIRED)
find_package(termin_graphics REQUIRED)

set(TERMIN_SCENE_SOURCES
    src/termin_scene_version.c
    src/tc_archetype.c
    src/tc_component.c
    src/tc_entity_pool.c
    src/tc_entity_pool_registry.c
    src/tc_hash_map.c
    src/tc_scene.c
    src/tc_scene_extension.c
    src/tc_type_registry.c
)

set(TERMIN_SCENE_HEADERS
    include/termin_scene/termin_scene.h
    include/core/tc_archetype.h
    include/core/tc_component.h
    include/core/tc_dlist.h
    include/core/tc_entity_pool.h
    include/core/tc_entity_pool_registry.h
    include/core/tc_scene.h
    include/core/tc_scene_extension.h
    include/core/tc_scene_pool.h
    include/tc_hash_map.h
    include/tc_type_registry.h
    include/tc_types.h
    include/tc_value.h
)

if(TERMIN_SCENE_BUILD_SHARED)
    add_library(termin_scene SHARED ${TERMIN_SCENE_SOURCES} ${TERMIN_SCENE_HEADERS})
    target_compile_definitions(termin_scene PRIVATE TERMIN_SCENE_EXPORTS TC_EXPORTS)
else()
    add_library(termin_scene STATIC ${TERMIN_SCENE_SOURCES} ${TERMIN_SCENE_HEADERS})
endif()

add_library(termin_scene::termin_scene ALIAS termin_scene)

set_target_properties(termin_scene PROPERTIES
    POSITION_INDEPENDENT_CODE ON
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
)

target_include_directories(termin_scene
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
)

target_link_libraries(termin_scene PUBLIC tgfx::termin_graphics tcbase::termin_base)

if(UNIX AND NOT APPLE)
    target_link_libraries(termin_scene PRIVATE m)
endif()

install(TARGETS termin_scene
    EXPORT termin_sceneTargets
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    RUNTIME DESTINATION bin
)

install(DIRECTORY include/
    DESTINATION include
)

install(EXPORT termin_sceneTargets
    FILE termin_sceneTargets.cmake
    NAMESPACE termin_scene::
    DESTINATION lib/cmake/termin_scene
)

include(CMakePackageConfigHelpers)

configure_package_config_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/cmake/termin_sceneConfig.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/termin_sceneConfig.cmake
    INSTALL_DESTINATION lib/cmake/termin_scene
)

write_basic_package_version_file(
    ${CMAKE_CURRENT_BINARY_DIR}/termin_sceneConfigVersion.cmake
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY SameMajorVersion
)

install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/termin_sceneConfig.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/termin_sceneConfigVersion.cmake
    DESTINATION lib/cmake/termin_scene
)

if(TERMIN_SCENE_BUILD_TESTS)
    enable_testing()

    add_executable(termin_scene_data_structures_test tests/test_data_structures.c)
    target_link_libraries(termin_scene_data_structures_test PRIVATE termin_scene)
    add_test(NAME termin_scene_data_structures_test COMMAND termin_scene_data_structures_test)

    add_executable(termin_scene_archetype_test tests/test_archetype.c)
    target_link_libraries(termin_scene_archetype_test PRIVATE termin_scene)
    add_test(NAME termin_scene_archetype_test COMMAND termin_scene_archetype_test)

    set_target_properties(
        termin_scene_data_structures_test termin_scene_archetype_test
        PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
    )
endif()
