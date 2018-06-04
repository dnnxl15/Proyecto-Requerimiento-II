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
    $release = (int) $_GET["release"];
    $newName = $_GET["newName"];
    $oldName = $_GET["oldName"];




	// Call the store procedure
	$sql= "CALL updateMovie($gender , $director , $release, $newName, $oldName)";

	$call = mysqli_prepare($con ,'CALL updateMovie(?,?,?,?,?)');
	mysqli_stmt_bind_param($call, 'ssiss',$gender , $director , $release, $newName, $oldName);
	mysqli_stmt_execute($call);
	//$result = mysqli_query($con ,$sql);
	
	
	header('Content-Type:Application/json');
    mysqli_close($con); // Close connection
 ?>