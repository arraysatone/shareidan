<?php

    $servername = "107.180.27.180";
    $username = "MapleLeafAdmin";
    $password = "ClVq0Qzt21jz";
    $dbname = "Mapleleaf_Capstone";

    $con = new mysqli($servername, $username, $password, $dbname);
     
    if(mysqli_connect_errno())
    {
      echo "Failed to connect to MySQL: ".mysqli_connect_error();
    }

    $consoleArray = array();
    $selectString = "SELECT * FROM BUILDING_LOCATIONS";

    if($result = mysqli_query($con, $selectString)){
    	while($row = $result->fetch_object()){
    		array_push($consoleArray, $row);
    	}

    	echo json_encode($consoleArray);
    }

    mysqli_close($con);

?>