<?php
	session_start();
	$dbservername = "142.55.32.48";
	$dbusername = "irelaale_admin";
	$dbpassword = "L}zOAdgkc[Wr";
	$dbname = "irelaale_iOSFinal";
	
	
	$username = $_POST["user"];
	$unhashed_pass = $_POST["pass"];
    $cookie = $_POST["cookie"]
    
	$split_user = str_split($username);
	$size_of_array = count($split_user);
	$unhashed_pass = $unhashed_pass.$split_user[0].$split_user[$size_of_array-1]; //Applying the first and last digits of user

	// Create connection
	$conn = new mysqli($dbservername, $dbusername, $dbpassword, $dbname);
	// Check connection
	if ($conn->connect_error) {
	    die("Connection failed: " . $conn->connect_error);
	} 

	$sql = "SELECT ID,Password FROM UserTable WHERE Username='".$username."'";
	$result = $conn->query($sql);

	if ($result->num_rows > 0) {
		// output data of each row
		while($row = $result->fetch_assoc()) {
			$userID = $row["ID"];
			$assessment_hash = $row["Password"];
		}
	} else {
		//echo "0 results";
	}
	
	if (password_verify($unhashed_pass,$assessment_hash)){
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
