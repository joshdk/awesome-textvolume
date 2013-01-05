SOURCE="./src/textvolume.lua"
TARGET="/usr/share/awesome/lib/awful/widget/textvolume.lua"


all: install

install:
	install -m 644 $(SOURCE) $(TARGET)

uninstall:
	rm $(TARGET)
