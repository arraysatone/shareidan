<?php
	session_start();
	$dbservername = "107.180.27.180";
	$dbusername = "iOSfinaladmin";
	$dbpassword = "iOSfinaladmin";
	$dbname = "iOSfinal";
	
	
	$username = $_GET["user"];
	$pass = $_GET["pass"];

	// Create connection
	$conn = new mysqli($dbservername, $dbusername, $dbpassword, $dbname);
	// Check connection
	if ($conn->connect_error) {
	    die("Connection failed: " . $conn->connect_error);
	} 

	$sql = "SELECT user,pass FROM users WHERE user='".$username."'";
	$result = $conn->query($sql);

	if ($result->num_rows > 0) {
		// output data of each row
		while($row = $result->fetch_assoc()) {
			$checkPass = $row["pass"];
		}
	} else {
		//echo "0 results";
	}
	
	if ($checkPass == $pass){
		//login success
        echo 'Hi';
	} else{
		//echo "Login failure";
	}
	
	$conn->close();
	

?>
