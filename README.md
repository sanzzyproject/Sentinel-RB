<div align="center">
  <h1>🛡️ Sentinel-RB</h1>
  <h3>Lightweight Server Monitoring & Alerting Tool</h3>
  <p>Automation script berbasis Ruby + Shell untuk memantau kesehatan server secara real-time.</p>

  <a href="https://github.com/sanzzyproject/Sentinel-RB">
    <img src="https://img.shields.io/github/repo-size/sanzzyproject/Sentinel-RB?style=for-the-badge&color=orange&logo=github" alt="Repo Size">
  </a>
  <a href="https://www.ruby-lang.org/en/">
    <img src="https://img.shields.io/badge/Ruby-3.0%2B-red?style=for-the-badge&logo=ruby" alt="Ruby Version">
  </a>
  <a href="https://github.com/sanzzyproject/Sentinel-RB/blob/main/LICENSE">
    <img src="https://img.shields.io/github/license/sanzzyproject/Sentinel-RB?style=for-the-badge&color=blue" alt="License">
  </a>
  <a href="https://github.com/sanzzyproject/Sentinel-RB/issues">
    <img src="https://img.shields.io/github/issues/sanzzyproject/Sentinel-RB?style=for-the-badge&color=red" alt="Issues">
  </a>
</div>

<br />

<details>
  <summary>📚 <strong>Daftar Isi (Table of Contents)</strong></summary>
  <br />
  <ol>
    <li><a href="#-tentang-project">Tentang Project</a></li>
    <li><a href="#-fitur-unggulan">Fitur Unggulan</a></li>
    <li><a href="#-prasyarat">Prasyarat</a></li>
    <li><a href="#-instalasi">Instalasi</a></li>
    <li><a href="#-konfigurasi">Konfigurasi</a></li>
    <li><a href="#-cara-penggunaan">Cara Penggunaan</a></li>
    <li><a href="#-automasi-cron-job">Automasi (Cron Job)</a></li>
    <li><a href="#-kontribusi">Kontribusi</a></li>
    <li><a href="#-lisensi">Lisensi</a></li>
  </ol>
</details>

---

## 📖 Tentang Project

**Sentinel-RB** adalah alat pemantauan server minimalis yang dirancang untuk SysAdmin dan DevOps yang menginginkan solusi monitoring tanpa beban (bloatware). 

Project ini menggabungkan keanggunan sintaks **Ruby** dengan kecepatan perintah native **Shell** (`df`, `free`, `uptime`) untuk memantau resource vital server. Jika ambang batas (threshold) terlampaui, Sentinel-RB akan segera mengirimkan notifikasi darurat.

> *"Sederhana, Cepat, dan Dapat Diandalkan. Tanpa database, tanpa agent berat, hanya Ruby."*

## 🚀 Fitur Unggulan

| Fitur | Deskripsi |
| :--- | :--- |
| 💾 **Disk Monitor** | Memantau penggunaan storage partisi root `/` secara real-time. |
| 🧠 **RAM Monitor** | Menghitung persentase penggunaan memori menggunakan `free`. |
| ⚙️ **CPU Load** | Melacak *Load Average* sistem untuk mendeteksi overload. |
| 📧 **Email Alert** | Notifikasi via SMTP (Gmail, Zoho, SendGrid, dll). |
| ✈️ **Telegram Alert** | Integrasi langsung ke Telegram Bot API untuk notifikasi instan. |
| 📦 **Zero Dependency** | Hanya menggunakan Ruby Standard Library (tidak perlu `bundle install` berat). |

## 🛠 Prasyarat

Sebelum menjalankan Sentinel-RB, pastikan server Anda memenuhi syarat berikut:

* **OS**: Linux / Unix (Ubuntu, CentOS, Debian, macOS).
* **Language**: Ruby versi 2.7 atau lebih baru.
    ```bash
    ruby -v
    ```
* **Akses**: Izin eksekusi script dan akses internet (untuk kirim notifikasi).

## 📥 Instalasi

1.  **Clone Repository**
    ```bash
    git clone [https://github.com/sanzzyproject/Sentinel-RB.git](https://github.com/sanzzyproject/Sentinel-RB.git)
    cd Sentinel-RB
    ```

2.  **Siapkan Konfigurasi**
    Salin file contoh konfigurasi menjadi file konfigurasi utama:
    ```bash
    cp config/config.example.yml config/config.yml
    ```

3.  **Berikan Izin Eksekusi**
    Pastikan file binary dapat dijalankan:
    ```bash
    chmod +x bin/monitor
    ```

## ⚙️ Konfigurasi

Edit file `config/config.yml` menggunakan text editor favorit Anda (nano/vim). Sesuaikan nilai di bawah ini dengan kebutuhan server Anda.

```yaml
# Batas ambang peringatan (Thresholds)
thresholds:
  disk_usage: 90      # Alert jika disk penuh > 90%
  memory_usage: 85    # Alert jika RAM terpakai > 85%
  cpu_load: 2.0       # Alert jika Load Average > 2.0

# Pengaturan Notifikasi
notifications:
  enable_email: true
  enable_telegram: true

# Konfigurasi SMTP (Contoh menggunakan Gmail)
email:
  server: "smtp.gmail.com"
  port: 587
  user_name: "email_kamu@gmail.com"
  password: "app_password_kamu" # Gunakan App Password, bukan password login biasa
  from: "server-bot@domain.com"
  to: "admin@domain.com"

# Konfigurasi Telegram Bot
telegram:
  bot_token: "123456789:ABCdefGHIjklMNOpqrsTUVwxyz"
  chat_id: "987654321"
