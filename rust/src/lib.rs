extern crate glib;
extern crate glib_sys;
extern crate gtypes;

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

#[no_mangle]
pub extern fn pout_compare_formats(a: gtypes::gconstpointer, b: gtypes::gconstpointer) -> gtypes::gint {
  unsafe {
    let c = a as *const PoutVideoFormatFull;
    let d = b as *const PoutVideoFormatFull;
    (*d).width*(*d).height - (*c).width*(*c).height
  }
}

#[no_mangle]
pub extern fn pout_camera_device_error_quark() -> glib::Quark {
  glib::Quark::from_string("pout-camera-device-error-quark")
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
