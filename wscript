#! /usr/bin/env python
# encoding: utf-8
#
# Copyright (C) 2007 daniel g. siegel <dgsiegel@gmail.com>
# Copyright (C) 2007 Jaap A. Haitsma <jaap@haitsma.org>
#
# Licensed under the GNU General Public License Version 2
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.

import os
import Params, gnome

# the following two variables are used by the target "waf dist"
VERSION='0.3.0'
APPNAME='cheese'

# these variables are mandatory ('/' are converted automatically)
srcdir = '.'
blddir = '_build_'

def set_options(opt):
	opt.add_option('--maintainer', action="store_true", default=False, help="enable maintainer mode", dest="maintainer")
	pass

def configure(conf):
	conf.check_tool('gcc gnome')

	conf.check_pkg('gobject-2.0', destvar='GOBJECT', vnum='2.12.0')
	conf.check_pkg('glib-2.0', destvar='GLIB', vnum='2.12.1' )
	conf.check_pkg('cairo', destvar='CAIRO', vnum='1.4.0')
	conf.check_pkg('gdk-2.0', destvar='GDK', vnum='2.12.0')
	conf.check_pkg('gtk+-2.0', destvar='GTK', vnum='2.10.0')
	conf.check_pkg('libglade-2.0', destvar='LIBGLADE', vnum='2.0.0')
	conf.check_pkg('hal', destvar='HAL', vnum='0.5.0')
	conf.check_pkg('gstreamer-0.10', destvar='GSTREAMER', vnum='0.10.15')
	conf.check_pkg('gstreamer-plugins-base-0.10', destvar='GSTREAMER_PLUGINS_BASE', vnum='0.10.14')
	conf.check_pkg('gnome-vfs-2.0', destvar='GNOME_VFS', vnum='2.18.0')
	conf.check_pkg('libgnomeui-2.0', destvar='LIBGNOMEUI', vnum='2.20.0')
	conf.check_pkg('libebook-1.2', destvar='LIBEBOOK', vnum='1.12.0')
	conf.check_pkg('xxf86vm', destvar='XXF86VM', vnum='1.0.0')
	conf.env['LIB_GSTREAMER'] += ['gstinterfaces-0.10']

	conf.add_define('VERSION', VERSION)
	conf.add_define('GETTEXT_PACKAGE', 'cheese')
	conf.add_define('PACKAGE', 'cheese')

	if Params.g_options.maintainer:
	  import os
	  conf.add_define('PACKAGE_DATADIR', os.getcwd() + '/data/')
	  print ""
	  print "*******************************************************************"
	  print "**                 MAINTAINER MODE ENABLED.                      **"
	  print "**       CHEESE CAN BE RUN BY EXECUTING CHEESE IN _build_        **"
	  print "**               BUT DO NOT TRY TO INSTALL IT                    **"
	  print "*******************************************************************"
	  print ""
	else:
	  conf.add_define('PACKAGE_DATADIR', conf.env['DATADIR'] + '/cheese')


	conf.add_define('PACKAGE_DOCDIR', conf.env['DATADIR'] + '/share/doc/cheese')
	conf.add_define('PACKAGE_LOCALEDIR', conf.env['DATADIR'] + '/locale')
	conf.env.append_value('CCFLAGS', '-DHAVE_CONFIG_H')


	conf.write_config_header('config.h')

def build(bld):
	# process subfolders from here
	bld.add_subdirs('src data po')

def shutdown():
	gnome.postinstall()

def install():
	print "hello"
