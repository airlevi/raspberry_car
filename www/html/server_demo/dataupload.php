<?php
//连接数据库
require ('connect.php');
$post_array=file_get_contents("php://input");

//查询数据库
mysqli_select_db( $conn, 'demo' );
//--解析Json，获取对应的变量值
$obj=json_decode($post_array,TRUE);
//测试 $obj=array("node_id"=>"1","lng"=>"114.40436", "lat"=>"30.529205", "ph"=>"7.45","conductivity"=>"2.15","temperature"=>"10.5", );

//--得到Json_list数组长度
$num=count($obj);

$k=nKey();
//echo $k;
$v=nValue();
//echo $v;
mysqli_query($conn,'INSERT INTO rt_node ('.$k.') VALUES ('.$v.')');
//将上传json数据的键进行拼接
function nKey(){
    global $obj,$num;
    $k='';
    for($i=0;$i<$num;$i++){
        if($i==$num-1){
            $k=$k.key($obj);
            next($obj); 
        }elseif($i<$num-1){
            $k=$k.key($obj);
            $k=$k.',';
            next($obj);
        }
    }
    return $k;
}
//将上传json数据的值进行拼接
function nValue(){
    global $obj,$num;
    $v='';
    reset($obj);
    for($i=0;$i<$num;$i++){
        if($i==$num-1){
            $v=$v.'"';
            $v=$v.current($obj);
            $v=$v.'"';
            next($obj); 
        }elseif($i<$num-1){
            $v=$v.'"';
            $v=$v.current($obj);
            $v=$v.'",';
            next($obj);
        }
    }
    return $v;
}


		
// 关闭连接
mysqli_close($conn);
?>
