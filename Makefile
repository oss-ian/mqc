build:
	gcc *.c -lmosquitto -s -ffunction-sections -fdata-sections -Wl,--gc-sections -fno-unwind-tables -fno-asynchronous-unwind-tables -fno-math-errno -fmerge-all-constants -fno-ident -Wl,--build-id=none -Os -ffast-math -fshort-enums -fsingle-precision-constant -Wl,--hash-style=gnu -Wl,--build-id=none -fno-unroll-loops

crypt:
	tar cpvJF kek.tar.xz *.{c,h}; cat kek.tar.xz | aespipe > kek.tar.xz.aes ; rm -rf kek.tar.xz *.c *.h bin

decrypt:
	cat kek.tar.xz.aes | aespipe > kek.tar.xz ; tar xfpv kek.tar.xz
