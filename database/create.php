<?php
header("Access-Control-Allow-Origin: *");
$conn = mysqli_connect("localhost","root","","buku tamu");
$nama_pengguna = $_POST['nama_pengguna'];
$isi_komentar = $_POST['isi_komentar'];
$data = mysqli_query($conn, "insert into komentar set nama_pengguna= '$nama_pengguna', tanggal = NOW(), isi_komentar = '$isi_komentar'");
if ($data){
echo json_encode([
'pesan'=>'Sukses'
]);
}else {
echo json_encode([
'pesan'=>'Sukses'
]);
}
?>