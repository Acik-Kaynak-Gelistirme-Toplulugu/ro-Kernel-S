#!/bin/bash
# S-Kernel Hazırlık Scripti v1.0
# "Bismillah" diyerek başlayalım.

echo ">>> Şefim, gerekli paketleri yüklüyorum (sudo şifresi isteyebilir)..."
sudo dnf install -y fedpkg fedora-packager rpmdevtools ncurses-devel pesign

echo ">>> RPM geliştirme ağacını kuruyorum..."
rpmdev-setuptree

echo ">>> Fedora'nın orijinal kernel kaynak kodunu indiriyorum (Biraz sürebilir, çay koy)..."
# Bu komut o anki fedora sürümünün kaynak kodunu (src.rpm) indirir
dnf download --source kernel

echo ">>> Kaynak kod açılıyor..."
# İndirilen .src.rpm dosyasını kurarak ~/rpmbuild klasörüne açar
rpm -Uvh kernel-*.src.rpm

echo ">>> Operasyon tamam! ~/rpmbuild klasörün hazır şefim."