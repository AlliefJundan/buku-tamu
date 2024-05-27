<?php

$koneksi = mysqli_connect('localhost', 'root', '', 'buku tamu');

if (!$koneksi) {
    die("Connection failed: ". mysqli_connect_error());
}

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['submit'])) {
    $nama = strip_tags(trim($_POST['nama']));
    $isi_komentar = strip_tags(trim($_POST['komentar']));

    $sql = "INSERT INTO komentar (nama_pengguna, tanggal, isi_komentar) VALUES ('$nama', NOW(), '$isi_komentar')";
    if (mysqli_query($koneksi, $sql)) {
       header ("location:tabel.php");
    } else {
        echo "Kesalahan: ". mysqli_error($koneksi);
    }
}

$query = "SELECT * FROM komentar ORDER BY tanggal DESC";
$hasil = mysqli_query($koneksi, $query);

?>