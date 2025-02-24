# Install script for directory: /home/levi/mjpg-streamer-master/mjpg-streamer-experimental

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/mjpg_streamer" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/mjpg_streamer")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/mjpg_streamer"
         RPATH "/usr/local/lib/mjpg-streamer")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/home/levi/mjpg-streamer-master/mjpg-streamer-experimental/mjpg_streamer")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/mjpg_streamer" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/mjpg_streamer")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/mjpg_streamer"
         OLD_RPATH "::::::::::::::::::::::::::::"
         NEW_RPATH "/usr/local/lib/mjpg-streamer")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/mjpg_streamer")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/mjpg-streamer" TYPE DIRECTORY FILES "/home/levi/mjpg-streamer-master/mjpg-streamer-experimental/www")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/levi/mjpg-streamer-master/mjpg-streamer-experimental/plugins/input_file/cmake_install.cmake")
  include("/home/levi/mjpg-streamer-master/mjpg-streamer-experimental/plugins/input_http/cmake_install.cmake")
  include("/home/levi/mjpg-streamer-master/mjpg-streamer-experimental/plugins/input_opencv/cmake_install.cmake")
  include("/home/levi/mjpg-streamer-master/mjpg-streamer-experimental/plugins/input_raspicam/cmake_install.cmake")
  include("/home/levi/mjpg-streamer-master/mjpg-streamer-experimental/plugins/input_ptp2/cmake_install.cmake")
  include("/home/levi/mjpg-streamer-master/mjpg-streamer-experimental/plugins/input_uvc/cmake_install.cmake")
  include("/home/levi/mjpg-streamer-master/mjpg-streamer-experimental/plugins/output_file/cmake_install.cmake")
  include("/home/levi/mjpg-streamer-master/mjpg-streamer-experimental/plugins/output_http/cmake_install.cmake")
  include("/home/levi/mjpg-streamer-master/mjpg-streamer-experimental/plugins/output_rtsp/cmake_install.cmake")
  include("/home/levi/mjpg-streamer-master/mjpg-streamer-experimental/plugins/output_udp/cmake_install.cmake")
  include("/home/levi/mjpg-streamer-master/mjpg-streamer-experimental/plugins/output_viewer/cmake_install.cmake")
  include("/home/levi/mjpg-streamer-master/mjpg-streamer-experimental/plugins/output_zmqserver/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/levi/mjpg-streamer-master/mjpg-streamer-experimental/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
