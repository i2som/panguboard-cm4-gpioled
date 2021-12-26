# Author: Dimitris Tassopoulos <dimtass@gmail.com>
# Author: Steve Chen <steve.chen@i2som.com>
cmake_minimum_required(VERSION 3.2)

include_directories(
    Inc
)

file(GLOB C_SOURCE
    # Add the external source files from my lib
    ${STM32_DIMTASS_LIB_SRC}
    ${NOARCH_LIB_SRC}
    # Add the local and project specific files
    User/main.c
    User/syscalls.c
    User/sysmem.c
    User/openamp_log.c
    User/mbox_ipcc.c
    User/openamp.c
    User/resmgr_utility.c
    User/rsc_table.c
    User/stm32mp1xx_hal_msp.c
    User/stm32mp1xx_it.c
)

set_source_files_properties(${C_SOURCE}
    PROPERTIES COMPILE_FLAGS ${STM32_DEFINES}
)

add_executable(${PROJECT_NAME}.elf
    ${C_SOURCE}
    ${EXTERNAL_EXECUTABLES}
)

if (EXTERNAL_DEPENDENCIES)
    add_dependencies(${PROJECT_NAME}.elf
        ${EXTERNAL_DEPENDENCIES}
    )
endif()

if (EXTERNAL_LIBS)
    target_link_libraries(${PROJECT_NAME}.elf
        ${EXTERNAL_LIBS}
    )
endif()

add_custom_target ( ${PROJECT_NAME}.hex ALL
    DEPENDS ${PROJECT_NAME}.elf 
    COMMAND ${CMAKE_OBJCOPY} -O ihex ${PROJECT_NAME}.elf ${PROJECT_NAME}.hex
    COMMENT "Generating ${PROJECT_NAME}.hex"
)
add_custom_target ( ${PROJECT_NAME}.bin ALL
    DEPENDS ${PROJECT_NAME}.elf 
    COMMAND ${CMAKE_OBJCOPY} -O binary ${PROJECT_NAME}.elf ${PROJECT_NAME}.bin
    COMMENT "Generating ${PROJECT_NAME}.bin"
)

add_custom_command(TARGET ${PROJECT_NAME}.elf POST_BUILD
    COMMAND ${CMAKE_SIZE} --format=berkeley "${PROJECT_NAME}.elf")
