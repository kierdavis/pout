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

#include "cheese-config.h"

#include <gst/interfaces/xoverlay.h>
#include <glib.h>
#include <gtk/gtk.h>
#include <libgnomevfs/gnome-vfs.h>

#include "cheese.h"
#include "cheese-window.h"
#include "cheese-pipeline-photo.h"
#include "cheese-effects-widget.h"
#include "cheese-fileutil.h"

G_DEFINE_TYPE (Pipeline, pipeline, G_TYPE_OBJECT)

static GObjectClass *parent_class = NULL;

typedef struct _PipelinePrivate PipelinePrivate;

struct _PipelinePrivate
{
  int picture_requested;

  GstElement *source;
  GstElement *ffmpeg1, *ffmpeg2, *ffmpeg3, *ffmpeg4;
  GstElement *videoscale;
  GstElement *tee;
  GstElement *queuevid, *queueimg;
  GstElement *caps;
  GstElement *effect;
  GstCaps *filter;
};

#define PIPELINE_GET_PRIVATE(o) (G_TYPE_INSTANCE_GET_PRIVATE ((o), PIPELINE_TYPE, PipelinePrivate))

// private methods
static gboolean cb_have_data(GstElement *element, GstBuffer *buffer, GstPad *pad, gpointer user_data);
static void pipeline_lens_open(Pipeline *self);
static void create_photo(unsigned char *data, int width, int height);

void
pipeline_set_play(Pipeline *self)
{
  gst_element_set_state(self->pipeline, GST_STATE_PLAYING);
  return;
}

void
pipeline_set_stop(Pipeline *self)
{
  gst_element_set_state(self->pipeline, GST_STATE_NULL);
  return;
}

void
pipeline_button_clicked(GtkWidget *widget, gpointer self)
{
  pipeline_lens_open(self);
  return;
}

static void
pipeline_lens_open(Pipeline *self)
{
  PipelinePrivate *priv = PIPELINE_GET_PRIVATE(self);
  priv->picture_requested = TRUE;
  return;
}

GstElement *
pipeline_get_ximagesink(Pipeline *self)
{
  return self->ximagesink;
}

GstElement *
pipeline_get_fakesink(Pipeline *self)
{
  return self->fakesink;
}

GstElement *
pipeline_get_pipeline(Pipeline *self)
{
  return self->pipeline;
}

void
pipeline_change_effect(gpointer self)
{
  PipelinePrivate *priv = PIPELINE_GET_PRIVATE(self);
  gchar *effect = cheese_effects_get_selection();

  if (effect != NULL) {
    pipeline_set_stop(PIPELINE(self));

    gst_element_unlink(priv->ffmpeg2, priv->effect);
    gst_element_unlink(priv->effect, priv->ffmpeg3);
    gst_bin_remove(GST_BIN(PIPELINE(self)->pipeline), priv->effect);

    g_print("changing to effect: %s\n", effect);
    priv->effect = gst_parse_bin_from_description(effect, TRUE, NULL);
    gst_bin_add(GST_BIN(PIPELINE(self)->pipeline), priv->effect);

    gst_element_link(priv->ffmpeg2, priv->effect);
    gst_element_link(priv->effect, priv->ffmpeg3);

    pipeline_set_play(self);
  }
}

