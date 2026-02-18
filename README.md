# ro-Kernel-S

**High-Performance, Modern, and Gaming-Focused Linux Kernel**

This project is a customized Linux kernel developed for Fedora-based systems, incorporating the latest hardware and software technologies. It is specifically optimized for gamers and users working under heavy workloads.

## 🚀 Key Features

### 🔥 Performance and Gaming
*   **Aggressive Compilation:** Utilizes the full power of modern processors (Haswell and later) with `-O3` optimization level and `-march=x86-64-v3` architecture support.
*   **Low Latency:** Instant system responsiveness with `1000Hz` timer frequency and `Full Preemption`.
*   **BORE Scheduler:** Burst-Oriented Response Enhancer scheduler that increases desktop and gaming responsiveness.
*   **Fsync/Futex2:** Native `futex_waitv` support preventing stutters in Wine/Proton games.

### 🌐 Network and System
*   **BBRv3:** The latest TCP congestion control algorithm developed by Google is enabled by default.
*   **CachyOS Optimizations:** Clear Linux and Intel-based performance patches are integrated.
*   **Clean and Lightweight:** Processor load is reduced by disabling unnecessary debug codes and lock tracking.

## 📦 Installation and Building

This repo contains `.spec` files and patches for Fedora and RHEL-based distributions. The build process can be done with standard RPM tools.

---
*Developer: Open Source Development Community*

---

# ro-Kernel-S

**Yüksek Performanslı, Modern ve Oyun Odaklı Linux Çekirdeği**

Bu proje, Fedora tabanlı sistemler için geliştirilmiş, en yeni donanım ve yazılım teknolojilerini barındıran özelleştirilmiş bir Linux çekirdeğidir. Özellikle oyuncular ve ağır iş yükü altında çalışan kullanıcılar için optimize edilmiştir.

## 🚀 Öne Çıkan Özellikler

### 🔥 Performans ve Oyun
*   **Agresif Derleme:** `-O3` optimizasyon seviyesi ve `-march=x86-64-v3` mimari desteği ile modern işlemcilerin (Haswell ve sonrası) tüm gücünü kullanır.
*   **Düşük Gecikme:** `1000Hz` zamanlayıcı frekansı ve `Full Preemption` ile sistem tepkileri anlıktır.
*   **BORE Scheduler:** Masaüstü ve oyun tepkiselliğini artıran Burst-Oriented Response Enhancer zamanlayıcısı.
*   **Fsync/Futex2:** Wine/Proton oyunlarında takılmaları önleyen yerel `futex_waitv` desteği.

### 🌐 Ağ ve Sistem
*   **BBRv3:** Google tarafından geliştirilen en yeni TCP tıkanıklık kontrol algoritması varsayılan olarak etkindir.
*   **CachyOS Optimizasyonları:** Clear Linux ve Intel tabanlı performans yamaları entegre edilmiştir.
*   **Temiz ve Hafif:** Gereksiz hata ayıklama (debug) kodları ve kilit (lock) takibi kapatılarak işlemci yükü azaltılmıştır.

## 📦 Kurulum ve Derleme

Bu repo, Fedora ve RHEL tabanlı dağıtımlar için `.spec` dosyası ve yamaları içerir. Derleme işlemi standart RPM araçlarıyla yapılabilir.

---
*Geliştirici: Açık Kaynak Geliştirme Topluluğu*
