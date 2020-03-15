{ lib, buildRustCrate, buildRustCrateHelpers }:
with buildRustCrateHelpers;
let inherit (lib.lists) fold;
    inherit (lib.attrsets) recursiveUpdate;
in
rec {

# bitflags-1.2.1

  crates.bitflags."1.2.1" = deps: { features?(features_.bitflags."1.2.1" deps {}) }: buildRustCrate {
    crateName = "bitflags";
    version = "1.2.1";
    description = "A macro to generate structures which behave like bitflags.\n";
    authors = [ "The Rust Project Developers" ];
    sha256 = "0b77awhpn7yaqjjibm69ginfn996azx5vkzfjj39g3wbsqs7mkxg";
    build = "build.rs";
    features = mkFeatures (features."bitflags"."1.2.1" or {});
  };
  features_.bitflags."1.2.1" = deps: f: updateFeatures f (rec {
    bitflags."1.2.1".default = (f.bitflags."1.2.1".default or true);
  }) [];


# end
# futures-channel-0.3.4

  crates.futures_channel."0.3.4" = deps: { features?(features_.futures_channel."0.3.4" deps {}) }: buildRustCrate {
    crateName = "futures-channel";
    version = "0.3.4";
    description = "Channels for asynchronous communication using futures-rs.\n";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    edition = "2018";
    sha256 = "0y193rdyniid2nzad1mhwhp5a9lplb5my25yw8lwhcfaddqzcfhz";
    dependencies = mapFeatures features ([
      (crates."futures_core"."${deps."futures_channel"."0.3.4"."futures_core"}" deps)
    ]);
    features = mkFeatures (features."futures_channel"."0.3.4" or {});
  };
  features_.futures_channel."0.3.4" = deps: f: updateFeatures f (rec {
    futures_channel = fold recursiveUpdate {} [
      { "0.3.4"."alloc" =
        (f.futures_channel."0.3.4"."alloc" or false) ||
        (f.futures_channel."0.3.4".std or false) ||
        (futures_channel."0.3.4"."std" or false); }
      { "0.3.4"."futures-sink" =
        (f.futures_channel."0.3.4"."futures-sink" or false) ||
        (f.futures_channel."0.3.4".sink or false) ||
        (futures_channel."0.3.4"."sink" or false); }
      { "0.3.4"."std" =
        (f.futures_channel."0.3.4"."std" or false) ||
        (f.futures_channel."0.3.4".default or false) ||
        (futures_channel."0.3.4"."default" or false); }
      { "0.3.4".default = (f.futures_channel."0.3.4".default or true); }
    ];
    futures_core = fold recursiveUpdate {} [
      { "${deps.futures_channel."0.3.4".futures_core}"."alloc" =
        (f.futures_core."${deps.futures_channel."0.3.4".futures_core}"."alloc" or false) ||
        (futures_channel."0.3.4"."alloc" or false) ||
        (f."futures_channel"."0.3.4"."alloc" or false); }
      { "${deps.futures_channel."0.3.4".futures_core}"."cfg-target-has-atomic" =
        (f.futures_core."${deps.futures_channel."0.3.4".futures_core}"."cfg-target-has-atomic" or false) ||
        (futures_channel."0.3.4"."cfg-target-has-atomic" or false) ||
        (f."futures_channel"."0.3.4"."cfg-target-has-atomic" or false); }
      { "${deps.futures_channel."0.3.4".futures_core}"."std" =
        (f.futures_core."${deps.futures_channel."0.3.4".futures_core}"."std" or false) ||
        (futures_channel."0.3.4"."std" or false) ||
        (f."futures_channel"."0.3.4"."std" or false); }
      { "${deps.futures_channel."0.3.4".futures_core}"."unstable" =
        (f.futures_core."${deps.futures_channel."0.3.4".futures_core}"."unstable" or false) ||
        (futures_channel."0.3.4"."unstable" or false) ||
        (f."futures_channel"."0.3.4"."unstable" or false); }
      { "${deps.futures_channel."0.3.4".futures_core}".default = (f.futures_core."${deps.futures_channel."0.3.4".futures_core}".default or false); }
    ];
  }) [
    (features_.futures_core."${deps."futures_channel"."0.3.4"."futures_core"}" deps)
  ];


# end
# futures-core-0.3.4

  crates.futures_core."0.3.4" = deps: { features?(features_.futures_core."0.3.4" deps {}) }: buildRustCrate {
    crateName = "futures-core";
    version = "0.3.4";
    description = "The core traits and types in for the `futures` library.\n";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    edition = "2018";
    sha256 = "03046fyq5s9qyfsary392jc1h65vdw4piya5ksnajd21g8ma6kdz";
    features = mkFeatures (features."futures_core"."0.3.4" or {});
  };
  features_.futures_core."0.3.4" = deps: f: updateFeatures f (rec {
    futures_core = fold recursiveUpdate {} [
      { "0.3.4"."alloc" =
        (f.futures_core."0.3.4"."alloc" or false) ||
        (f.futures_core."0.3.4".std or false) ||
        (futures_core."0.3.4"."std" or false); }
      { "0.3.4"."std" =
        (f.futures_core."0.3.4"."std" or false) ||
        (f.futures_core."0.3.4".default or false) ||
        (futures_core."0.3.4"."default" or false); }
      { "0.3.4".default = (f.futures_core."0.3.4".default or true); }
    ];
  }) [];


# end
# futures-executor-0.3.4

  crates.futures_executor."0.3.4" = deps: { features?(features_.futures_executor."0.3.4" deps {}) }: buildRustCrate {
    crateName = "futures-executor";
    version = "0.3.4";
    description = "Executors for asynchronous tasks based on the futures-rs library.\n";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    edition = "2018";
    sha256 = "0q6jf2caqbccpj54041zmziz5ap1l5zvwhq4q46yygpvn8hwkwp9";
    dependencies = mapFeatures features ([
      (crates."futures_core"."${deps."futures_executor"."0.3.4"."futures_core"}" deps)
      (crates."futures_task"."${deps."futures_executor"."0.3.4"."futures_task"}" deps)
      (crates."futures_util"."${deps."futures_executor"."0.3.4"."futures_util"}" deps)
    ]);
    features = mkFeatures (features."futures_executor"."0.3.4" or {});
  };
  features_.futures_executor."0.3.4" = deps: f: updateFeatures f (rec {
    futures_core = fold recursiveUpdate {} [
      { "${deps.futures_executor."0.3.4".futures_core}"."std" =
        (f.futures_core."${deps.futures_executor."0.3.4".futures_core}"."std" or false) ||
        (futures_executor."0.3.4"."std" or false) ||
        (f."futures_executor"."0.3.4"."std" or false); }
      { "${deps.futures_executor."0.3.4".futures_core}".default = (f.futures_core."${deps.futures_executor."0.3.4".futures_core}".default or false); }
    ];
    futures_executor = fold recursiveUpdate {} [
      { "0.3.4"."num_cpus" =
        (f.futures_executor."0.3.4"."num_cpus" or false) ||
        (f.futures_executor."0.3.4".thread-pool or false) ||
        (futures_executor."0.3.4"."thread-pool" or false); }
      { "0.3.4"."std" =
        (f.futures_executor."0.3.4"."std" or false) ||
        (f.futures_executor."0.3.4".default or false) ||
        (futures_executor."0.3.4"."default" or false) ||
        (f.futures_executor."0.3.4".thread-pool or false) ||
        (futures_executor."0.3.4"."thread-pool" or false); }
      { "0.3.4".default = (f.futures_executor."0.3.4".default or true); }
    ];
    futures_task = fold recursiveUpdate {} [
      { "${deps.futures_executor."0.3.4".futures_task}"."std" =
        (f.futures_task."${deps.futures_executor."0.3.4".futures_task}"."std" or false) ||
        (futures_executor."0.3.4"."std" or false) ||
        (f."futures_executor"."0.3.4"."std" or false); }
      { "${deps.futures_executor."0.3.4".futures_task}".default = (f.futures_task."${deps.futures_executor."0.3.4".futures_task}".default or false); }
    ];
    futures_util = fold recursiveUpdate {} [
      { "${deps.futures_executor."0.3.4".futures_util}"."std" =
        (f.futures_util."${deps.futures_executor."0.3.4".futures_util}"."std" or false) ||
        (futures_executor."0.3.4"."std" or false) ||
        (f."futures_executor"."0.3.4"."std" or false); }
      { "${deps.futures_executor."0.3.4".futures_util}".default = (f.futures_util."${deps.futures_executor."0.3.4".futures_util}".default or false); }
    ];
  }) [
    (features_.futures_core."${deps."futures_executor"."0.3.4"."futures_core"}" deps)
    (features_.futures_task."${deps."futures_executor"."0.3.4"."futures_task"}" deps)
    (features_.futures_util."${deps."futures_executor"."0.3.4"."futures_util"}" deps)
  ];


# end
# futures-macro-0.3.4

  crates.futures_macro."0.3.4" = deps: { features?(features_.futures_macro."0.3.4" deps {}) }: buildRustCrate {
    crateName = "futures-macro";
    version = "0.3.4";
    description = "The futures-rs procedural macro implementations.\n";
    authors = [ "Taylor Cramer <cramertj@google.com>" "Taiki Endo <te316e89@gmail.com>" ];
    edition = "2018";
    sha256 = "1b2hvhvl5f0haky329kwdlak6rcfinvnv33nxh1p3qczqqk97fqy";
    procMacro = true;
    dependencies = mapFeatures features ([
      (crates."proc_macro_hack"."${deps."futures_macro"."0.3.4"."proc_macro_hack"}" deps)
      (crates."proc_macro2"."${deps."futures_macro"."0.3.4"."proc_macro2"}" deps)
      (crates."quote"."${deps."futures_macro"."0.3.4"."quote"}" deps)
      (crates."syn"."${deps."futures_macro"."0.3.4"."syn"}" deps)
    ]);
  };
  features_.futures_macro."0.3.4" = deps: f: updateFeatures f (rec {
    futures_macro."0.3.4".default = (f.futures_macro."0.3.4".default or true);
    proc_macro2."${deps.futures_macro."0.3.4".proc_macro2}".default = true;
    proc_macro_hack."${deps.futures_macro."0.3.4".proc_macro_hack}".default = true;
    quote."${deps.futures_macro."0.3.4".quote}".default = true;
    syn = fold recursiveUpdate {} [
      { "${deps.futures_macro."0.3.4".syn}"."full" = true; }
      { "${deps.futures_macro."0.3.4".syn}".default = true; }
    ];
  }) [
    (features_.proc_macro_hack."${deps."futures_macro"."0.3.4"."proc_macro_hack"}" deps)
    (features_.proc_macro2."${deps."futures_macro"."0.3.4"."proc_macro2"}" deps)
    (features_.quote."${deps."futures_macro"."0.3.4"."quote"}" deps)
    (features_.syn."${deps."futures_macro"."0.3.4"."syn"}" deps)
  ];


# end
# futures-task-0.3.4

  crates.futures_task."0.3.4" = deps: { features?(features_.futures_task."0.3.4" deps {}) }: buildRustCrate {
    crateName = "futures-task";
    version = "0.3.4";
    description = "Tools for working with tasks.\n";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    edition = "2018";
    sha256 = "0xh5apdfk9kna15yiax57601n21x7qrmbqzmf86acv6qwp474z11";
    features = mkFeatures (features."futures_task"."0.3.4" or {});
  };
  features_.futures_task."0.3.4" = deps: f: updateFeatures f (rec {
    futures_task = fold recursiveUpdate {} [
      { "0.3.4"."alloc" =
        (f.futures_task."0.3.4"."alloc" or false) ||
        (f.futures_task."0.3.4".std or false) ||
        (futures_task."0.3.4"."std" or false); }
      { "0.3.4"."std" =
        (f.futures_task."0.3.4"."std" or false) ||
        (f.futures_task."0.3.4".default or false) ||
        (futures_task."0.3.4"."default" or false); }
      { "0.3.4".default = (f.futures_task."0.3.4".default or true); }
    ];
  }) [];


# end
# futures-util-0.3.4

  crates.futures_util."0.3.4" = deps: { features?(features_.futures_util."0.3.4" deps {}) }: buildRustCrate {
    crateName = "futures-util";
    version = "0.3.4";
    description = "Common utilities and extension traits for the futures-rs library.\n";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    edition = "2018";
    sha256 = "0dbra0yqszrp8rfhqr87gayyy5zskikn42sxfsargxzxwa06id4m";
    dependencies = mapFeatures features ([
      (crates."futures_core"."${deps."futures_util"."0.3.4"."futures_core"}" deps)
      (crates."futures_task"."${deps."futures_util"."0.3.4"."futures_task"}" deps)
      (crates."pin_utils"."${deps."futures_util"."0.3.4"."pin_utils"}" deps)
    ]
      ++ (if features.futures_util."0.3.4".futures-macro or false then [ (crates.futures_macro."${deps."futures_util"."0.3.4".futures_macro}" deps) ] else [])
      ++ (if features.futures_util."0.3.4".proc-macro-hack or false then [ (crates.proc_macro_hack."${deps."futures_util"."0.3.4".proc_macro_hack}" deps) ] else [])
      ++ (if features.futures_util."0.3.4".proc-macro-nested or false then [ (crates.proc_macro_nested."${deps."futures_util"."0.3.4".proc_macro_nested}" deps) ] else [])
      ++ (if features.futures_util."0.3.4".slab or false then [ (crates.slab."${deps."futures_util"."0.3.4".slab}" deps) ] else []));
    features = mkFeatures (features."futures_util"."0.3.4" or {});
  };
  features_.futures_util."0.3.4" = deps: f: updateFeatures f (rec {
    futures_core = fold recursiveUpdate {} [
      { "${deps.futures_util."0.3.4".futures_core}"."alloc" =
        (f.futures_core."${deps.futures_util."0.3.4".futures_core}"."alloc" or false) ||
        (futures_util."0.3.4"."alloc" or false) ||
        (f."futures_util"."0.3.4"."alloc" or false); }
      { "${deps.futures_util."0.3.4".futures_core}"."cfg-target-has-atomic" =
        (f.futures_core."${deps.futures_util."0.3.4".futures_core}"."cfg-target-has-atomic" or false) ||
        (futures_util."0.3.4"."cfg-target-has-atomic" or false) ||
        (f."futures_util"."0.3.4"."cfg-target-has-atomic" or false); }
      { "${deps.futures_util."0.3.4".futures_core}"."std" =
        (f.futures_core."${deps.futures_util."0.3.4".futures_core}"."std" or false) ||
        (futures_util."0.3.4"."std" or false) ||
        (f."futures_util"."0.3.4"."std" or false); }
      { "${deps.futures_util."0.3.4".futures_core}"."unstable" =
        (f.futures_core."${deps.futures_util."0.3.4".futures_core}"."unstable" or false) ||
        (futures_util."0.3.4"."unstable" or false) ||
        (f."futures_util"."0.3.4"."unstable" or false); }
      { "${deps.futures_util."0.3.4".futures_core}".default = (f.futures_core."${deps.futures_util."0.3.4".futures_core}".default or false); }
    ];
    futures_macro."${deps.futures_util."0.3.4".futures_macro}".default = (f.futures_macro."${deps.futures_util."0.3.4".futures_macro}".default or false);
    futures_task = fold recursiveUpdate {} [
      { "${deps.futures_util."0.3.4".futures_task}"."alloc" =
        (f.futures_task."${deps.futures_util."0.3.4".futures_task}"."alloc" or false) ||
        (futures_util."0.3.4"."alloc" or false) ||
        (f."futures_util"."0.3.4"."alloc" or false); }
      { "${deps.futures_util."0.3.4".futures_task}"."cfg-target-has-atomic" =
        (f.futures_task."${deps.futures_util."0.3.4".futures_task}"."cfg-target-has-atomic" or false) ||
        (futures_util."0.3.4"."cfg-target-has-atomic" or false) ||
        (f."futures_util"."0.3.4"."cfg-target-has-atomic" or false); }
      { "${deps.futures_util."0.3.4".futures_task}"."std" =
        (f.futures_task."${deps.futures_util."0.3.4".futures_task}"."std" or false) ||
        (futures_util."0.3.4"."std" or false) ||
        (f."futures_util"."0.3.4"."std" or false); }
      { "${deps.futures_util."0.3.4".futures_task}"."unstable" =
        (f.futures_task."${deps.futures_util."0.3.4".futures_task}"."unstable" or false) ||
        (futures_util."0.3.4"."unstable" or false) ||
        (f."futures_util"."0.3.4"."unstable" or false); }
      { "${deps.futures_util."0.3.4".futures_task}".default = (f.futures_task."${deps.futures_util."0.3.4".futures_task}".default or false); }
    ];
    futures_util = fold recursiveUpdate {} [
      { "0.3.4"."alloc" =
        (f.futures_util."0.3.4"."alloc" or false) ||
        (f.futures_util."0.3.4".std or false) ||
        (futures_util."0.3.4"."std" or false); }
      { "0.3.4"."async-await" =
        (f.futures_util."0.3.4"."async-await" or false) ||
        (f.futures_util."0.3.4".async-await-macro or false) ||
        (futures_util."0.3.4"."async-await-macro" or false) ||
        (f.futures_util."0.3.4".default or false) ||
        (futures_util."0.3.4"."default" or false); }
      { "0.3.4"."async-await-macro" =
        (f.futures_util."0.3.4"."async-await-macro" or false) ||
        (f.futures_util."0.3.4".default or false) ||
        (futures_util."0.3.4"."default" or false); }
      { "0.3.4"."compat" =
        (f.futures_util."0.3.4"."compat" or false) ||
        (f.futures_util."0.3.4".io-compat or false) ||
        (futures_util."0.3.4"."io-compat" or false); }
      { "0.3.4"."futures-channel" =
        (f.futures_util."0.3.4"."futures-channel" or false) ||
        (f.futures_util."0.3.4".channel or false) ||
        (futures_util."0.3.4"."channel" or false); }
      { "0.3.4"."futures-io" =
        (f.futures_util."0.3.4"."futures-io" or false) ||
        (f.futures_util."0.3.4".io or false) ||
        (futures_util."0.3.4"."io" or false); }
      { "0.3.4"."futures-macro" =
        (f.futures_util."0.3.4"."futures-macro" or false) ||
        (f.futures_util."0.3.4".async-await-macro or false) ||
        (futures_util."0.3.4"."async-await-macro" or false); }
      { "0.3.4"."futures-sink" =
        (f.futures_util."0.3.4"."futures-sink" or false) ||
        (f.futures_util."0.3.4".sink or false) ||
        (futures_util."0.3.4"."sink" or false); }
      { "0.3.4"."futures_01" =
        (f.futures_util."0.3.4"."futures_01" or false) ||
        (f.futures_util."0.3.4".compat or false) ||
        (futures_util."0.3.4"."compat" or false); }
      { "0.3.4"."io" =
        (f.futures_util."0.3.4"."io" or false) ||
        (f.futures_util."0.3.4".io-compat or false) ||
        (futures_util."0.3.4"."io-compat" or false) ||
        (f.futures_util."0.3.4".read-initializer or false) ||
        (futures_util."0.3.4"."read-initializer" or false); }
      { "0.3.4"."memchr" =
        (f.futures_util."0.3.4"."memchr" or false) ||
        (f.futures_util."0.3.4".io or false) ||
        (futures_util."0.3.4"."io" or false); }
      { "0.3.4"."proc-macro-hack" =
        (f.futures_util."0.3.4"."proc-macro-hack" or false) ||
        (f.futures_util."0.3.4".async-await-macro or false) ||
        (futures_util."0.3.4"."async-await-macro" or false); }
      { "0.3.4"."proc-macro-nested" =
        (f.futures_util."0.3.4"."proc-macro-nested" or false) ||
        (f.futures_util."0.3.4".async-await-macro or false) ||
        (futures_util."0.3.4"."async-await-macro" or false); }
      { "0.3.4"."slab" =
        (f.futures_util."0.3.4"."slab" or false) ||
        (f.futures_util."0.3.4".std or false) ||
        (futures_util."0.3.4"."std" or false); }
      { "0.3.4"."std" =
        (f.futures_util."0.3.4"."std" or false) ||
        (f.futures_util."0.3.4".channel or false) ||
        (futures_util."0.3.4"."channel" or false) ||
        (f.futures_util."0.3.4".compat or false) ||
        (futures_util."0.3.4"."compat" or false) ||
        (f.futures_util."0.3.4".default or false) ||
        (futures_util."0.3.4"."default" or false) ||
        (f.futures_util."0.3.4".io or false) ||
        (futures_util."0.3.4"."io" or false); }
      { "0.3.4"."tokio-io" =
        (f.futures_util."0.3.4"."tokio-io" or false) ||
        (f.futures_util."0.3.4".io-compat or false) ||
        (futures_util."0.3.4"."io-compat" or false); }
      { "0.3.4".default = (f.futures_util."0.3.4".default or true); }
    ];
    pin_utils."${deps.futures_util."0.3.4".pin_utils}".default = true;
    proc_macro_hack."${deps.futures_util."0.3.4".proc_macro_hack}".default = true;
    proc_macro_nested."${deps.futures_util."0.3.4".proc_macro_nested}".default = true;
    slab."${deps.futures_util."0.3.4".slab}".default = true;
  }) [
    (features_.futures_core."${deps."futures_util"."0.3.4"."futures_core"}" deps)
    (features_.futures_macro."${deps."futures_util"."0.3.4"."futures_macro"}" deps)
    (features_.futures_task."${deps."futures_util"."0.3.4"."futures_task"}" deps)
    (features_.pin_utils."${deps."futures_util"."0.3.4"."pin_utils"}" deps)
    (features_.proc_macro_hack."${deps."futures_util"."0.3.4"."proc_macro_hack"}" deps)
    (features_.proc_macro_nested."${deps."futures_util"."0.3.4"."proc_macro_nested"}" deps)
    (features_.slab."${deps."futures_util"."0.3.4"."slab"}" deps)
  ];


# end
# glib-0.9.3

  crates.glib."0.9.3" = deps: { features?(features_.glib."0.9.3" deps {}) }: buildRustCrate {
    crateName = "glib";
    version = "0.9.3";
    description = "Rust bindings for the GLib library";
    authors = [ "The Gtk-rs Project Developers" ];
    sha256 = "022isn2s69fgh3f3cjj5gwllkvvr4hjj69g6v172w5s6jrqpdj0p";
    dependencies = mapFeatures features ([
      (crates."bitflags"."${deps."glib"."0.9.3"."bitflags"}" deps)
      (crates."futures_channel"."${deps."glib"."0.9.3"."futures_channel"}" deps)
      (crates."futures_core"."${deps."glib"."0.9.3"."futures_core"}" deps)
      (crates."futures_executor"."${deps."glib"."0.9.3"."futures_executor"}" deps)
      (crates."futures_task"."${deps."glib"."0.9.3"."futures_task"}" deps)
      (crates."futures_util"."${deps."glib"."0.9.3"."futures_util"}" deps)
      (crates."glib_sys"."${deps."glib"."0.9.3"."glib_sys"}" deps)
      (crates."gobject_sys"."${deps."glib"."0.9.3"."gobject_sys"}" deps)
      (crates."lazy_static"."${deps."glib"."0.9.3"."lazy_static"}" deps)
      (crates."libc"."${deps."glib"."0.9.3"."libc"}" deps)
    ]);
    features = mkFeatures (features."glib"."0.9.3" or {});
  };
  features_.glib."0.9.3" = deps: f: updateFeatures f (rec {
    bitflags."${deps.glib."0.9.3".bitflags}".default = true;
    futures_channel."${deps.glib."0.9.3".futures_channel}".default = true;
    futures_core."${deps.glib."0.9.3".futures_core}".default = true;
    futures_executor."${deps.glib."0.9.3".futures_executor}".default = true;
    futures_task."${deps.glib."0.9.3".futures_task}".default = true;
    futures_util."${deps.glib."0.9.3".futures_util}".default = true;
    glib = fold recursiveUpdate {} [
      { "0.9.3"."v2_44" =
        (f.glib."0.9.3"."v2_44" or false) ||
        (f.glib."0.9.3".v2_46 or false) ||
        (glib."0.9.3"."v2_46" or false); }
      { "0.9.3"."v2_46" =
        (f.glib."0.9.3"."v2_46" or false) ||
        (f.glib."0.9.3".v2_48 or false) ||
        (glib."0.9.3"."v2_48" or false); }
      { "0.9.3"."v2_48" =
        (f.glib."0.9.3"."v2_48" or false) ||
        (f.glib."0.9.3".v2_50 or false) ||
        (glib."0.9.3"."v2_50" or false); }
      { "0.9.3"."v2_50" =
        (f.glib."0.9.3"."v2_50" or false) ||
        (f.glib."0.9.3".v2_52 or false) ||
        (glib."0.9.3"."v2_52" or false); }
      { "0.9.3"."v2_52" =
        (f.glib."0.9.3"."v2_52" or false) ||
        (f.glib."0.9.3".v2_54 or false) ||
        (glib."0.9.3"."v2_54" or false); }
      { "0.9.3"."v2_54" =
        (f.glib."0.9.3"."v2_54" or false) ||
        (f.glib."0.9.3".v2_56 or false) ||
        (glib."0.9.3"."v2_56" or false); }
      { "0.9.3"."v2_56" =
        (f.glib."0.9.3"."v2_56" or false) ||
        (f.glib."0.9.3".v2_58 or false) ||
        (glib."0.9.3"."v2_58" or false); }
      { "0.9.3"."v2_58" =
        (f.glib."0.9.3"."v2_58" or false) ||
        (f.glib."0.9.3".v2_60 or false) ||
        (glib."0.9.3"."v2_60" or false); }
      { "0.9.3".default = (f.glib."0.9.3".default or true); }
    ];
    glib_sys = fold recursiveUpdate {} [
      { "${deps.glib."0.9.3".glib_sys}"."dox" =
        (f.glib_sys."${deps.glib."0.9.3".glib_sys}"."dox" or false) ||
        (glib."0.9.3"."dox" or false) ||
        (f."glib"."0.9.3"."dox" or false); }
      { "${deps.glib."0.9.3".glib_sys}"."v2_44" =
        (f.glib_sys."${deps.glib."0.9.3".glib_sys}"."v2_44" or false) ||
        (glib."0.9.3"."v2_44" or false) ||
        (f."glib"."0.9.3"."v2_44" or false); }
      { "${deps.glib."0.9.3".glib_sys}"."v2_46" =
        (f.glib_sys."${deps.glib."0.9.3".glib_sys}"."v2_46" or false) ||
        (glib."0.9.3"."v2_46" or false) ||
        (f."glib"."0.9.3"."v2_46" or false); }
      { "${deps.glib."0.9.3".glib_sys}"."v2_48" =
        (f.glib_sys."${deps.glib."0.9.3".glib_sys}"."v2_48" or false) ||
        (glib."0.9.3"."v2_48" or false) ||
        (f."glib"."0.9.3"."v2_48" or false); }
      { "${deps.glib."0.9.3".glib_sys}"."v2_50" =
        (f.glib_sys."${deps.glib."0.9.3".glib_sys}"."v2_50" or false) ||
        (glib."0.9.3"."v2_50" or false) ||
        (f."glib"."0.9.3"."v2_50" or false); }
      { "${deps.glib."0.9.3".glib_sys}"."v2_52" =
        (f.glib_sys."${deps.glib."0.9.3".glib_sys}"."v2_52" or false) ||
        (glib."0.9.3"."v2_52" or false) ||
        (f."glib"."0.9.3"."v2_52" or false); }
      { "${deps.glib."0.9.3".glib_sys}"."v2_54" =
        (f.glib_sys."${deps.glib."0.9.3".glib_sys}"."v2_54" or false) ||
        (glib."0.9.3"."v2_54" or false) ||
        (f."glib"."0.9.3"."v2_54" or false); }
      { "${deps.glib."0.9.3".glib_sys}"."v2_56" =
        (f.glib_sys."${deps.glib."0.9.3".glib_sys}"."v2_56" or false) ||
        (glib."0.9.3"."v2_56" or false) ||
        (f."glib"."0.9.3"."v2_56" or false); }
      { "${deps.glib."0.9.3".glib_sys}"."v2_58" =
        (f.glib_sys."${deps.glib."0.9.3".glib_sys}"."v2_58" or false) ||
        (glib."0.9.3"."v2_58" or false) ||
        (f."glib"."0.9.3"."v2_58" or false); }
      { "${deps.glib."0.9.3".glib_sys}"."v2_60" =
        (f.glib_sys."${deps.glib."0.9.3".glib_sys}"."v2_60" or false) ||
        (glib."0.9.3"."v2_60" or false) ||
        (f."glib"."0.9.3"."v2_60" or false); }
      { "${deps.glib."0.9.3".glib_sys}".default = true; }
    ];
    gobject_sys = fold recursiveUpdate {} [
      { "${deps.glib."0.9.3".gobject_sys}"."dox" =
        (f.gobject_sys."${deps.glib."0.9.3".gobject_sys}"."dox" or false) ||
        (glib."0.9.3"."dox" or false) ||
        (f."glib"."0.9.3"."dox" or false); }
      { "${deps.glib."0.9.3".gobject_sys}"."v2_44" =
        (f.gobject_sys."${deps.glib."0.9.3".gobject_sys}"."v2_44" or false) ||
        (glib."0.9.3"."v2_44" or false) ||
        (f."glib"."0.9.3"."v2_44" or false); }
      { "${deps.glib."0.9.3".gobject_sys}"."v2_46" =
        (f.gobject_sys."${deps.glib."0.9.3".gobject_sys}"."v2_46" or false) ||
        (glib."0.9.3"."v2_46" or false) ||
        (f."glib"."0.9.3"."v2_46" or false); }
      { "${deps.glib."0.9.3".gobject_sys}"."v2_54" =
        (f.gobject_sys."${deps.glib."0.9.3".gobject_sys}"."v2_54" or false) ||
        (glib."0.9.3"."v2_54" or false) ||
        (f."glib"."0.9.3"."v2_54" or false); }
      { "${deps.glib."0.9.3".gobject_sys}".default = true; }
    ];
    lazy_static."${deps.glib."0.9.3".lazy_static}".default = true;
    libc."${deps.glib."0.9.3".libc}".default = true;
  }) [
    (features_.bitflags."${deps."glib"."0.9.3"."bitflags"}" deps)
    (features_.futures_channel."${deps."glib"."0.9.3"."futures_channel"}" deps)
    (features_.futures_core."${deps."glib"."0.9.3"."futures_core"}" deps)
    (features_.futures_executor."${deps."glib"."0.9.3"."futures_executor"}" deps)
    (features_.futures_task."${deps."glib"."0.9.3"."futures_task"}" deps)
    (features_.futures_util."${deps."glib"."0.9.3"."futures_util"}" deps)
    (features_.glib_sys."${deps."glib"."0.9.3"."glib_sys"}" deps)
    (features_.gobject_sys."${deps."glib"."0.9.3"."gobject_sys"}" deps)
    (features_.lazy_static."${deps."glib"."0.9.3"."lazy_static"}" deps)
    (features_.libc."${deps."glib"."0.9.3"."libc"}" deps)
  ];


# end
# glib-sys-0.9.1

  crates.glib_sys."0.9.1" = deps: { features?(features_.glib_sys."0.9.1" deps {}) }: buildRustCrate {
    crateName = "glib-sys";
    version = "0.9.1";
    description = "FFI bindings to libglib-2.0";
    authors = [ "The Gtk-rs Project Developers" ];
    sha256 = "1pi7xhy03nzwx5460l2f8dh57wxga3kcmqn6rhhjqgd5gxif1803";
    libName = "glib_sys";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."libc"."${deps."glib_sys"."0.9.1"."libc"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."pkg_config"."${deps."glib_sys"."0.9.1"."pkg_config"}" deps)
    ]);
    features = mkFeatures (features."glib_sys"."0.9.1" or {});
  };
  features_.glib_sys."0.9.1" = deps: f: updateFeatures f (rec {
    glib_sys = fold recursiveUpdate {} [
      { "0.9.1"."v2_44" =
        (f.glib_sys."0.9.1"."v2_44" or false) ||
        (f.glib_sys."0.9.1".v2_46 or false) ||
        (glib_sys."0.9.1"."v2_46" or false); }
      { "0.9.1"."v2_46" =
        (f.glib_sys."0.9.1"."v2_46" or false) ||
        (f.glib_sys."0.9.1".v2_48 or false) ||
        (glib_sys."0.9.1"."v2_48" or false); }
      { "0.9.1"."v2_48" =
        (f.glib_sys."0.9.1"."v2_48" or false) ||
        (f.glib_sys."0.9.1".v2_50 or false) ||
        (glib_sys."0.9.1"."v2_50" or false); }
      { "0.9.1"."v2_50" =
        (f.glib_sys."0.9.1"."v2_50" or false) ||
        (f.glib_sys."0.9.1".v2_52 or false) ||
        (glib_sys."0.9.1"."v2_52" or false); }
      { "0.9.1"."v2_52" =
        (f.glib_sys."0.9.1"."v2_52" or false) ||
        (f.glib_sys."0.9.1".v2_54 or false) ||
        (glib_sys."0.9.1"."v2_54" or false); }
      { "0.9.1"."v2_54" =
        (f.glib_sys."0.9.1"."v2_54" or false) ||
        (f.glib_sys."0.9.1".v2_56 or false) ||
        (glib_sys."0.9.1"."v2_56" or false); }
      { "0.9.1"."v2_56" =
        (f.glib_sys."0.9.1"."v2_56" or false) ||
        (f.glib_sys."0.9.1".v2_58 or false) ||
        (glib_sys."0.9.1"."v2_58" or false); }
      { "0.9.1"."v2_58" =
        (f.glib_sys."0.9.1"."v2_58" or false) ||
        (f.glib_sys."0.9.1".v2_60 or false) ||
        (glib_sys."0.9.1"."v2_60" or false); }
      { "0.9.1"."v2_60" =
        (f.glib_sys."0.9.1"."v2_60" or false) ||
        (f.glib_sys."0.9.1".v2_62 or false) ||
        (glib_sys."0.9.1"."v2_62" or false); }
      { "0.9.1".default = (f.glib_sys."0.9.1".default or true); }
    ];
    libc."${deps.glib_sys."0.9.1".libc}".default = true;
    pkg_config."${deps.glib_sys."0.9.1".pkg_config}".default = true;
  }) [
    (features_.libc."${deps."glib_sys"."0.9.1"."libc"}" deps)
    (features_.pkg_config."${deps."glib_sys"."0.9.1"."pkg_config"}" deps)
  ];