void
pipeline_create(Pipeline *self) {

  gboolean link_ok; 

  PipelinePrivate *priv = PIPELINE_GET_PRIVATE(self);

  self->pipeline = gst_pipeline_new("pipeline");
  priv->source = gst_element_factory_make("gconfvideosrc", "v4l2src");
  // if you want to test without having a webcam
  // priv->source = gst_element_factory_make("videotestsrc", "v4l2src");

  gst_bin_add(GST_BIN(self->pipeline), priv->source);
  priv->ffmpeg1 = gst_element_factory_make("ffmpegcolorspace", "ffmpegcolorspace");
  gst_bin_add(GST_BIN(self->pipeline), priv->ffmpeg1);

  priv->effect = gst_element_factory_make("identity", "effect");
  gst_bin_add(GST_BIN(self->pipeline), priv->effect);

  priv->videoscale = gst_element_factory_make("videoscale", "videoscale");
  gst_bin_add(GST_BIN(self->pipeline), priv->videoscale);

  priv->ffmpeg2 = gst_element_factory_make("ffmpegcolorspace", "ffmpegcolorspace2");
  gst_bin_add(GST_BIN(self->pipeline), priv->ffmpeg2);

  priv->ffmpeg3 = gst_element_factory_make("ffmpegcolorspace", "ffmpegcolorspace3");
  gst_bin_add(GST_BIN(self->pipeline), priv->ffmpeg3);

  priv->ffmpeg4 = gst_element_factory_make("ffmpegcolorspace", "ffmpegcolorspace4");
  gst_bin_add(GST_BIN(self->pipeline), priv->ffmpeg4);

  priv->tee = gst_element_factory_make("tee", "tee");
  gst_bin_add(GST_BIN(self->pipeline), priv->tee);

  priv->queuevid = gst_element_factory_make("queue", "queuevid");
  gst_bin_add(GST_BIN(self->pipeline), priv->queuevid);

  priv->queueimg = gst_element_factory_make("queue", "queueimg");
  gst_bin_add(GST_BIN(self->pipeline), priv->queueimg);

  self->ximagesink = gst_element_factory_make("gconfvideosink", "gconfvideosink");
  gst_bin_add(GST_BIN(self->pipeline), self->ximagesink);

  self->fakesink = gst_element_factory_make("fakesink", "fakesink");
  gst_bin_add(GST_BIN(self->pipeline), self->fakesink);

  /*
   * the pipeline looks like this:
   * gconfvideosrc -> ffmpegcsp
   *                    '-> videoscale
   *                         '-> ffmpegcsp -> effects -> ffmpegcsp 
   *    -------------------------------------------------------'
   *    '--> tee (filtered) -> queue-> ffmpegcsp -> gconfvideosink
   *          |
   *       queueimg -> fakesink -> pixbuf (gets picture from data)
   */

  gst_element_link(priv->source, priv->ffmpeg1);

  //FIXME: ugly hack to resize all resolutions to 640x480... wahh
  priv->filter = gst_caps_new_simple("video/x-raw-rgb",
      "width", G_TYPE_INT, 640,
      "height", G_TYPE_INT, 480, NULL);

  link_ok = gst_element_link_filtered(priv->ffmpeg1, priv->videoscale, priv->filter);
  if (!link_ok) {
    g_warning("Failed to link elements!");
  }
  //gst_element_link(priv->ffmpeg1, priv->videoscale);
  gst_element_link(priv->videoscale, priv->ffmpeg2);
  gst_element_link(priv->ffmpeg2, priv->effect);
  gst_element_link(priv->effect, priv->ffmpeg3);

  priv->filter = gst_caps_new_simple("video/x-raw-rgb",
      "bpp", G_TYPE_INT, 24,
      "depth", G_TYPE_INT, 24, NULL);

  link_ok = gst_element_link_filtered(priv->ffmpeg3, priv->tee, priv->filter);
  if (!link_ok) {
    g_warning("Failed to link elements!");
  }

  gst_element_link(priv->tee, priv->queuevid);
  gst_element_link(priv->queuevid, priv->ffmpeg4);

  gst_element_link(priv->ffmpeg4, self->ximagesink);

  // setting back the format to get nice pictures
  priv->filter = gst_caps_new_simple("video/x-raw-rgb", NULL);
  link_ok = gst_element_link_filtered(priv->tee, priv->queueimg, priv->filter);
  if (!link_ok) {
    g_warning("Failed to link elements!");
  }
  //gst_element_link(priv->tee, priv->queueimg);

  gst_element_link(priv->queueimg, self->fakesink);
  g_object_set(G_OBJECT(self->fakesink), "signal-handoffs", TRUE, NULL);

  g_signal_connect(G_OBJECT(self->fakesink), "handoff", 
                   G_CALLBACK(cb_have_data), self);

}

static gboolean
cb_have_data(GstElement *element, GstBuffer *buffer, GstPad *pad, gpointer self)
{
  PipelinePrivate *priv = PIPELINE_GET_PRIVATE(self);

  unsigned char *data_photo = (unsigned char *)GST_BUFFER_DATA(buffer);
  if (priv->picture_requested) {
    GstCaps *caps;
    const GstStructure *structure;

    int width, height;

    caps = gst_buffer_get_caps(buffer);
    structure = gst_caps_get_structure(caps, 0);
    gst_structure_get_int(structure, "width", &width);
    gst_structure_get_int(structure, "height", &height);

    create_photo(data_photo, width, height);
    priv->picture_requested = FALSE;
  }
  return TRUE;
}

void
create_photo(unsigned char *data, int width, int height)
{
  int i;
  gchar *filename = NULL;
  GnomeVFSURI *uri;
  GdkPixbuf *pixbuf;

  i = 1;
  filename = cheese_fileutil_get_photo_filename(i);

  uri = gnome_vfs_uri_new(filename);

  while (gnome_vfs_uri_exists(uri)) {
    i++;
    filename = cheese_fileutil_get_photo_filename(i);
    g_free(uri);
    uri = gnome_vfs_uri_new(filename);
  }
  g_free(uri);

  pixbuf = gdk_pixbuf_new_from_data (data, GDK_COLORSPACE_RGB, FALSE, 8, 
                                     width, height, width * 3, NULL, NULL);

  gdk_pixbuf_save(pixbuf, filename, "jpeg", NULL, NULL);
  g_object_unref(G_OBJECT(pixbuf));

  g_print("Photo saved: %s (%dx%d)\n", filename, width, height);
}

void
pipeline_finalize(GObject *object)
{
  PipelinePrivate *priv = PIPELINE_GET_PRIVATE(object);
  gst_caps_unref(priv->filter);

  (*parent_class->finalize) (object);
  return;
}

Pipeline *
pipeline_new(void)
{
  Pipeline *self = g_object_new(PIPELINE_TYPE, NULL);

  return self;
}

void
pipeline_class_init(PipelineClass *klass)
{
  GObjectClass *object_class;

  parent_class = g_type_class_peek_parent(klass);
  object_class = (GObjectClass*) klass;

  object_class->finalize = pipeline_finalize;
  g_type_class_add_private(klass, sizeof(PipelinePrivate));

  G_OBJECT_CLASS(klass)->finalize = (GObjectFinalizeFunc) pipeline_finalize;
}

void
pipeline_init(Pipeline *self)
{
}

