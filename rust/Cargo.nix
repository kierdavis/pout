# Generated by carnix 0.10.0: carnix generate-nix --src .
{ lib, buildPlatform, buildRustCrate, buildRustCrateHelpers, cratesIO, fetchgit }:
with buildRustCrateHelpers;
let inherit (lib.lists) fold;
    inherit (lib.attrsets) recursiveUpdate;
in
rec {
  crates = cratesIO // rec {
# pout-0.1.0

    crates.pout."0.1.0" = deps: { features?(features_.pout."0.1.0" deps {}) }: buildRustCrate {
      crateName = "pout";
      version = "0.1.0";
      authors = [ "Kier Davis <kierdavis@gmail.com>" ];
      edition = "2018";
      src = exclude [ ".git" "target" ] ./.;
      type = [ "staticlib" ];
      dependencies = mapFeatures features ([
        (cratesIO.crates."glib"."${deps."pout"."0.1.0"."glib"}" deps)
        (cratesIO.crates."glib_sys"."${deps."pout"."0.1.0"."glib_sys"}" deps)
        (cratesIO.crates."gobject_sys"."${deps."pout"."0.1.0"."gobject_sys"}" deps)
        (cratesIO.crates."gstreamer_sys"."${deps."pout"."0.1.0"."gstreamer_sys"}" deps)
        (cratesIO.crates."gtypes"."${deps."pout"."0.1.0"."gtypes"}" deps)
        (cratesIO.crates."libc"."${deps."pout"."0.1.0"."libc"}" deps)
      ]);
    };
    features_.pout."0.1.0" = deps: f: updateFeatures f (rec {
      glib."${deps.pout."0.1.0".glib}".default = true;
      glib_sys."${deps.pout."0.1.0".glib_sys}".default = true;
      gobject_sys."${deps.pout."0.1.0".gobject_sys}".default = true;
      gstreamer_sys."${deps.pout."0.1.0".gstreamer_sys}".default = true;
      gtypes."${deps.pout."0.1.0".gtypes}".default = true;
      libc."${deps.pout."0.1.0".libc}".default = true;
      pout."0.1.0".default = (f.pout."0.1.0".default or true);
    }) [
      (cratesIO.features_.glib."${deps."pout"."0.1.0"."glib"}" deps)
      (cratesIO.features_.glib_sys."${deps."pout"."0.1.0"."glib_sys"}" deps)
      (cratesIO.features_.gobject_sys."${deps."pout"."0.1.0"."gobject_sys"}" deps)
      (cratesIO.features_.gstreamer_sys."${deps."pout"."0.1.0"."gstreamer_sys"}" deps)
      (cratesIO.features_.gtypes."${deps."pout"."0.1.0"."gtypes"}" deps)
      (cratesIO.features_.libc."${deps."pout"."0.1.0"."libc"}" deps)
    ];


# end

  };

  pout = crates.crates.pout."0.1.0" deps;
  __all = [ (pout {}) ];
  deps.bitflags."1.2.1" = {};
  deps.futures_channel."0.3.4" = {
    futures_core = "0.3.4";
  };
  deps.futures_core."0.3.4" = {};
  deps.futures_executor."0.3.4" = {
    futures_core = "0.3.4";
    futures_task = "0.3.4";
    futures_util = "0.3.4";
  };
  deps.futures_macro."0.3.4" = {
    proc_macro_hack = "0.5.11";
    proc_macro2 = "1.0.9";
    quote = "1.0.3";
    syn = "1.0.16";
  };
  deps.futures_task."0.3.4" = {};
  deps.futures_util."0.3.4" = {
    futures_core = "0.3.4";
    futures_macro = "0.3.4";
    futures_task = "0.3.4";
    pin_utils = "0.1.0-alpha.4";
    proc_macro_hack = "0.5.11";
    proc_macro_nested = "0.1.3";
    slab = "0.4.2";
  };
  deps.glib."0.9.3" = {
    bitflags = "1.2.1";
    futures_channel = "0.3.4";
    futures_core = "0.3.4";
    futures_executor = "0.3.4";
    futures_task = "0.3.4";
    futures_util = "0.3.4";
    glib_sys = "0.9.1";
    gobject_sys = "0.9.1";
    lazy_static = "1.4.0";
    libc = "0.2.67";
  };
  deps.glib_sys."0.9.1" = {
    libc = "0.2.67";
    pkg_config = "0.3.17";
  };
  deps.gobject_sys."0.9.1" = {
    glib_sys = "0.9.1";
    libc = "0.2.67";
    pkg_config = "0.3.17";
  };
  deps.gstreamer_sys."0.8.1" = {
    glib_sys = "0.9.1";
    gobject_sys = "0.9.1";
    libc = "0.2.67";
    pkg_config = "0.3.17";
  };
  deps.gtypes."0.2.0" = {
    libc = "0.2.67";
  };
  deps.lazy_static."1.4.0" = {};
  deps.libc."0.2.67" = {};
  deps.pin_utils."0.1.0-alpha.4" = {};
  deps.pkg_config."0.3.17" = {};
  deps.pout."0.1.0" = {
    glib = "0.9.3";
    glib_sys = "0.9.1";
    gobject_sys = "0.9.1";
    gstreamer_sys = "0.8.1";
    gtypes = "0.2.0";
    libc = "0.2.67";
  };
  deps.proc_macro_hack."0.5.11" = {
    proc_macro2 = "1.0.9";
    quote = "1.0.3";
    syn = "1.0.16";
  };
  deps.proc_macro_nested."0.1.3" = {};
  deps.proc_macro2."1.0.9" = {
    unicode_xid = "0.2.0";
  };
  deps.quote."1.0.3" = {
    proc_macro2 = "1.0.9";
  };
  deps.slab."0.4.2" = {};
  deps.syn."1.0.16" = {
    proc_macro2 = "1.0.9";
    quote = "1.0.3";
    unicode_xid = "0.2.0";
  };
  deps.unicode_xid."0.2.0" = {};
}