<?php
	
	// Connect to the database
	$con = mysqli_connect("localhost:3306","root","","cinetec");
    if (mysqli_connect_errno())
    {
       echo "Failed to connect to MySQL: " . mysqli_connect_error();
    }

    // Parameters
    $username = $_GET["username"];
    $movie = $_GET["movie"];
    $favorite = $_GET["favorite"];

	// Call the store procedure
	$call = mysqli_prepare($con ,'CALL insertFavoriteMovie(?,?,?)');
	mysqli_stmt_bind_param($call, 'ssi', $username, $movie, $favorite);
	mysqli_stmt_execute($call);
	//$result = mysqli_query($con ,$sql);
	
	
	header('Content-Type:Application/json');
    mysqli_close($con); // Close connection
 ?>