# end
# gobject-sys-0.9.1

  crates.gobject_sys."0.9.1" = deps: { features?(features_.gobject_sys."0.9.1" deps {}) }: buildRustCrate {
    crateName = "gobject-sys";
    version = "0.9.1";
    description = "FFI bindings to libgobject-2.0";
    authors = [ "The Gtk-rs Project Developers" ];
    sha256 = "0rs3l3fgqxqh6xdw9w547j2p6ndy8m368s83d2x4797aljxcs7zr";
    libName = "gobject_sys";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."glib_sys"."${deps."gobject_sys"."0.9.1"."glib_sys"}" deps)
      (crates."libc"."${deps."gobject_sys"."0.9.1"."libc"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."pkg_config"."${deps."gobject_sys"."0.9.1"."pkg_config"}" deps)
    ]);
    features = mkFeatures (features."gobject_sys"."0.9.1" or {});
  };
  features_.gobject_sys."0.9.1" = deps: f: updateFeatures f (rec {
    glib_sys."${deps.gobject_sys."0.9.1".glib_sys}".default = true;
    gobject_sys = fold recursiveUpdate {} [
      { "0.9.1"."v2_44" =
        (f.gobject_sys."0.9.1"."v2_44" or false) ||
        (f.gobject_sys."0.9.1".v2_46 or false) ||
        (gobject_sys."0.9.1"."v2_46" or false); }
      { "0.9.1"."v2_46" =
        (f.gobject_sys."0.9.1"."v2_46" or false) ||
        (f.gobject_sys."0.9.1".v2_54 or false) ||
        (gobject_sys."0.9.1"."v2_54" or false); }
      { "0.9.1"."v2_54" =
        (f.gobject_sys."0.9.1"."v2_54" or false) ||
        (f.gobject_sys."0.9.1".v2_58 or false) ||
        (gobject_sys."0.9.1"."v2_58" or false); }
      { "0.9.1"."v2_58" =
        (f.gobject_sys."0.9.1"."v2_58" or false) ||
        (f.gobject_sys."0.9.1".v2_62 or false) ||
        (gobject_sys."0.9.1"."v2_62" or false); }
      { "0.9.1".default = (f.gobject_sys."0.9.1".default or true); }
    ];
    libc."${deps.gobject_sys."0.9.1".libc}".default = true;
    pkg_config."${deps.gobject_sys."0.9.1".pkg_config}".default = true;
  }) [
    (features_.glib_sys."${deps."gobject_sys"."0.9.1"."glib_sys"}" deps)
    (features_.libc."${deps."gobject_sys"."0.9.1"."libc"}" deps)
    (features_.pkg_config."${deps."gobject_sys"."0.9.1"."pkg_config"}" deps)
  ];


