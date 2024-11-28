//******************************************************************************************/

	// 百度地图API功能
	let map = new BMap.Map("allmap");    // 创建Map实例
	let point = new BMap.Point(114.404252,30.52761);
	map.centerAndZoom(point, 17);  // 初始化地图,设置中心点坐标和地图级别
	//let marker = new BMap.Marker(point);  // 创建标注
	let opts = {
	width : 100,     // 信息窗口宽度
	height: 300,     // 信息窗口高度
	title : ">>>节点信息如下:" , // 信息窗口标题
	enableMessage:true//设置允许信息窗发送短息
	};
	//map.addOverlay(marker);               // 将标注添加到地图中
	map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
	//marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
	//添加地图类型控件
	map.addControl(new BMap.MapTypeControl({
	mapTypes:[
		BMAP_NORMAL_MAP,
		BMAP_HYBRID_MAP
	]}));
	map.setCurrentCity("武汉");          // 设置地图显示的城市 此项是必须设置的S

    //全局变量
    let defaultnode = null;
    let sensors = ["temperature","humidity","heading_angle"];//传感器类型数组
	let rtcache = [];//节点实时定时器id缓存 
    let unit = {temperature:"℃",humidity:"%RH",heading_angle:"°"};

	//更新地图
	function upadateMap(){
    //删除覆盖物
    map.clearOverlays();
	$.ajax({
	    //请求方式  
		type:"GET",  
		//文件位置  
		url:"server_demo/mapmarker.php",
		//返回数据格式为json,也可以是其他格式如  
		dataType: "json",  
		//请求成功后要执行的函数
	        success:function(data){ 
				for(i in data){
                    if(data[i] != null){
                        point = new BMap.Point(data[i]["lng"],data[i]["lat"]);
                        let content = ""; 
                        for(j in data[i]){
                            content += "<li>" + j+"：" + data[i][j] + "</li>";
                        }
                        map.centerAndZoom(point, 18);    
                        let marker = new BMap.Marker(point);        // 创建标注    
                        map.addOverlay(marker);
                        let label = new BMap.Label("树莓派监测小车" + data[i].node_id,{offset:new BMap.Size(20,-10)});
                        marker.setLabel(label);
                        marker.enableDragging();   		//可拖拽
                        addClickHandler(content,marker);
                    }         
                }
	        }
	    });
	}
	    
	//点击将信息内容加入白标注中
	function addClickHandler(content,marker){
	    marker.addEventListener("click",function(e){
	        openInfo(content,e)
	    });
	}
	    
	function openInfo(content,e){
        let p = e.target;
            let point = new BMap.Point(p.getPosition().lng, p.getPosition().lat);
            let infoWindow = new BMap.InfoWindow(content,opts);  // 创建信息窗口对象 
            map.openInfoWindow(infoWindow,point); //开启信息窗口
	}

	$(function(){
        $.post('server_demo/allrefresh.php');
        $("#nav").slideUp();
		//定时15秒更新地图刷新
		setInterval("upadateMap()", 15000);
		$(".raspberrypi-control-center").click(initraspiControl);
		$(".pi-dashboard").click(pidashboard);
        defaultNowChartView();
	});


    //*******************************************************************************************/
    function defaultNowChartView(){
        rtchartDiv();
        for (let i = 0; i < sensors.length; i++){
            let ntype = sensors[i];
            defaultnode = "1";
            rtChart(defaultnode, ntype);
        }
    }
	//添加实时传感器节点图表容器div
	function rtchartDiv(){
        let nowcharthtml = "";
        for (let i = 0; i < sensors.length; i++){
            let value = sensors[i];
                nowcharthtml += '<div id="nowchart'+ value +'"' + 'class="col-6 chart"></div>';
        }
        $("#nowchart").html(nowcharthtml);
	}


	//实时图表初始化
	function rtChart(nodeid, ntype){
        let myChart = echarts.init(document.getElementById("nowchart" + ntype));
        let xdata = ["", "", "", "", "", "", "", "", "", "","",""];
        let ydata = ["0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0"];
        // 显示标题，图例和空的坐标轴
        myChart.setOption({
            title: {text:""},
            tooltip: { },
            legend: {data:[ntype]},
            xAxis: {data: xdata,
                        axisLabel:{show:true, interval: 0, color:'red',rotate:45,textStyle:{
                            color:"red", //刻度颜色
                            fontSize:12  //刻度大小
                       }}},
            yAxis: { name:'单位:' + unit[ntype]},
            series: [{
                name: ntype,
                type: 'line',
                smooth: true,
                showSymbol: true,
                itemStyle: {
                        normal: {
                        symbol: 'circle', //折点设定为实心点
                        symbolSize: 6,   //设定实心点的大小
                        color: "#00BFFF",//折线点的颜色
                        lineStyle: {color: "#00BFFF"}}},
                markPoint: {  
                        //显示一定区域内的最大值和最小值
                    data: [{ type: 'max', name: '最大值' }, { type: 'min', name: '最小值' }]},   
                data: ydata
            }]
        });
	    let clear = setInterval(function(){
        $.ajax({
            //请求方式  
            type:"GET",  
            //文件位置  
            url:"server_demo/rtchart.php?q=" + nodeid + "&v=" +ntype,
            //返回数据格式为json,也可以是其他格式如  
            dataType: "json",  
            //请求成功后要执行的函数
            success:function(result){
                if(result.length != 0){
                    $.each(result, function(i,item){
                    rt = item["time_node"].split(" ")[1];
                        if(rt != xdata[11]){
                            xdata.shift();
                            ydata.shift();
                            ydata.push(item[ntype]);
                            xdata.push(rt);
                        }
                    });
                }      
            }
        });
        myChart.setOption({
            xAxis: {data: xdata},
                series: [{data: ydata}]
        });	
        },500);
        rtcache.push(clear);
        console.log(rtcache);
	}

        

	//********************************************************************************************* */
	//树莓派控制中心
	function initraspiControl() {
        var cameracontrolhtml = "<div class=\"row\"><div class=\"col-6 \"><div class=\"btn-group\">" +
                                                                    "<button type=\"button\" class=\"btn btn-primary camera-trigger\"><i class=\"fa fa-power-off\" style=\"margin-right: 3px; display: inline-block;\"></i>实时监控</button>" +
                                                                    "<button type=\"button\" class=\"btn btn-success camera-trigger\"><i class=\"fa fa-camera\" style=\"margin-right: 3px; display: inline-block;\"></i>拍照</button>" +
                                                                    "<button type=\"button\" class=\"btn btn-dark camera-trigger\"><i class=\"fa fa-video-camera\" style=\"margin-right: 3px; display: inline-block;\"></i>录像</button>" +
                                                                    "<button type=\"button\" class=\"btn btn-danger camera-trigger\"><i class=\"fa fa-power-off\" style=\"margin-right: 3px; display: inline-block;\"></i>关闭监控</button></div></div></div>";
        $("#cameracontrol").html(cameracontrolhtml);
	    var directioncontrolhtml = "<div class=\"d-flex justify-content-center\">" +
                                    "<div><button id=\"up\" name=\"前进\" class=\"btn btn-link direction-trigger\"><i class=\"fa fa-arrow-circle-o-up fa-3x fa-fw\"></i>up</button></div>" +
                            "</div><br>" +
                            "<div class=\"d-flex justify-content-around\">" +
                                    "<button id=\"left\" name=\"向左\" class=\"btn btn-link direction-trigger\"><i class=\"fa fa-arrow-circle-o-left fa-3x fa-fw\"></i>left</button>" +
                                    "<button id=\"right\" name=\"向右\" class=\"btn btn-link direction-trigger\">right<i class=\"fa fa-arrow-circle-o-right fa-3x fa-fw\"></i></button>" +
                            "</div><br>" +
                            "<div class=\"d-flex justify-content-around\">" +
                                    "<div><button id=\"down\" name=\"后退\" class=\"btn btn-link direction-trigger\"><i class=\"fa fa-arrow-circle-o-down fa-3x fa-fw\"></i>down</button></div>" +
                            "</div>";
        $(".directionwindow").html(directioncontrolhtml); 
        var html = "<p>\"<i class=\"fa fa-arrow-circle-o-up fa-lg \"></i>\"," + "\"<i class=\"fa fa-arrow-circle-o-down fa-lg \"></i>\"," + "\"<i class=\"fa fa-arrow-circle-o-left fa-lg \"></i>\"," +
                                                    "\"<i class=\"fa fa-arrow-circle-o-right fa-lg \"></i>\":" + "按键功能分别控制载体向前,向后,向左,向右移动</p>";
        $("#directioncontrol").html(html);                               
        cameraControl();
        directionControl();
        $("#pidashboard").empty();
        // $("#map").slideUp(1000);
	}


	//控制树莓派摄像头
	function cameraControl(){
        let picturenum = 1;
        let videonum = 1;
        $(".camera-trigger").click(function (){
            let text = $(this).text().replace(/ /g, "").replace(/\n/g, "").replace(/\r/g, "").replace(/\t/g, "");
            let cmd = "";
	        console.log(text);
            switch (text) {
            //摄像头控制
            case "实时监控":
                cmd = "cd /home/levi/mjpg-streamer-master/mjpg-streamer-experimental && ./mjpg_streamer -i \"./input_raspicam.so\" -o \"./output_http.so -w ./www\"";
                break;
            case "拍照":
                cmd = "ps -ef | grep mjpg_streamer | grep -v grep | awk '{print $2}' | xargs kill -9 ; cd /home/levi/Desktop/img && raspistill -o test" + picturenum + ".jpg";
                picturenum++;
                //console.log(picturenum);
                break;
            case "录像":
                cmd = "ps -ef | grep mjpg_streamer | grep -v grep | awk '{print $2}' | xargs kill -9 ; cd /home/levi/Desktop/video && raspivid -o test" + videonum +".h264 -t 15000";
                videonum++;
                break;
            case "关闭监控":
                cmd = "ps -ef | grep mjpg_streamer | grep -v grep | awk '{print $2}' | xargs kill -9";
                break;
            }
            let camerawindowhtml = "<img class=\"rounded\" alt=\"Camera\" width=100%  src=\"http://192.168.1.107:8080/?action=stream\" />"
            
            if (confirm("确定要执行该命令吗？")) {
                $.ajax({
                        type: "POST",
                        url: "server_demo/picmd.php",
                        data: {
                            action: "set-linux-cmd",
                            cmd: cmd
                        },
                        success: function (result) {
                            if(cmd == "cd /home/levi/mjpg-streamer-master/mjpg-streamer-experimental && ./mjpg_streamer -i \"./input_raspicam.so\" -o \"./output_http.so -w ./www\""){
                                    $(".camerawindow").html(camerawindowhtml);
                            }
                        }
                });
            }
        });
	}

