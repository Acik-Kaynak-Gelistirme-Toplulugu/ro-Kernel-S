srpm:
	dnf install -y rpmdevtools
	# Kaynaklari specs klasorunun ICINE (-C specs) indir:
	spectool -g -C specs -R specs/kernel.spec
	# Simdi derle:
	rpmbuild -bs --define "_sourcedir $(PWD)/specs" --define "_srcrpmdir $(outdir)" specs/kernel.spec
