/*
 * Copyright © 2011 Lucas Baudin <xapantu@gmail.com>
 *
 * Licensed under the GNU General Public License Version 2
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "config.h"

#include <stdlib.h>

#include <glib/gi18n.h>
#include <gtk/gtk.h>
#include <gst/gst.h>
#include <clutter-gtk/clutter-gtk.h>
#include "cheese-gtk.h"

int main (int argc, gchar *argv[])
{
    gtk_test_init (&argc, &argv, NULL);
    if (!cheese_gtk_init (&argc, &argv))
        return EXIT_FAILURE;

    return g_test_run ();
}
