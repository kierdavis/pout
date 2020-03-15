#ifndef __POUT_RUST_H
#define __POUT_RUST_H

#include <glib.h>
#include "cheese-camera-device.h"

// Expect this API surface to develop rapidly...

extern gint pout_compare_formats(gconstpointer, gconstpointer);
extern GQuark pout_camera_device_error_quark();
extern CheeseVideoFormat *pout_video_format_copy(const CheeseVideoFormat *);
extern void pout_video_format_free(CheeseVideoFormat *);

#endif
