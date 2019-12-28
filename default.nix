{ stdenv, intltool, wrapGAppsHook, libcanberra-gtk3
, pkgconfig, gtk3, glib, clutter-gtk, clutter-gst, udev, gst_all_1, itstool
, libgudev, vala, appstream-glib
, libtool
, librsvg, gdk_pixbuf, gnome3, libxml2
, cargo, nix-gitignore }:

with gnome3;

stdenv.mkDerivation rec {
  name = "pout";

  src = nix-gitignore.gitignoreSourcePure ["rust/target"] ./.;

  passthru = {
    updateScript = gnome3.updateScript { packageName = "cheese"; attrPath = "gnome3.cheese"; };
  };

  nativeBuildInputs = [
    pkgconfig intltool itstool vala wrapGAppsHook libxml2 appstream-glib
    yelp-tools gnome-common libtool cargo
  ];
  buildInputs = [ gtk3 glib gnome-video-effects
                  gdk_pixbuf adwaita-icon-theme librsvg udev gst_all_1.gstreamer
                  gst_all_1.gst-plugins-base gst_all_1.gst-plugins-good gnome-desktop
                  gst_all_1.gst-plugins-bad clutter-gtk clutter-gst
                  libcanberra-gtk3 libgudev ];

  # autogen.sh automatically runs configure after doing the automake/autoconf dance.
  configureScript = "./autogen.sh";

  preFixup = ''
    gappsWrapperArgs+=(
      # Effects
      --prefix XDG_DATA_DIRS : "${gnome-video-effects}/share"
      # vp8enc preset
      --prefix GST_PRESET_PATH : "${gst_all_1.gst-plugins-good}/share/gstreamer-1.0/presets"
      # Thumbnailers
      --prefix XDG_DATA_DIRS : "${gdk_pixbuf}/share"
      --prefix XDG_DATA_DIRS : "${totem}/share"
    )
  '';

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    homepage = https://wiki.gnome.org/Apps/Cheese;
    description = "Take photos and videos with your webcam, with fun graphical effects";
    maintainers = gnome3.maintainers;
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
