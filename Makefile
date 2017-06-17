crypt:
	tar cpvJF kek.tar.xz $( find -name "*.c" -or -name "*.h" ); cat kek.tar.xz | aespipe > kek.tar.xz.aes ; rm -rf kek.tar.xz


decrypt:
	cat kek.tar.xz.aes | aespipe > kek.tar.xz ; tar xfpv kek.tar.xz
