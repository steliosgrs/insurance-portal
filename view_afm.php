<?php
    include_once "db_connect.php";
 ?>
<html lang="en" dir="ltr">
    <head>
        <meta charset="utf-8">
        <title>Εμφάνιση Πελατών ανά ΑΦΜ & Μηναίου Κόστους</title>
        <link rel="stylesheet" href="style.css">
        <meta charset="UTF-8">
    </head>
    <body>
        <header>
            <img src="images/logo.png" width="580" height="49.5"alt="">
        </header>

        
        <div class="center">
            <h1>Επιλογή Προϊόντος</h1>

        <?php

        $afm=$_POST["AFM"];
        $date=$_POST["DATE"];

        $sql="SELECT COUNT(Contracts.ContractID), SUM(Contracts.Cost)/12
                    FROM Contracts
                    JOIN Customers ON Customers.CustomerID = Contracts.CustomerID
                    WHERE Contracts.CustomerID = (
                        SELECT CustomerID FROM Customers WHERE Customers.afm = '$afm'
                    )
                    AND ('$date' BETWEEN Contracts.StartDate AND Contracts.EndDate)";

        $res=mysqli_query($mysqli,$sql);

        if(mysqli_num_rows($res)>0) {
            echo "<table>";
            echo"<tr>"."<th>Πλήθος Συμβολαίων  </th>".
                        "<th>Ποσό πληρωμής</th>".
                        "</tr>";
            while($row=mysqli_fetch_assoc($res))    {
                echo "<tr>".
                    "<td>".$row['COUNT(Contracts.ContractID)']."</td>".
                    "<td>".$row['SUM(Contracts.Cost)/12']."</td>".
                    "</tr>";
            }
            echo"</table>";
        }


            //print_r($res);
            mysqli_close($mysqli);
         ?>
     </div>

         <div class="footer">
             <form name="goBack" method="post" action="index.html">
         	<p><input type="submit" name="submit" value="Return to menu"></p>
         </div>
    </body>
</html>
