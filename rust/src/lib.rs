extern crate glib_sys;
extern crate gobject_sys;
extern crate gtypes;
extern crate gstreamer_sys;
extern crate libc;

use std::ffi::CString;

const POUT_MAXIMUM_RATE: gtypes::guint = 30;

#[repr(C)]
pub struct PoutCameraDevice {
  parent: gobject_sys::GObject,
  unused: *mut libc::c_void,
}

#[repr(C)]
pub struct PoutVideoFormat {
  width: gtypes::gint,
  height: gtypes::gint,
}

#[repr(C)]
pub struct PoutVideoFormatFull {
  width: gtypes::gint,
  height: gtypes::gint,
  fr_numerator: gtypes::gint,
  fr_denominator: gtypes::gint,
}

extern fn pout_compare_formats(a: gtypes::gconstpointer, b: gtypes::gconstpointer) -> gtypes::gint {
  unsafe {
    let c = a as *const PoutVideoFormatFull;
    let d = b as *const PoutVideoFormatFull;
    (*d).width*(*d).height - (*c).width*(*c).height
  }
}

#[no_mangle]
pub extern fn pout_format_list_insert_sorted(list: *mut glib_sys::GList, data: gtypes::gpointer) -> *mut glib_sys::GList {
  unsafe {
    glib_sys::g_list_insert_sorted(list, data, Some(pout_compare_formats))
  }
}

#[no_mangle]
pub extern fn pout_camera_device_error_quark() -> glib_sys::GQuark {
  unsafe {
    glib_sys::g_quark_from_string(CString::new("pout-camera-device-error-quark").unwrap().as_ptr())
  }
}

#[no_mangle]
pub extern fn pout_video_format_copy(format: *const PoutVideoFormat) -> *mut PoutVideoFormat {
  unsafe {
    glib_sys::g_slice_copy(std::mem::size_of::<PoutVideoFormat>(), format as gtypes::gconstpointer) as *mut PoutVideoFormat
  }
}

#[no_mangle]
pub extern fn pout_video_format_free(format: *mut PoutVideoFormat) {
  if !format.is_null() {
    unsafe {
      glib_sys::g_slice_free1(std::mem::size_of::<PoutVideoFormat>(), format as gtypes::gpointer);
    }
  }
}

/// Filter the supplied caps with POUT_MAXIMUM_RATE to only allow formats
/// which can reach the desired framerate.
#[no_mangle]
pub extern fn pout_camera_device_filter_caps(device: *mut PoutCameraDevice, caps: *mut gstreamer_sys::GstCaps, formats: *const *const gtypes::gchar) -> *mut gstreamer_sys::GstCaps {
  let framerate = CString::new("framerate").unwrap();
  let mut i = 0;
  unsafe {
    let filter = gstreamer_sys::gst_caps_new_empty();
    while !(*formats.offset(i)).is_null() {
      gstreamer_sys::gst_caps_append(
        filter,
        gstreamer_sys::gst_caps_new_simple(
          (*formats.offset(i)),
          framerate.as_ptr(),
          gstreamer_sys::gst_fraction_range_get_type(),
          0,
          1,
          POUT_MAXIMUM_RATE,
          1,
          std::ptr::null::<*const gtypes::gchar>(),
        ),
      );
      i = i + 1;
    }
    let allowed = gstreamer_sys::gst_caps_intersect(caps, filter);
    gstreamer_sys::gst_mini_object_unref(filter as *mut gstreamer_sys::GstMiniObject);
    allowed
  }
}
