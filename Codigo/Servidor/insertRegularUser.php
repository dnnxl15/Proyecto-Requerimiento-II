<?php
	
	// Connect to the database
	$con = mysqli_connect("localhost:3306","root","","cinetec");
    if (mysqli_connect_errno())
    {
       echo "Failed to connect to MySQL: " . mysqli_connect_error();
    }

    // Parameters
    $username = $_GET["nickname"];
    $password = $_GET["password"];
    $mail = $_GET["mail"];
    $nameUser = $_GET["name"];



	// Call the store procedure
	$sql= "CALL insertUser($username , $password,  $mail , $nameUser)";

	$call = mysqli_prepare($con ,'CALL insertAdministrator(?,?,?,?)');
	mysqli_stmt_bind_param($call, 'ssss',$username, $password, $mail, $nameUser);
	mysqli_stmt_execute($call);
	//$result = mysqli_query($con ,$sql);
	
	
	header('Content-Type:Application/json');
    mysqli_close($con); // Close connection
 ?>