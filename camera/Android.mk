LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_C_INCLUDES += \
    $(LOCAL_PATH)/include \
    system/media/camera/include

LOCAL_SRC_FILES := \
    CameraWrapper.cpp

LOCAL_STATIC_LIBRARIES := libbase libarect
LOCAL_SHARED_LIBRARIES := \
    libhardware liblog libcamera_client libutils libcutils libdl \
    android.hidl.token@1.0-utils \
    android.hardware.graphics.bufferqueue@1.0

LOCAL_HEADER_LIBRARIES := libnativebase_headers

LOCAL_MODULE := camera.$(TARGET_BOARD_PLATFORM)
LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_MODULE_TAGS := optional
LOCAL_PROPRIETARY_MODULE := true

include $(BUILD_SHARED_LIBRARY)
#include $(BUILD_HEAPTRACKED_SHARED_LIBRARY)

include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
    camera2/CaptureRequest.cpp \
    camera2/OutputConfiguration.cpp \
    camera2/SubmitInfo.cpp \
    Camera.cpp \
    CameraBase.cpp \
    CameraMetadata.cpp \
    CameraParameters.cpp \
    CameraParameters2.cpp \
    CameraUtils.cpp \
    CaptureResult.cpp \
    ICamera.cpp \
    ICameraClient.cpp \
    ICameraRecordingProxy.cpp \
    ICameraRecordingProxyListener.cpp \
    VendorTagDescriptor.cpp

LOCAL_SHARED_LIBRARIES := \
    libcutils \
    libutils \
    liblog \
    libbinder \
    libgui \
    libcamera_metadata \
    libnativewindow

LOCAL_C_INCLUDES += \
    $(LOCAL_PATH)/include \
    system/media/private/camera/include \
    frameworks/native/include/media/openmax

LOCAL_MODULE := libshim_camera_client
LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)
