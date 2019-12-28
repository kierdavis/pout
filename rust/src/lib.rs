extern crate cty;

#[repr(C)]
pub struct VideoFormatFull {
  width: cty::c_int,
  height: cty::c_int,
  fr_numerator: cty::c_int,
  ft_denominator: cty::c_int,
}

#[no_mangle]
pub extern fn pout_compare_formats(c: *const VideoFormatFull, d: *const VideoFormatFull) -> cty::c_int {
  unsafe {
    (*d).width*(*d).height - (*c).width*(*c).height
  }
}
