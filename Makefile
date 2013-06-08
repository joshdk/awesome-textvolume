SOURCE="./src/textvolume"
TARGET="$(HOME)/.config/awesome/textvolume"


all: install

install:
	cp -r $(SOURCE) $(TARGET)

uninstall:
	rm -rf $(TARGET)
