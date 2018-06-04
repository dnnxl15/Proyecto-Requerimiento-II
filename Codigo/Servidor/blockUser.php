<?php
	
	// Connect to the database
	$con = mysqli_connect("localhost:3306","root","","cinetec");
    if (mysqli_connect_errno())
    {
       echo "Failed to connect to MySQL: " . mysqli_connect_error();
    }

    // Parameters
    $username = $_GET["username"];


	// Call the store procedure
	$sql= "CALL blockUser($username)";

	$call = mysqli_prepare($con ,'CALL blockUser(?)');
	mysqli_stmt_bind_param($call, 's', $username);
	mysqli_stmt_execute($call);
	//$result = mysqli_query($con ,$sql);
	
	
	header('Content-Type:Application/json');
    mysqli_close($con); // Close connection
 ?>