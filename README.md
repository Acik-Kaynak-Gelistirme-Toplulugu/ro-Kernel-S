# ro-Kernel-Desktop (Experimental)

**🇹🇷 Türkçe:**
Bu depo, Linux 7.0 çekirdeğini (kernel) alıp sadece son kullanıcı masaüstü cihazları için en verimli hale getirmeyi amaçlayan bir optimizasyon projesidir. Fedora 43 alt yapısı (Kernel 7.0) üzerinde kurulu bu yapılandırmada; modern ve "legacy" masaüstü bilgisayarlara yönelik destekler korunmuşken, gereksiz görülen eski donanım ve protokoller tamamen kaldırılmıştır.

**Ana Hedefler:**
*   Sadece Masaüstü: Sunucu bileşenlerinden ziyade hızlı masaüstü deneyimi.
*   Gereksiz Yüklerden Kurtulma: 1999 ve öncesinde kalan çok eski ekran kartları, amatör bant telsiz sürücüleri, kullanılmayan eski ağ cihazları ve iletişim protokolleri modüllerden çıkartılmıştır.
*   Legacy Sistemlere Destek: Çekirdek olabildiğince hafifletilmiş olsa da, eski BIOS'a (Legacy Boot) sahip bilgisayarlarda da masaüstünün sorunsuz açılması için gereken temel IDE/SATA ve USB denetleyici desteklerini korur.
*   Yerel ve COPR Derlemesi: Çekirdek yerel (local) ortamda test edildikten sonra Fedora'nın COPR platformu için de otomatik olarak derlenebilir bir paket şablonu (RPM) şeklinde planlanmıştır.

---

**🇬🇧 English:**
This repository is an experimental optimization project aimed at taking the Linux 7.0 kernel and streamlining it strictly for end-user desktop machines. Based on the Fedora 43 (Kernel 7.0) infrastructure, this configuration maintains support for both modern and "legacy" desktop scenarios, while entirely removing obsolete hardware and network protocols.

**Core Objectives:**
*   Desktop-Only Focus: A snappy desktop experience, discarding unnecessary server features.
*   Bloat Removal: Extremely old graphics cards from 1999 and earlier, amateur radio drivers, obsolete network devices, and outdated protocols have been removed from the modules.
*   Legacy System Support: Despite being slimmed down, the kernel retains the foundational IDE/SATA and USB controller support required to boot successfully on older PCs utilizing Legacy BIOS setups.
*   Local and COPR Build Pipeline: The configuration is designed to be built initially as a local RPM package for hardware testing, and subsequently deployed via Fedora's COPR build system.

---

## 🛠️ Build & Installation / Derleme & Kurulum

### 🇹🇷 Yerel Kurulum (Local Installation)
Eğer RPM dosyalarını (örn. `kernel-*.rpm`, `kernel-headers-*.rpm`, `kernel-devel-*.rpm`) derlediyseniz veya indirdiyseniz, Fedora üzerinde şu komutla kurabilirsiniz:
```bash
sudo dnf install ./*.rpm
```
Kurulum sonrası bilgisayarınızı yeniden başlattığınızda GRUB menüsünde **-Ro-Kernel-S** kernelini görebilirsiniz.

### 🇹🇷 COPR İçin Derleme Hazırlığı (COPR Build Preparation)
Bu repodaki `Ro-Kernel-S.config` dosyasını Fedora Kernel `.spec` dosyasıyla birleştirerek kendi COPR deponuza gönderebilirsiniz:
1. Fedora'nın SRPM kernel paketini indirin.
2. İçerisindeki standart `.config` dosyasını bu repodaki `Ro-Kernel-S.config` ile değiştirin.
3. COPR platformunda "Custom Build" veya "SCM" (GitHub) webhook ile bağlayarak otomatik derlenmesini sağlayın.

---

### 🇬🇧 Local Installation
If you have built or downloaded the RPM files (e.g., `kernel-*.rpm`, `kernel-headers-*.rpm`, `kernel-devel-*.rpm`), you can install them on Fedora using:
```bash
sudo dnf install ./*.rpm
```
Upon reboot, you should see the **-Ro-Kernel-S** kernel in your GRUB menu.

### 🇬🇧 COPR Build Preparation
You can use the `Ro-Kernel-S.config` file from this repository to build your custom kernel on Fedora COPR:
1. Download a Fedora Kernel SRPM.
2. Replace the standard `.config` with `Ro-Kernel-S.config` provided here.
3. Push everything to your COPR repo or link this GitHub repository as an SCM source for automated builds.