# end
# gstreamer-sys-0.8.1

  crates.gstreamer_sys."0.8.1" = deps: { features?(features_.gstreamer_sys."0.8.1" deps {}) }: buildRustCrate {
    crateName = "gstreamer-sys";
    version = "0.8.1";
    description = "FFI bindings to libgstreamer-1.0";
    authors = [ "Sebastian Dröge <sebastian@centricular.com>" ];
    sha256 = "0w4y9qvzv0wi8l2z10ds7fi3fjck9m02s2jq5y2iyr19r753g6v0";
    libName = "gstreamer_sys";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."glib_sys"."${deps."gstreamer_sys"."0.8.1"."glib_sys"}" deps)
      (crates."gobject_sys"."${deps."gstreamer_sys"."0.8.1"."gobject_sys"}" deps)
      (crates."libc"."${deps."gstreamer_sys"."0.8.1"."libc"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."pkg_config"."${deps."gstreamer_sys"."0.8.1"."pkg_config"}" deps)
    ]);
    features = mkFeatures (features."gstreamer_sys"."0.8.1" or {});
  };
  features_.gstreamer_sys."0.8.1" = deps: f: updateFeatures f (rec {
    glib_sys."${deps.gstreamer_sys."0.8.1".glib_sys}".default = true;
    gobject_sys."${deps.gstreamer_sys."0.8.1".gobject_sys}".default = true;
    gstreamer_sys = fold recursiveUpdate {} [
      { "0.8.1"."v1_0_10" =
        (f.gstreamer_sys."0.8.1"."v1_0_10" or false) ||
        (f.gstreamer_sys."0.8.1".v1_2 or false) ||
        (gstreamer_sys."0.8.1"."v1_2" or false); }
      { "0.8.1"."v1_10" =
        (f.gstreamer_sys."0.8.1"."v1_10" or false) ||
        (f.gstreamer_sys."0.8.1".v1_12 or false) ||
        (gstreamer_sys."0.8.1"."v1_12" or false); }
      { "0.8.1"."v1_12" =
        (f.gstreamer_sys."0.8.1"."v1_12" or false) ||
        (f.gstreamer_sys."0.8.1".v1_14 or false) ||
        (gstreamer_sys."0.8.1"."v1_14" or false); }
      { "0.8.1"."v1_14" =
        (f.gstreamer_sys."0.8.1"."v1_14" or false) ||
        (f.gstreamer_sys."0.8.1".v1_16 or false) ||
        (gstreamer_sys."0.8.1"."v1_16" or false); }
      { "0.8.1"."v1_16" =
        (f.gstreamer_sys."0.8.1"."v1_16" or false) ||
        (f.gstreamer_sys."0.8.1".dox or false) ||
        (gstreamer_sys."0.8.1"."dox" or false); }
      { "0.8.1"."v1_2" =
        (f.gstreamer_sys."0.8.1"."v1_2" or false) ||
        (f.gstreamer_sys."0.8.1".v1_2_3 or false) ||
        (gstreamer_sys."0.8.1"."v1_2_3" or false); }
      { "0.8.1"."v1_2_3" =
        (f.gstreamer_sys."0.8.1"."v1_2_3" or false) ||
        (f.gstreamer_sys."0.8.1".v1_4 or false) ||
        (gstreamer_sys."0.8.1"."v1_4" or false); }
      { "0.8.1"."v1_4" =
        (f.gstreamer_sys."0.8.1"."v1_4" or false) ||
        (f.gstreamer_sys."0.8.1".v1_6 or false) ||
        (gstreamer_sys."0.8.1"."v1_6" or false); }
      { "0.8.1"."v1_6" =
        (f.gstreamer_sys."0.8.1"."v1_6" or false) ||
        (f.gstreamer_sys."0.8.1".v1_8 or false) ||
        (gstreamer_sys."0.8.1"."v1_8" or false); }
      { "0.8.1"."v1_8" =
        (f.gstreamer_sys."0.8.1"."v1_8" or false) ||
        (f.gstreamer_sys."0.8.1".v1_10 or false) ||
        (gstreamer_sys."0.8.1"."v1_10" or false); }
      { "0.8.1".default = (f.gstreamer_sys."0.8.1".default or true); }
    ];
    libc."${deps.gstreamer_sys."0.8.1".libc}".default = true;
    pkg_config."${deps.gstreamer_sys."0.8.1".pkg_config}".default = true;
  }) [
    (features_.glib_sys."${deps."gstreamer_sys"."0.8.1"."glib_sys"}" deps)
    (features_.gobject_sys."${deps."gstreamer_sys"."0.8.1"."gobject_sys"}" deps)
    (features_.libc."${deps."gstreamer_sys"."0.8.1"."libc"}" deps)
    (features_.pkg_config."${deps."gstreamer_sys"."0.8.1"."pkg_config"}" deps)
  ];


