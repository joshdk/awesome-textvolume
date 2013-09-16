SOURCE=./src/textvolume
TARGET=$(HOME)/.config/awesome/textvolume


all: install

install:
	mkdir -p $(TARGET)
	cp -r $(SOURCE)/init.lua $(TARGET)/init.lua

uninstall:
	rm -rf $(TARGET)
