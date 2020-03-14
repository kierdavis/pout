extern crate gtypes;

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
