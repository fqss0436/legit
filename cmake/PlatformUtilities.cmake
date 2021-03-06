
CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIC")
SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC")

IF(WIN32)
	ADD_DEFINITIONS(-DPLATFORM_WINDOWS)
	FIND_PACKAGE(OpenCVWindows REQUIRED)
	SET(OpenCV_INCLUDE_DIR ${OPENCV_INCLUDE_DIR})
	SET(OpenCV_LIBS "${OPENCV_CORE_LIBRARY};${OPENCV_IMGPROC_LIBRARY};${OPENCV_VIDEO_LIBRARY};${OPENCV_HIGHGUI_LIBRARY}")
	SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
ELSEIF(APPLE)  
	ADD_DEFINITIONS(-DPLATFORM_OSX)
	FIND_PACKAGE(OpenCV REQUIRED core imgproc video highgui)
	SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
ELSEIF(UNIX)
	# TODO: Probably some distribution of Linux, but could be improved
	ADD_DEFINITIONS(-DPLATFORM_LINUX)
	FIND_PACKAGE(OpenCV REQUIRED core imgproc video highgui)
	SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
ELSE()
	MESSAGE(FATAL_ERROR "Unrecognized platform")
ENDIF()

SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -ffast-math -O3") 
SET(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -ffast-math -O3")

LINK_LIBRARIES(${OpenCV_LIBS})
INCLUDE_DIRECTORIES(AFTER ${CMAKE_CURRENT_BINARY_DIR} ${OpenCV_INCLUDE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/src)
