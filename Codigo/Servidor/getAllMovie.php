<?php
	
	// Connect to the database
	$con = mysqli_connect("localhost:3306","root","","cinetec");
    if (mysqli_connect_errno())
    {
       echo "Failed to connect to MySQL: " . mysqli_connect_error();
    }

	// Call the store procedure
	$sql= "CALL getAllMovie" ;
	$result = mysqli_query($con ,$sql);
	$array = array();  
	while ( $row = mysqli_fetch_assoc($result)) 
	{
		$array[] = array_map('utf8_encode', $row);
	}
	
	header('Content-Type:Application/json');
	echo json_encode($array) ;
    mysqli_free_result($result);
    mysqli_close($con); // Close connection
 ?>