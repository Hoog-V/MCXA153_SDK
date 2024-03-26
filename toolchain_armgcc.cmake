set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR ARM)
if(${CMAKE_VERSION} VERSION_LESS "3.16.0")
    message(WARNING "Current CMake version is ${CMAKE_VERSION}. KL25Z-cmake requires CMake 3.16 or greater")

endif()

set(CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY")


set(CMAKE_OBJCOPY arm-none-eabi-objcopy)
set(CMAKE_OBJDUMP arm-none-eabi-objdump)
set(SIZE arm-none-eabi-size)
set(MCPU cortex-m33+nodsp)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)


add_compile_options(-mcpu=${MCPU} -mthumb -mthumb-interwork)

add_definitions(-DCPU_MCXA153VLH 
                -DMCUXPRESSO_SDK 
                -g
                -mthumb 
                -MMD 
                -MP 
                -fno-common 
                -ffunction-sections 
                -fdata-sections 
                -ffreestanding 
                -fno-builtin 
                -mapcs 
                -fno-exceptions)

set(LINKER_SCRIPT ${CMAKE_CURRENT_LIST_DIR}/gcc/MCXA153_flash.ld)
add_link_options(-T ${LINKER_SCRIPT}
                -mthumb
                -mcpu=${MCPU}
                -specs=nano.specs 
                -Wl,--gc-sections
                -Wl,--print-memory-usage
                -Wl,--no-warn-rwx-segments
                -lm
                -Wl,-Map=${PROJECT_BINARY_DIR}/${PROJECT_NAME}.map
                )

add_link_options(-T ${LINKER_SCRIPT} -static)

include_directories(${CMAKE_CURRENT_LIST_DIR} ${CMAKE_CURRENT_LIST_DIR}/CMSIS/Core/Include/)

set(STARTUP_SCRIPT_SOURCES "${CMAKE_CURRENT_LIST_DIR}/system_MCXA153.c" "${CMAKE_CURRENT_LIST_DIR}/gcc/startup_MCXA153.S")

