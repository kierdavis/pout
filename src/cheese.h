/*
 * Copyright (C) 2007 Copyright (C) 2007 daniel g. siegel <dgsiegel@gmail.com>
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
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

#ifndef __CHEESE_H__
#define __CHEESE_H__

#include <glib.h>
#include <gtk/gtk.h>

//FIXME: provide option to choose the folder
#define SAVE_FOLDER_DEFAULT  	 "images/"
//FIXME: provide option to choose the naming of the photos
#define PHOTO_NAME_DEFAULT	 "Picture"
//FIXME: provide option to choose the format
#define PHOTO_NAME_SUFFIX_DEFAULT ".jpg"

void create_photo(unsigned char *data, int width, int height);

gboolean set_screen_x_window_id();
void on_cheese_window_close_cb(GtkWidget *widget, gpointer data);

#endif /* __CHEESE_H__ */