# end
# gtypes-0.2.0

  crates.gtypes."0.2.0" = deps: { features?(features_.gtypes."0.2.0" deps {}) }: buildRustCrate {
    crateName = "gtypes";
    version = "0.2.0";
    description = "Fundamental type definitions for GLib-based APIs.";
    authors = [ "Mikhail Zabaluev <mikhail.zabaluev@gmail.com>" ];
    sha256 = "1mdrqavhv0fdrzjvbrizbw5120lcsbdyyy1kgb3ppdp2039nhzsm";
    libPath = "gtypes.rs";
    dependencies = mapFeatures features ([
      (crates."libc"."${deps."gtypes"."0.2.0"."libc"}" deps)
    ]);
  };
  features_.gtypes."0.2.0" = deps: f: updateFeatures f (rec {
    gtypes."0.2.0".default = (f.gtypes."0.2.0".default or true);
    libc."${deps.gtypes."0.2.0".libc}".default = true;
  }) [
    (features_.libc."${deps."gtypes"."0.2.0"."libc"}" deps)
  ];


# end
# lazy_static-1.4.0

  crates.lazy_static."1.4.0" = deps: { features?(features_.lazy_static."1.4.0" deps {}) }: buildRustCrate {
    crateName = "lazy_static";
    version = "1.4.0";
    description = "A macro for declaring lazily evaluated statics in Rust.";
    authors = [ "Marvin Löbel <loebel.marvin@gmail.com>" ];
    sha256 = "13h6sdghdcy7vcqsm2gasfw3qg7ssa0fl3sw7lq6pdkbk52wbyfr";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."lazy_static"."1.4.0" or {});
  };
  features_.lazy_static."1.4.0" = deps: f: updateFeatures f (rec {
    lazy_static = fold recursiveUpdate {} [
      { "1.4.0"."spin" =
        (f.lazy_static."1.4.0"."spin" or false) ||
        (f.lazy_static."1.4.0".spin_no_std or false) ||
        (lazy_static."1.4.0"."spin_no_std" or false); }
      { "1.4.0".default = (f.lazy_static."1.4.0".default or true); }
    ];
  }) [];


