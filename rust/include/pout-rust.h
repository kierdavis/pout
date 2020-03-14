#ifndef __POUT_RUST_H
#define __POUT_RUST_H

#include <glib.h>

// Expect this API surface to develop rapidly...

extern gint pout_compare_formats(gconstpointer a, gconstpointer b);
extern GQuark pout_camera_device_error_quark();

#endif
