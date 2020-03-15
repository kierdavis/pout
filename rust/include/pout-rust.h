#ifndef __POUT_RUST_H
#define __POUT_RUST_H

#include <glib.h>
#include <gst/gst.h>
#include "cheese-camera-device.h"

// Expect this API surface to develop rapidly...

extern GList *pout_format_list_insert_sorted(GList *, gpointer);
extern GQuark pout_camera_device_error_quark();
extern CheeseVideoFormat *pout_video_format_copy(const CheeseVideoFormat *);
extern void pout_video_format_free(CheeseVideoFormat *);
extern GstCaps *pout_camera_device_filter_caps(CheeseCameraDevice *, GstCaps *, gchar const *const *);

#endif
