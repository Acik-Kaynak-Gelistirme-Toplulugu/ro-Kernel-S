#!/bin/bash
# ro-Kernel-Desktop (Experimental) Config Optimizer Script

KERNEL_DIR="/home/smurat/Masaüstü/ro-Kernel-Experimental/linux-7.0-rc2"
REPO_DIR="/home/smurat/Masaüstü/ro-Kernel-Experimental/ro-Kernel-Experimental"
BASE_CONFIG="/boot/config-7.0.0-0.rc2.21.fc45.x86_64"

echo "Kernel dizinine geçiliyor: $KERNEL_DIR"
cd "$KERNEL_DIR" || exit 1

echo "Temel config alınıyor (Fedora 7.0 rc2): $BASE_CONFIG"
cp "$BASE_CONFIG" .config

echo "Local version ayarlaniyor..."
./scripts/config --set-str LOCALVERSION "-Ro-Kernel-S"

echo "Gereksiz eski protokoller kapatılıyor..."
./scripts/config --disable CONFIG_HAMRADIO
./scripts/config --disable CONFIG_APPLETALK
./scripts/config --disable CONFIG_IPX
./scripts/config --disable CONFIG_ATALK
./scripts/config --disable CONFIG_X25
./scripts/config --disable CONFIG_DECNET

echo "Eski (199X/200X dönemi) ekran kartı sürücüleri kapatılıyor..."
./scripts/config --disable CONFIG_DRM_TDFX
./scripts/config --disable CONFIG_DRM_R128
./scripts/config --disable CONFIG_DRM_I810
./scripts/config --disable CONFIG_DRM_MGA
./scripts/config --disable CONFIG_DRM_SIS
./scripts/config --disable CONFIG_DRM_VIA
./scripts/config --disable CONFIG_DRM_SAVAGE
./scripts/config --disable CONFIG_FB_3DFX
./scripts/config --disable CONFIG_FB_SIS
./scripts/config --disable CONFIG_FB_RIVA
./scripts/config --disable CONFIG_FB_MATROX
./scripts/config --disable CONFIG_FB_ATI
./scripts/config --disable CONFIG_FB_SAVAGE
./scripts/config --disable CONFIG_FB_RADEON
./scripts/config --disable CONFIG_FB_NEOMAGIC

echo "Çok eski ağ kartları devreden çıkarılıyor..."
./scripts/config --disable CONFIG_NET_VENDOR_3COM
./scripts/config --disable CONFIG_NET_VENDOR_DEC
./scripts/config --disable CONFIG_NET_VENDOR_RACAL
./scripts/config --disable CONFIG_NET_VENDOR_SIS
./scripts/config --disable CONFIG_WLAN_VENDOR_CISCO
./scripts/config --disable CONFIG_WLAN_VENDOR_ATMEL
./scripts/config --disable CONFIG_WLAN_VENDOR_INTERSIL
./scripts/config --disable CONFIG_WLAN_VENDOR_ZYDAS

echo "ISDN, FDDI vb. eski ağ standartları kapatılıyor..."
./scripts/config --disable CONFIG_ISDN
./scripts/config --disable CONFIG_TR
./scripts/config --disable CONFIG_FDDI
./scripts/config --disable CONFIG_PCMCIA

echo "make olddefconfig çalıştırılarak bağımlılıklar kontrol ediliyor..."
make olddefconfig

echo "Hazırlanan config dosyası repoya kopyalanıyor..."
cp .config "$REPO_DIR/Ro-Kernel-S.config"

echo "İşlem tamam!"
