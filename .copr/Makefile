srpm:
	dnf install -y rpmdevtools
	# 1. Once specs klasorunun icine gir
	# 2. Orada kernel.spec dosyasini oku ve kaynaklari oraya indir
	cd specs && spectool -g kernel.spec
	# 3. Sonra ana dizine geri donup (make otomatik doner) insaati baslat
	rpmbuild -bs --define "_sourcedir $(PWD)/specs" --define "_srcrpmdir $(outdir)" specs/kernel.spec
