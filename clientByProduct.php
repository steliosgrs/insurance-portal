<?php
    include_once "db_connect.php";
 ?>
<!DOCTYPE html>
<html>
	<head>
		<style>h1 {text-align: center;} .center { margin: 0; position: absolute; top: 50%; left: 50%; -ms-transform: translate(-50%, -50%); transform: translate(-50%, -50%); }</style>
		<title>Εμφάνιση Πελατών ανά Προϊόν</title>
		<link rel="stylesheet" href="style.css">
		<meta charset="UTF-8">
			<meta name="viewport" content="width=device-width, initial-scale=1.0"</head>
		<body>
            <header>
                <img src="images/logo.png" width="580" height="49.5"alt="">
            </header>
			<div class="center">
				<h1>Επιλογή Προϊόντος</h1>

					<?php

							if(isset($_POST['products'])) {
							$choice = $_POST['products'];
						}


						$sql="SELECT Customers.CustomerName, Customers.Address, Customers.PhoneNumber,
								Customers.CustomerID, Customers.AFM, Customers.DOY  FROM Contracts
								JOIN Customers ON Customers.CustomerID = Contracts.CustomerID
								JOIN Covers ON Covers.CoverID = Contracts.CoverID
								WHERE Covers.CoverName = '$choice'";

						$result=mysqli_query($mysqli,$sql);

						if(mysqli_num_rows($result)>0) {
							echo "<table style='border:1px solid black'>";
							echo"<tr>".
								"<th>CustomerName</th>".
								"<th>Address</th>".
								"<th>PhoneNumber</th>".
								"<th>CustomerID</th>".
								"<th>AFM</th>".
								"<th>DOY</th>".
							"</tr>";

							while($row=mysqli_fetch_assoc($result))	{
								echo "<tr>".
									"<td>".$row['CustomerName']."</td>".
									"<td>".$row['Address']."</td>".
									"<td>".$row['PhoneNumber']."</td>".
									"<td>".$row['CustomerID']."</td>".
									"<td>".$row['AFM']."</td>".
									"<td>".$row['DOY']."</td>".
								"</tr>";
							}
							echo"</table>";
							} else {
							echo "No entries"; }

						mysqli_close($mysqli);
					?>
			</div>
			<div class="footer">
	            <form name="goBack" method="post" action="index.html">
	        	<p><input type="submit" name="submit" value="Return to menu"></p>
	        </div>
		</body>
	</html>
