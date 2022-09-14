<?php
//Σύνδεση στη βάση
global $mysqli;
$mysqli = mysqli_connect("localhost","root","","insurancecovers");

if (mysqli_connect_errno()) {
	printf("Connect failed: %s\n", mysqli_connect_error());
	exit();
}

?>
