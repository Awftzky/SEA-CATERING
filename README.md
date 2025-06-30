#  SEA Catering App - Aplikasi Pemesanan Katering Sehat , By Aufa Azzaky

Aplikasi iOS ini dibuat menggunakan SwiftUI dan dirancang untuk layanan pemesanan katering makanan sehat

# Fitur
-   **Autentikasi Pengguna**: Halaman Login dan Registrasi untuk pengguna baru.
-   **Tampilan Beranda**: Halaman selamat datang yang menampilkan informasi utama tentang layanan.
-   **Katalog Menu**: Pengguna dapat melihat daftar paket makanan yang tersedia.
-   **Menu subscription** : Pengguna dapat memesan katering 
-   **Dashboard Pengguna & Admin**:
    -   **User Dashboard**: Mengelola langganan yang aktif, termasuk menjeda, membatalkan, atau mengaktifkan kembali layanan.
    -   **Admin Dashboard**: Tampilan khusus untuk administrator (saat ini masih berupa placeholder).
-   **Halaman Informasi **: Menampilkan informasi kontak dan tautan interaktif (telepon & WhatsApp).

---

## Teknologi yang Digunakan

-   **Framework**: SwiftUI
-   **Bahasa**: Swift
-   **Pola Desain**: MVVM (Model-View-ViewModel) - meskipun dalam proyek ini disederhanakan dengan View dan State Management bawaan SwiftUI.
-   **Minimum Target**: iOS 15.0+


##  Persyaratan

Sebelum memulai, pastikan Anda memiliki perangkat dan perangkat lunak berikut:

1.  **Mac** dengan macOS versi terbaru.
2.  **Xcode** versi 14 atau yang lebih baru.

##  Cara Menjalankan Proyek

Untuk menjalankan proyek ini di Xcode, ikuti langkah-langkah berikut:

1.  **Clone Repositori**
    Buka Terminal dan jalankan perintah berikut untuk mengunduh proyek ke komputer Anda:
    ```bash
    git clone [URL_REPOSITORI_ANDA_DI_SINI]
    ```
    Atau, unduh file ZIP proyek dan ekstrak di lokasi yang Anda inginkan.

2.  **Buka Proyek di Xcode**
    -   Buka folder proyek yang telah Anda unduh.
    -   Cari dan klik dua kali pada file dengan ekstensi `.xcodeproj` (misalnya, `SeaCatering.xcodeproj`). Ini akan membuka proyek di Xcode.

3.  **Pastikan Aset Gambar Tersedia**
    -   Di dalam Xcode, buka `Assets.xcassets`.
    -   Pastikan gambar `SEACatering` dan `Google` sudah ada di sana. Jika belum, seret dan lepas file gambar tersebut ke dalam daftar aset.

4.  **Pilih Target Simulator atau Perangkat**
    -   Di bagian atas jendela Xcode, pilih simulator yang ingin Anda gunakan (misalnya, "iPhone 14 Pro").
    -   Atau, jika Anda menghubungkan iPhone fisik, Anda bisa memilihnya sebagai target.

5.  **Jalankan Aplikasi**
    -   Tekan tombol **Run** (ikon ►) di pojok kiri atas jendela Xcode.
    -   Atau, gunakan pintasan keyboard **`Cmd + R`**.

Xcode akan membangun (build) aplikasi dan meluncurkannya di simulator atau perangkat yang Anda pilih.

Terima kasih telah meninjau proyek ini!