# end
# libc-0.2.67

  crates.libc."0.2.67" = deps: { features?(features_.libc."0.2.67" deps {}) }: buildRustCrate {
    crateName = "libc";
    version = "0.2.67";
    description = "Raw FFI bindings to platform libraries like libc.\n";
    authors = [ "The Rust Project Developers" ];
    sha256 = "079p266r5md4yk6j2938fs9xk0py1srasprc6vdnsdshd9fh7yny";
    build = "build.rs";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."libc"."0.2.67" or {});
  };
  features_.libc."0.2.67" = deps: f: updateFeatures f (rec {
    libc = fold recursiveUpdate {} [
      { "0.2.67"."align" =
        (f.libc."0.2.67"."align" or false) ||
        (f.libc."0.2.67".rustc-dep-of-std or false) ||
        (libc."0.2.67"."rustc-dep-of-std" or false); }
      { "0.2.67"."rustc-std-workspace-core" =
        (f.libc."0.2.67"."rustc-std-workspace-core" or false) ||
        (f.libc."0.2.67".rustc-dep-of-std or false) ||
        (libc."0.2.67"."rustc-dep-of-std" or false); }
      { "0.2.67"."std" =
        (f.libc."0.2.67"."std" or false) ||
        (f.libc."0.2.67".default or false) ||
        (libc."0.2.67"."default" or false) ||
        (f.libc."0.2.67".use_std or false) ||
        (libc."0.2.67"."use_std" or false); }
      { "0.2.67".default = (f.libc."0.2.67".default or true); }
    ];
  }) [];


