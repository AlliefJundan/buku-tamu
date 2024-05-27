<?php
header("Access-Control-Allow-Origin: *");
$conn = mysqli_connect("localhost","root","","buku tamu");
$query = mysqli_query($conn,"SELECT * FROM komentar");
$data = mysqli_fetch_all($query,MYSQLI_ASSOC);
echo json_encode($data);
?>