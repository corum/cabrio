CC=gcc
BIN_DIR=/usr/bin
DATA_DIR=/usr/share/cabrio
CFLAGS=-g -Wall -DDATA_DIR=\"$(DATA_DIR)\"
LDFLAGS=-lGL -lSDL -lSDL_image -lSDL_gfx -lSDL_ttf -lSDL_mixer -lGLU -lxml2 \
	-lavutil -lavformat -lavcodec -lswscale
INCLUDES=-I./include -I/usr/include/libxml2

INSTALL=/usr/bin/install -c

cabrio: main.o ogl.o sdl_wrapper.o config.o bg.o menu.o game_sel.o \
	game.o font.o hint.o platform.o submenu.o \
	sound.o event.o key.o control.o setup.o sdl_ogl.o video.o packet.o frame.o \
	category.o focus.o emulator.o snap.o media.o location.o lookup.o
	$(CC) -o $@ $^ $(LDFLAGS)

.c.o: %.c
	$(CC) $(CFLAGS) $(INCLUDES) -o $@ -c $<

install: cabrio
	$(INSTALL) -m 755 -d $(DATA_DIR)/fonts $(DATA_DIR)/pixmaps $(DATA_DIR)/sounds
	$(INSTALL) -m 644 -t $(DATA_DIR)/fonts data/fonts/*
	$(INSTALL) -m 644 -t $(DATA_DIR)/pixmaps data/pixmaps/*
	$(INSTALL) -m 644 -t $(DATA_DIR)/sounds data/sounds/*	
	$(INSTALL) -m 755 -d $(DATA_DIR)/themes
	$(INSTALL) -m 755 -d $(DATA_DIR)/themes/carousel
	$(INSTALL) -m 644 -t $(DATA_DIR)/themes/carousel data/themes/carousel/*
	$(INSTALL) -m 755 -d $(DATA_DIR)/themes/ice
	$(INSTALL) -m 644 -t $(DATA_DIR)/themes/ice data/themes/ice/*
	$(INSTALL) -m 755 -d $(DATA_DIR)/themes/industrial
	$(INSTALL) -m 644 -t $(DATA_DIR)/themes/industrial data/themes/industrial/*
	$(INSTALL) -m 755 -d $(DATA_DIR)/themes/wood
	$(INSTALL) -m 644 -t $(DATA_DIR)/themes/wood data/themes/wood/*
	$(INSTALL) -m 755 -d $(BIN_DIR)
	$(INSTALL) -m 755 -t $(BIN_DIR) cabrio

deb:
	debuild -i -us -uc -b

debclean:
	debuild clean

clean:
	rm -f cabrio *.o core core.*

