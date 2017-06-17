repo=$(shell basename $$(pwd))

default:
	@echo 	"secure git:\n" \
		"	build 	: compile\n" \
		"	crypt 	: tarball and encrypt\n" \
		"	decrypt	: decrypt and untar\n" \
		"	push 	: push the latest tarball to the repo\n" \
		"	pull 	: reset the local repo and pull the latest tarball"

build:
	gcc *.c -lmosquitto -s -ffunction-sections -fdata-sections -Wl,--gc-sections -fno-unwind-tables -fno-asynchronous-unwind-tables -fno-math-errno -fmerge-all-constants -fno-ident -Wl,--build-id=none -Os -ffast-math -fshort-enums -fsingle-precision-constant -Wl,--hash-style=gnu -Wl,--build-id=none -fno-unroll-loops -o $(repo).$(shell uname -m)
	
crypt:
	@echo "Encrypting tarball..."
	@tar --exclude='Makefile' --exclude='README.md' --exclude='.git' --exclude=$(repo).tar.xz.aes -cf - . | xz | aespipe > $(repo).tar.xz.aes

decrypt:
	@echo "Decrypting tarball..."
	@cat $(repo).tar.xz.aes | aespipe -d | xz -d | tar xf -; $(if (( $1 )), then-part[shell rm $$(repo).tar.xz.aes])

push:
	@echo "Pushing tarball to git..."
	@git add $(repo).tar.xz.aes; git commit -m `sha256sum $(repo).tar.xz.aes`; git push -u origin master

pull:
	@echo "Resetting the local directory..."
	@rm -rf $(shell ls | grep -v -e .git -e Makefile -e README.md); git reset --hard; git pull
