/*
 * Ubicom Network Player
 *
 * (C) Copyright 2009, Ubicom, Inc.
 * Celil URGAN curgan@ubicom.com
 *
 * The Network Player Reference Code is free software: you can redistribute
 * it and/or modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation, either version 2 of the
 * License, or (at your option) any later version.
 *
 * The Network Player Reference Code is distributed in the hope that it
 * will be useful, but WITHOUT ANY WARRANTY; without even the implied
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
 * the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with the Network Audio Device Reference Code.  If not,
 * see <http://www.gnu.org/licenses/>.
 *
 */
#define STATUSBAR_H
#ifdef STATUSBAR_H

#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>
#include <time.h>
#include <dlfcn.h>

#include <lite/lite.h>
#include <lite/window.h>
#include <lite/util.h>

#include <leck/textbutton.h>
#include <leck/list.h>
#include <leck/image.h>
#include <leck/check.h>
#include <leck/label.h>
#include <string.h>

#include <directfb.h>

#include <debug.h>

#define DEBUG

#define ICONS_H 40
#define ICON1_W 60
#define ICON2_W 40
#define ICON3_W 40

struct statusbar_instance;

struct statusbar_instance* statusbar_instance_alloc();
int  statusbar_instance_ref(struct statusbar_instance *sbi);
int  statusbar_instance_deref(struct statusbar_instance *sbi);

DFBResult statusbar_instance_set_icon(struct statusbar_instance *sbi, char *filename, int id);
IDirectFBSurface* statusbar_instance_get_icon(struct statusbar_instance *sbi, int id);

#endif
