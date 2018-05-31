<?php
	
	// Connect to the database
	$con = mysqli_connect("localhost:3306","root","","cinetec");
    if (mysqli_connect_errno())
    {
       echo "Failed to connect to MySQL: " . mysqli_connect_error();
    }

    // Parameters
    $gender = $_GET["gender"];
    $director = $_GET["director"];
    $name = $_GET["name"];
    $release = (int) $_GET["release"];
    $admin = $_GET["admin"];




	// Call the store procedure
	$sql= "CALL insertMovie($gender , $director,  $name , $release, $admin)";

	$call = mysqli_prepare($con ,'CALL insertMovie(?,?,?,?,?)');
	mysqli_stmt_bind_param($call, 'sssis',$gender , $director,  $name , $release, $admin);
	mysqli_stmt_execute($call);
	//$result = mysqli_query($con ,$sql);
	
	
	header('Content-Type:Application/json');
    mysqli_close($con); // Close connection
 ?>