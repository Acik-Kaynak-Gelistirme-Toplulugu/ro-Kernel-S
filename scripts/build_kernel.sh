#!/bin/bash

# --- S-KERNEL DERLEME SCRIPTI v1.0 ---
# Bu script, repodaki dosyaları alır, RPM ortamına taşır ve derlemeyi başlatır.

# Hata olursa dur (Safety First)
set -e

# Renkli çıktılar için (Öğrencilerin hoşuna gider)
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}>>> S-KERNEL İNŞA SÜRECİ BAŞLIYOR...${NC}"

# 1. Neredeyiz? (Proje kök dizinini bulalım)
# Scriptin olduğu yerin bir üstü proje ana dizinidir.
PROJE_DIZINI=$(dirname "$0")/..
cd "$PROJE_DIZINI"
echo "Çalışma Dizini: $(pwd)"

# 2. RPM Geliştirme Ortamını Hazırla
echo -e "${GREEN}>>> RPM ağacı temizleniyor ve yeniden kuruluyor...${NC}"
rpmdev-setuptree
# Normalde ~/rpmbuild dizinidir.

# 3. Dosyaları Yerlerine Taşı
echo -e "${GREEN}>>> Bizim dosyalar 'Fırına' (rpmbuild) taşınıyor...${NC}"

# Config dosyasını SOURCES içine atıyoruz (Adını kernel config standardına çevirerek)
cp configs/kernel-x86_64.config ~/rpmbuild/SOURCES/kernel-x86_64.config
echo "- Config kopyalandı."

# Spec dosyasını SPECS içine atıyoruz
cp specs/kernel.spec ~/rpmbuild/SPECS/kernel.spec
echo "- Spec dosyası kopyalandı."

# (Eğer Patch klasöründe dosya varsa onları da kopyala kodu buraya gelecek ileride)

# 4. Kaynak Kodları İndir (Eğer yoksa)
echo -e "${GREEN}>>> Kaynak kodlar kontrol ediliyor...${NC}"
# Bu kısım biraz uzun sürer ama spectro-download ile kaynakları çeker
cd ~/rpmbuild/SPECS
spectool -g -R kernel.spec

# 5. VE ATEŞLE!
echo -e "${BLUE}>>> DERLEME BAŞLIYOR (Çay molası verin, uzun sürer)...${NC}"
# -bb: Sadece binary (kurulabilir) paket üret. Kaynak paketle uğraşma.
rpmbuild -bb kernel.spec

echo -e "${GREEN}>>> İŞLEM TAMAM KAPTAN! Paketler ~/rpmbuild/RPMS/ altında.${NC}"
