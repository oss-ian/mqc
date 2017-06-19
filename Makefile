repo=$(shell basename $$(pwd))

default:
	@echo 	"secure git:\n" \
		"	crypt 	: tarball and encrypt\n" \
		"	decrypt	: decrypt and untar\n" \
		"	push 	: push the latest tarball to the repo\n" \
		"	pull 	: reset the local repo and pull the latest tarball"
		
crypt:
	@echo "Encrypting tarball..."
	@tar --exclude='README.md' --exclude='.git' --exclude=$(repo).tar.xz.aes -cf - . | xz | aespipe > $(repo).tar.xz.aes

decrypt:
	@echo "Decrypting tarball..."
	@cat $(repo).tar.xz.aes | aespipe -d | xz -d | tar xf -; if [ $$? -eq 0 ] ; then rm $(repo).tar.xz.aes; fi

push:
	@echo "Pushing tarball to git..."
	@git add $(repo).tar.xz.aes; git commit -m `sha256sum $(repo).tar.xz.aes`; git push -u origin master

pull:
	@echo "Resetting the local directory..."
	@rm -rf $(shell ls | grep -v -e .git -e Makefile -e README.md); git reset --hard; git pull
