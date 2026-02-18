srpm:
	dnf install -y rpmdevtools wget
	# 1. Specs klasorune gir
	# 2. Kernel.org'dan 6.18.9 tarball dosyasini ZORLA indir
	cd specs && wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.19.tar.xz
	# 3. Derlemeyi baslat
	rpmbuild -bs --define "_sourcedir $(PWD)/specs" --define "_srcrpmdir $(outdir)" specs/kernel.spec
