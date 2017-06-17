crypt:
	tar cpvJF kek.tar.xz . ; cat kek.tar.xz | aespipe > kek.tar.xz.aes ; rm -rf kek.tar; rm ALL THE FILES IN PROJECT


decrypt:
	cat kek.tar.xz.aes | aespipe > kek.tar.xz ; tar xfpv kek.tar.xz
