 <?php
header("content-type:application/json");
//连接数据库
require ('connect.php');
//查询数据库
mysqli_select_db( $conn, 'demo' );

//当数据库数据超过一定值清空
$rowsnum=mysqli_fetch_assoc(mysqli_query($conn,"select count(*) as num from rt_node"));
if($rowsnum['num']>=5000){
    mysqli_query($conn,'truncate table rt_node');
}

//获取节点数据
$sql = 'SELECT node_id,lng,lat,temperature,humidity,co2,tvoc,ch2o,pm25,pm10,heading_angle FROM rt_node where node_id=1 ORDER BY id DESC LIMIT 0,1';
$result = mysqli_query($conn,$sql);
$results = array();
$row = mysqli_fetch_assoc($result);
$results[0] = $row; 
// 将数组转成json格式
$json=json_encode($results);
// 关闭连接
mysqli_close($conn);
echo $json;
?>
