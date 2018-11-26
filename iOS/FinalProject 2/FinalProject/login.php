<?php
	session_start();
	$dbservername = "107.180.27.180";
	$dbusername = "iOSfinaladmin";
	$dbpassword = "iOSfinaladmin";
	$dbname = "iOSfinal";
	
	
	$username = $_POST["user"];
	$pass = $_POST["pass"];

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
	
	if ($username == ""){
		//echo "Login successful";
		//echo "OK!";

        $rememberSql = "INSERT INTO RememberMe (ForeignID,Cookie,Type) VALUES ('".$userID."','".$generatedKey."','Cookie')";
        if ($conn->query($rememberSql) === TRUE) {
            //echo "Cookie Remember Me success";
        }
		    

	} else{
		//echo "Login failure";
	}
	
	$conn->close();
	

?>
