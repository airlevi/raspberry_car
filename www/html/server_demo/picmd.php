<?php
$action = isset($_POST["action"]) ? $_POST["action"] : null;
$cmd = isset($_POST["cmd"]) ? $_POST["cmd"] : null;

if ($action === "set-linux-cmd" && !empty($cmd)) {
    $filePath = "/home/levi/Pi_Controlcmd/picmd.txt";
    
    $myfile = fopen($filePath, "a");
    if ($myfile) {
        fwrite($myfile, $cmd);
        fclose($myfile);
        
        $str = file_get_contents($filePath);
        echo $str;
    } else {
        echo "Unable to open file!";
    }
} else {
    echo "Invalid request!";
}
?>
