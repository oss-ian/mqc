repo=$(shell basename $$(pwd))
default:
	gcc *.c -lmosquitto -s -ffunction-sections -fdata-sections -Wl,--gc-sections -fno-unwind-tables -fno-asynchronous-unwind-tables -fno-math-errno -fmerge-all-constants -fno-ident -Wl,--build-id=none -Os -ffast-math -fshort-enums -fsingle-precision-constant -Wl,--hash-style=gnu -Wl,--build-id=none -fno-unroll-loops -o bin
	
crypt:
	tar --exclude='bin' --exclude='Makefile' --exclude='README.md' --exclude='.git' --exclude=$(repo).tar.xz.aes -cf - . | xz | aespipe > $(repo).tar.xz.aes

decrypt:
	cat $(repo).tar.xz.aes | aespipe -d | xz -d | tar xf -; rm $(repo).tar.xz.aes

push:
	git add $(repo).tar.xz.aes; git commit -m `sha256sum $(repo).tar.xz.aes`; git push -u origin master

pull:
	rm -rf *.c *.h bin; git reset --hard; git pull

usage:
	@echo "make -\n" \
		"	default - compile\n" \
		"	crypt - tarball and encrypt\n" \
		"	decrypt - decrypt and untar\n" \
		"	push - push the latest tarball to the repo\n" \
		"	pull - reset the local repo and pull the latest tarball\n"
