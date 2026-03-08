srpm:
	dnf install -y fedpkg rpm-build sed
	git clone --depth 1 -b rawhide https://src.fedoraproject.org/rpms/kernel.git /tmp/kernel
	cp $(PWD)/Ro-Kernel-S.config /tmp/kernel/kernel-local
	# Set custom build id for Ro-Kernel-S
	sed -i 's/^# define buildid .local/%define buildid .Ro_Kernel_S/' /tmp/kernel/kernel.spec
	cd /tmp/kernel && fedpkg sources
	cd /tmp/kernel && rpmbuild -bs --define "_sourcedir ." --define "_srcrpmdir ." --define "_without_configchecks 1" kernel.spec
	cp /tmp/kernel/*.src.rpm $(outdir)/
