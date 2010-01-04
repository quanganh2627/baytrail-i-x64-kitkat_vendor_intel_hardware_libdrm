LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

common_SRC_FILES := \
	libdrm/libdrm_lists.h \
	libdrm/xf86drm.c \
	libdrm/xf86drmHash.c \
	libdrm/xf86drmRandom.c \
	libdrm/xf86drmMode.c \
	libdrm/xf86drmSL.c \


ifeq ($(TARGET_ARCH),arm)
	LOCAL_CFLAGS += -fstrict-aliasing -fomit-frame-pointer
endif

common_CFLAGS := -W -g -DPLATFORM_ANDROID

common_C_INCLUDES +=\
    $(LOCAL_PATH)/shared-core \

LOCAL_SRC_FILES := $(common_SRC_FILES)
LOCAL_CFLAGS += $(common_CFLAGS)
LOCAL_C_INCLUDES += $(common_C_INCLUDES)

LOCAL_COPY_HEADERS_TO := libdrm

LOCAL_COPY_HEADERS := \
	libdrm/xf86drm.h \
	libdrm/xf86drmMode.h \
	shared-core/drm.h \
	shared-core/drm_mode.h \
	shared-core/drm_sarea.h \
	shared-core/i915_drm.h

LOCAL_MODULE := libdrm

ifeq ($(TARGET_OS)-$(TARGET_ARCH),linux-x86)
LOCAL_CFLAGS += -DUSTL_ANDROID_X86
endif

include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)

common_SRC_FILES := tests/dristat.c

common_CFLAGS := -W -g -DPLATFORM_ANDROID

common_C_INCLUDES +=\
    $(LOCAL_PATH)/shared-core \
    $(LOCAL_PATH)/libdrm

LOCAL_SRC_FILES := $(common_SRC_FILES)
LOCAL_CFLAGS += $(common_CFLAGS)
LOCAL_C_INCLUDES += $(common_C_INCLUDES)

LOCAL_MODULE := dristat

ifeq ($(TARGET_OS)-$(TARGET_ARCH),linux-x86)
LOCAL_CFLAGS += -DUSTL_ANDROID_X86
endif

include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)

common_SRC_FILES := tests/drmstat.c

common_CFLAGS := -W -g -DPLATFORM_ANDROID

common_C_INCLUDES +=\
    $(LOCAL_PATH)/shared-core \
    $(LOCAL_PATH)/libdrm

LOCAL_SRC_FILES := $(common_SRC_FILES)
LOCAL_CFLAGS += $(common_CFLAGS)
LOCAL_C_INCLUDES += $(common_C_INCLUDES)
LOCAL_SHARED_LIBRARIES := libdrm
LOCAL_MODULE := drmstat

ifeq ($(TARGET_OS)-$(TARGET_ARCH),linux-x86)
LOCAL_CFLAGS += -DUSTL_ANDROID_X86
endif

include $(BUILD_EXECUTABLE)
