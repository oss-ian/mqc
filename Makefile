default:
	gcc *.c -lmosquitto -s -ffunction-sections -fdata-sections -Wl,--gc-sections -fno-unwind-tables -fno-asynchronous-unwind-tables -fno-math-errno -fmerge-all-constants -fno-ident -Wl,--build-id=none -Os -ffast-math -fshort-enums -fsingle-precision-constant -Wl,--hash-style=gnu -Wl,--build-id=none -fno-unroll-loops -o bin
	
crypt:
	tar --exclude='bin' --exclude='Makefile' --exclude='README.md' --exclude='.git' -cf - . | xz | aespipe > mqc.tar.xz.aes; find . ! -name 'Makefile' ! -name 'README.md' ! -name '.git' ! -name 'mqc.tar.xz.aes' -type f -exec rm -f {} +

decrypt:
	cat mqc.tar.xz.aes | aespipe -d | xz -d | tar xf -; rm mqc.tar.xz.aes

push:
	git add mqc.tar.xz.aes; git commit -m `sha256sum mqc.tar.xz.aes`; git push -u origin master

update:
	find . ! -name 'Makefile' ! -name 'README.md' ! -name 'mqc.tar.xz.aes' ! -name '.git' -type f -exec rm -f {} +; git reset --hard; git pull
