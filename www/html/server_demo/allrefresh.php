<?php
//连接数据库
require ('connect.php');
//查询数据库
mysqli_select_db( $conn, 'demo' );
mysqli_query($conn,'truncate table map');
mysqli_query($conn,'truncate table rt_node');
// 关闭连接
mysqli_close($conn);
?>