# end
# pin-utils-0.1.0-alpha.4

  crates.pin_utils."0.1.0-alpha.4" = deps: { features?(features_.pin_utils."0.1.0-alpha.4" deps {}) }: buildRustCrate {
    crateName = "pin-utils";
    version = "0.1.0-alpha.4";
    description = "Utilities for pinning\n";
    authors = [ "Josef Brandl <mail@josefbrandl.de>" ];
    edition = "2018";
    sha256 = "1fl7h1f6gr7qj903k3ir2vw993gbj4dd775s0idq4pzsbjqjj3x1";
  };
  features_.pin_utils."0.1.0-alpha.4" = deps: f: updateFeatures f (rec {
    pin_utils."0.1.0-alpha.4".default = (f.pin_utils."0.1.0-alpha.4".default or true);
  }) [];


# end
# pkg-config-0.3.17

  crates.pkg_config."0.3.17" = deps: { features?(features_.pkg_config."0.3.17" deps {}) }: buildRustCrate {
    crateName = "pkg-config";
    version = "0.3.17";
    description = "A library to run the pkg-config system tool at build time in order to be used in\nCargo build scripts.\n";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "0f83cnls5a6y97k8b3a54xhmyrjybj29qq6rwvz450qdsy5ff8vj";
  };
  features_.pkg_config."0.3.17" = deps: f: updateFeatures f (rec {
    pkg_config."0.3.17".default = (f.pkg_config."0.3.17".default or true);
  }) [];


