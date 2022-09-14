<?php
    include_once "db_connect.php";
 ?>
<html lang="en" dir="ltr">
    <head>
        <meta charset="utf-8">
        <title> Ασφαλιστικά Προϊόντα</title>
        <link rel="stylesheet" href="style.css">
        <meta charset="UTF-8">
    </head>
    <body>
        <header>
            <img src="images/logo.png" width="580" height="49.5"alt="">
        </header>
        <div class="center">
            <h1>Ασφαλιστικά Προϊόντα</h1>
        <?php
        // Βήμα 9: Εμφάνιση Ασφαλιστικών Προϊόντων
            $sql = "SELECT * FROM Covers";
            $res = mysqli_query($mysqli,$sql);
                if ($res == TRUE) {
                    echo "<table>";
                    echo"<tr>".
                        "<th>CoverID</th>".
                        "<th>CoverName</th>".
                        "<th>CostPerYear</th>".
                        "<th>MinDuration</th>".
                    "</tr>";
                    while ($newArray = mysqli_fetch_array($res,MYSQLI_BOTH)) {
                        $cover_id = $newArray['CoverID'];
                        $cover_name = $newArray['CoverName'];
                        $cost_peryear = $newArray['CostPerYear'];
                        $min_duration = $newArray['MinDuration'];
                        echo "<tr><td>".$cover_id."</td><td>".$cover_name.
                             "</td><td>".$cost_peryear."</td><td>".$min_duration.
                             "</td></tr>";
                    }
                    echo "</table>";
                }else {
                    echo "Error cannot retrive customer data";
                }
                mysqli_free_result($res);
                mysqli_close($mysqli);

         ?>

        </div>
        <div class="footer">
            <form name="goBack" method="post" action="index.html">
        	<p><input type="submit" name="submit" value="Return to menu"></p>
        </div>

    </body>
</html>
