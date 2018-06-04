<?php 
	//Creating a connection
	$con = mysqli_connect("localhost:3306","root","","cinetec");
    if (mysqli_connect_errno())
    {
       echo "Failed to connect to MySQL: " . mysqli_connect_error();
    }
	/*Get the id of the last visible item in the RecyclerView from the request and store it in a variable. For            the first request id will be zero.*/	
	$name = $_GET["name"];
	
	$sql= "CALL getMovieByGender('$name')";
	
	$result = mysqli_query($con ,$sql);
	$array = array();  

	while ($row = mysqli_fetch_assoc($result)) {
		
		$array[] = array_map('utf8_encode', $row);
	}
	header('Content-Type:Application/json');
	echo json_encode($array);
    mysqli_free_result($result);
    mysqli_close($con);
 ?>