//控制树莓派载体运动方向
function directionControl(){
    var directionInterval; // 定义一个变量来存储定时器

    $(".direction-trigger").mousedown(function(){
        let text = $(this).attr("name");
        let cmd = "";
        switch (text) {
        //方向
        case "前进":
            cmd = "cd /home/levi/pi_code && python3 motor.py 1";
            break;
        case "向左":
            cmd = "cd /home/levi/pi_code && python3 motor.py 4";
            break;
        case "向右":
            cmd = "cd /home/levi/pi_code && python3 motor.py 3";
            break;
        case "后退":
            cmd = "cd /home/levi/pi_code && python3 motor.py 2";
            break;
        }
        console.log("鼠标按下");
        // 发送命令
        $.ajax({
            type: "POST",
            url: "server_demo/picmd.php",
            data: {
                action: "set-linux-cmd",
                cmd: cmd
            },
            success: function (result) {
                console.log(result)
            }
        });
        // 设置定时器，以固定间隔发送命令
        directionInterval = setInterval(function(){
            $.ajax({
                type: "POST",
                url: "server_demo/picmd.php",
                data: {
                    action: "set-linux-cmd",
                    cmd: cmd
                },
                success: function (result) {
                    console.log(result)
                }
            });
        }, 500); // 每隔1000毫秒（1秒）发送一次命令
    });

    $(".direction-trigger").mouseup(function(){
        console.log("鼠标松开");
        // 清除定时器，停止发送命令
        clearInterval(directionInterval);
        // 发送停止命令
        $.ajax({
            type: "POST",
            url: "server_demo/picmd.php",
            data: {
                action: "set-linux-cmd",
                cmd: "cd /home/levi/pi_code && python3 motor.py 5"
            },
            success: function (result) {
                console.log(result)
            }
        });
    });
}

	//******************************************************************************************** */
	//树莓派仪表盘
	function pidashboard(){
        let pidashboardhtml = "<br><iframe  src=\"http://192.168.1.107/pi-dashboard/\" width=\"100%\" height=\"1000px\"></iframe>";
        $("#pidashboard").html(pidashboardhtml);
    }
    
    //导航栏动画//
    $("#nav_title").click(function(){
        $("#nav").slideToggle(500);
        setTimeout(() => {
            $("#nav").slideUp(1000); 
        }, 20000);
    });
