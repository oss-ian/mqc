default:
	gcc *.c -lmosquitto -s -ffunction-sections -fdata-sections -Wl,--gc-sections -fno-unwind-tables -fno-asynchronous-unwind-tables -fno-math-errno -fmerge-all-constants -fno-ident -Wl,--build-id=none -Os -ffast-math -fshort-enums -fsingle-precision-constant -Wl,--hash-style=gnu -Wl,--build-id=none -fno-unroll-loops -o bin
	
crypt:
	tar --exclude='bin' --exclude='Makefile' --exclude='README.md' --exclude='.git' -cf - . | xz | aespipe > kek.tar.xz.aes ; rm -rf *.c *.h bin

decrypt:
	cat kek.tar.xz.aes | aespipe > kek.tar.xz ; tar xfpv kek.tar.xz
