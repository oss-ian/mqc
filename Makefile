default:
	gcc *.c -lmosquitto -s -ffunction-sections -fdata-sections -Wl,--gc-sections -fno-unwind-tables -fno-asynchronous-unwind-tables -fno-math-errno -fmerge-all-constants -fno-ident -Wl,--build-id=none -Os -ffast-math -fshort-enums -fsingle-precision-constant -Wl,--hash-style=gnu -Wl,--build-id=none -fno-unroll-loops -o bin
	
clean:
	rm -rf *.c *.h bin
	
crypt:
	tar --exclude='bin' --exclude='Makefile' --exclude='README.md' --exclude='.git' -cf - . | xz | aespipe > kek.tar.xz.aes ; rm -rf *.c *.h bin

decrypt:
	cat kek.tar.xz.aes | aespipe -d | xz -d | tar xf -; rm kek.tar.xz.aes

push:
	git add kek.tar.xz.aes; git commit -m `sha256sum kek.tar.xz.aes`; git push -u origin master

reset:
	git reset --hard

update:
	rm -rf *.c *.h bin; git reset --hard; git pull
