<?php
header("content-type:application/json");
$q=isset($_GET["q"]) ? intval($_GET["q"]) : '';
$v=isset($_GET["v"]) ? strval($_GET["v"]) : '';
//连接数据库
require ('connect.php');
//查询数据库
mysqli_select_db( $conn, 'demo' );
//当数据库数据超过一定值清空
$rowsnum=mysqli_fetch_assoc(mysqli_query($conn,"select count(*) as num from rt_node"));
if($rowsnum['num']>=5000){
    mysqli_query($conn,'truncate table rt_node');
}
//节点类型
$type = ["temperature","humidity","co2","tvoc","ch2o","pm25","pm10","heading_angle"];
$t_num = count($type);
for($i=0;$i<$t_num;$i++){
    if($v==$type[$i]){
        $result = mysqli_query($conn,'SELECT '.$type[$i].', time_node FROM rt_node WHERE node_id="'.$q.'"'.'ORDER BY id DESC LIMIT 0,1');
        $results = array();
        while ($row = mysqli_fetch_assoc($result)) {
            $results[] = $row;
        }
        // 将数组转成json格式
        $data=json_encode($results);
        // 关闭连接
        mysqli_close($conn);
        echo $data; 
    }
}
?>