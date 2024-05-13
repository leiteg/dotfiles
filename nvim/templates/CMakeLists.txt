cmake_minimum_required(VERSION 3.22)

project(
    projectname
    VERSION     0.0.1
    LANGUAGES   CXX
)

set(CMAKE_CXX_STANDARD 17)

add_executable(
    ${CMAKE_PROJECT_NAME}
        main.cc
)