# end
# proc-macro-hack-0.5.11

  crates.proc_macro_hack."0.5.11" = deps: { features?(features_.proc_macro_hack."0.5.11" deps {}) }: buildRustCrate {
    crateName = "proc-macro-hack";
    version = "0.5.11";
    description = "Procedural macros in expression position";
    authors = [ "David Tolnay <dtolnay@gmail.com>" ];
    edition = "2018";
    sha256 = "0cnpfl5x7cac9d94in5r93b29frski33jhvgp7n6qih9gpsxqn80";
    procMacro = true;
    dependencies = mapFeatures features ([
      (crates."proc_macro2"."${deps."proc_macro_hack"."0.5.11"."proc_macro2"}" deps)
      (crates."quote"."${deps."proc_macro_hack"."0.5.11"."quote"}" deps)
      (crates."syn"."${deps."proc_macro_hack"."0.5.11"."syn"}" deps)
    ]);
  };
  features_.proc_macro_hack."0.5.11" = deps: f: updateFeatures f (rec {
    proc_macro2."${deps.proc_macro_hack."0.5.11".proc_macro2}".default = true;
    proc_macro_hack."0.5.11".default = (f.proc_macro_hack."0.5.11".default or true);
    quote."${deps.proc_macro_hack."0.5.11".quote}".default = true;
    syn."${deps.proc_macro_hack."0.5.11".syn}".default = true;
  }) [
    (features_.proc_macro2."${deps."proc_macro_hack"."0.5.11"."proc_macro2"}" deps)
    (features_.quote."${deps."proc_macro_hack"."0.5.11"."quote"}" deps)
    (features_.syn."${deps."proc_macro_hack"."0.5.11"."syn"}" deps)
  ];


# end
# proc-macro-nested-0.1.3

  crates.proc_macro_nested."0.1.3" = deps: { features?(features_.proc_macro_nested."0.1.3" deps {}) }: buildRustCrate {
    crateName = "proc-macro-nested";
    version = "0.1.3";
    description = "Support for nested proc-macro-hack invocations";
    authors = [ "David Tolnay <dtolnay@gmail.com>" ];
    sha256 = "1xbai316ygv2gxc9vjb8b2nr6xia3ahc19nh66vkwnvz1nc90gya";
  };
  features_.proc_macro_nested."0.1.3" = deps: f: updateFeatures f (rec {
    proc_macro_nested."0.1.3".default = (f.proc_macro_nested."0.1.3".default or true);
  }) [];


# end
# proc-macro2-1.0.9

  crates.proc_macro2."1.0.9" = deps: { features?(features_.proc_macro2."1.0.9" deps {}) }: buildRustCrate {
    crateName = "proc-macro2";
    version = "1.0.9";
    description = "A stable implementation of the upcoming new `proc_macro` API. Comes with an\noption, off by default, to also reimplement itself in terms of the upstream\nunstable API.\n";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    edition = "2018";
    sha256 = "1kyip1rs0j3v1wafjn4ss03djs05ffxs2y7c2zi5064skhpxfzav";
    dependencies = mapFeatures features ([
      (crates."unicode_xid"."${deps."proc_macro2"."1.0.9"."unicode_xid"}" deps)
    ]);
    features = mkFeatures (features."proc_macro2"."1.0.9" or {});
  };
  features_.proc_macro2."1.0.9" = deps: f: updateFeatures f (rec {
    proc_macro2 = fold recursiveUpdate {} [
      { "1.0.9"."proc-macro" =
        (f.proc_macro2."1.0.9"."proc-macro" or false) ||
        (f.proc_macro2."1.0.9".default or false) ||
        (proc_macro2."1.0.9"."default" or false); }
      { "1.0.9".default = (f.proc_macro2."1.0.9".default or true); }
    ];
    unicode_xid."${deps.proc_macro2."1.0.9".unicode_xid}".default = true;
  }) [
    (features_.unicode_xid."${deps."proc_macro2"."1.0.9"."unicode_xid"}" deps)
  ];


