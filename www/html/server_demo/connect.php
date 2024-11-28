<?php
$servername = 'localhost:3306';
$username = 'root';
$password = '231198520';
// 创建连接
$conn = mysqli_connect($servername, $username, $password);
// 检测连接
if (!$conn) {
    die("连接失败: " . mysqli_connect_error());
}
// 设置编码，防止中文乱码
mysqli_query($conn , "set names utf8");

?>