# end
# quote-1.0.3

  crates.quote."1.0.3" = deps: { features?(features_.quote."1.0.3" deps {}) }: buildRustCrate {
    crateName = "quote";
    version = "1.0.3";
    description = "Quasi-quoting macro quote!(...)";
    authors = [ "David Tolnay <dtolnay@gmail.com>" ];
    edition = "2018";
    sha256 = "093chkpg7dc8f86kz0hlxzyfxvbix3xpkmlbhilf0wji228ad35c";
    dependencies = mapFeatures features ([
      (crates."proc_macro2"."${deps."quote"."1.0.3"."proc_macro2"}" deps)
    ]);
    features = mkFeatures (features."quote"."1.0.3" or {});
  };
  features_.quote."1.0.3" = deps: f: updateFeatures f (rec {
    proc_macro2 = fold recursiveUpdate {} [
      { "${deps.quote."1.0.3".proc_macro2}"."proc-macro" =
        (f.proc_macro2."${deps.quote."1.0.3".proc_macro2}"."proc-macro" or false) ||
        (quote."1.0.3"."proc-macro" or false) ||
        (f."quote"."1.0.3"."proc-macro" or false); }
      { "${deps.quote."1.0.3".proc_macro2}".default = (f.proc_macro2."${deps.quote."1.0.3".proc_macro2}".default or false); }
    ];
    quote = fold recursiveUpdate {} [
      { "1.0.3"."proc-macro" =
        (f.quote."1.0.3"."proc-macro" or false) ||
        (f.quote."1.0.3".default or false) ||
        (quote."1.0.3"."default" or false); }
      { "1.0.3".default = (f.quote."1.0.3".default or true); }
    ];
  }) [
    (features_.proc_macro2."${deps."quote"."1.0.3"."proc_macro2"}" deps)
  ];


# end
# slab-0.4.2

  crates.slab."0.4.2" = deps: { features?(features_.slab."0.4.2" deps {}) }: buildRustCrate {
    crateName = "slab";
    version = "0.4.2";
    description = "Pre-allocated storage for a uniform data type";
    authors = [ "Carl Lerche <me@carllerche.com>" ];
    sha256 = "0h1l2z7qy6207kv0v3iigdf2xfk9yrhbwj1svlxk6wxjmdxvgdl7";
  };
  features_.slab."0.4.2" = deps: f: updateFeatures f (rec {
    slab."0.4.2".default = (f.slab."0.4.2".default or true);
  }) [];


# end
# syn-1.0.16

  crates.syn."1.0.16" = deps: { features?(features_.syn."1.0.16" deps {}) }: buildRustCrate {
    crateName = "syn";
    version = "1.0.16";
    description = "Parser for Rust source code";
    authors = [ "David Tolnay <dtolnay@gmail.com>" ];
    edition = "2018";
    sha256 = "0yb2bk0hjglbablj1mh2p1gn3c3y44hwjih8plgrvazpfwzkrm6f";
    dependencies = mapFeatures features ([
      (crates."proc_macro2"."${deps."syn"."1.0.16"."proc_macro2"}" deps)
      (crates."unicode_xid"."${deps."syn"."1.0.16"."unicode_xid"}" deps)
    ]
      ++ (if features.syn."1.0.16".quote or false then [ (crates.quote."${deps."syn"."1.0.16".quote}" deps) ] else []));
    features = mkFeatures (features."syn"."1.0.16" or {});
  };
  features_.syn."1.0.16" = deps: f: updateFeatures f (rec {
    proc_macro2 = fold recursiveUpdate {} [
      { "${deps.syn."1.0.16".proc_macro2}"."proc-macro" =
        (f.proc_macro2."${deps.syn."1.0.16".proc_macro2}"."proc-macro" or false) ||
        (syn."1.0.16"."proc-macro" or false) ||
        (f."syn"."1.0.16"."proc-macro" or false); }
      { "${deps.syn."1.0.16".proc_macro2}".default = (f.proc_macro2."${deps.syn."1.0.16".proc_macro2}".default or false); }
    ];
    quote = fold recursiveUpdate {} [
      { "${deps.syn."1.0.16".quote}"."proc-macro" =
        (f.quote."${deps.syn."1.0.16".quote}"."proc-macro" or false) ||
        (syn."1.0.16"."proc-macro" or false) ||
        (f."syn"."1.0.16"."proc-macro" or false); }
      { "${deps.syn."1.0.16".quote}".default = (f.quote."${deps.syn."1.0.16".quote}".default or false); }
    ];
    syn = fold recursiveUpdate {} [
      { "1.0.16"."clone-impls" =
        (f.syn."1.0.16"."clone-impls" or false) ||
        (f.syn."1.0.16".default or false) ||
        (syn."1.0.16"."default" or false); }
      { "1.0.16"."derive" =
        (f.syn."1.0.16"."derive" or false) ||
        (f.syn."1.0.16".default or false) ||
        (syn."1.0.16"."default" or false); }
      { "1.0.16"."parsing" =
        (f.syn."1.0.16"."parsing" or false) ||
        (f.syn."1.0.16".default or false) ||
        (syn."1.0.16"."default" or false); }
      { "1.0.16"."printing" =
        (f.syn."1.0.16"."printing" or false) ||
        (f.syn."1.0.16".default or false) ||
        (syn."1.0.16"."default" or false); }
      { "1.0.16"."proc-macro" =
        (f.syn."1.0.16"."proc-macro" or false) ||
        (f.syn."1.0.16".default or false) ||
        (syn."1.0.16"."default" or false); }
      { "1.0.16"."quote" =
        (f.syn."1.0.16"."quote" or false) ||
        (f.syn."1.0.16".printing or false) ||
        (syn."1.0.16"."printing" or false); }
      { "1.0.16".default = (f.syn."1.0.16".default or true); }
    ];
    unicode_xid."${deps.syn."1.0.16".unicode_xid}".default = true;
  }) [
    (features_.proc_macro2."${deps."syn"."1.0.16"."proc_macro2"}" deps)
    (features_.quote."${deps."syn"."1.0.16"."quote"}" deps)
    (features_.unicode_xid."${deps."syn"."1.0.16"."unicode_xid"}" deps)
  ];


# end
# unicode-xid-0.2.0

  crates.unicode_xid."0.2.0" = deps: { features?(features_.unicode_xid."0.2.0" deps {}) }: buildRustCrate {
    crateName = "unicode-xid";
    version = "0.2.0";
    description = "Determine whether characters have the XID_Start\nor XID_Continue properties according to\nUnicode Standard Annex #31.\n";
    authors = [ "erick.tryzelaar <erick.tryzelaar@gmail.com>" "kwantam <kwantam@gmail.com>" ];
    sha256 = "1c85gb3p3qhbjvfyjb31m06la4f024jx319k10ig7n47dz2fk8v7";
    features = mkFeatures (features."unicode_xid"."0.2.0" or {});
  };
  features_.unicode_xid."0.2.0" = deps: f: updateFeatures f (rec {
    unicode_xid."0.2.0".default = (f.unicode_xid."0.2.0".default or true);
  }) [];


# end
}
