<?php
    include_once "db_connect.php";
 ?>
<html lang="en" dir="ltr">
    <head>
        <meta charset="utf-8">
        <title> Εμφάνιση Πελατών ανά Προϊόν</title>
        <link rel="stylesheet" href="style.css">
        <meta charset="UTF-8">
    </head>
    <body>
        <header>
            <img src="images/logo.png" width="580" height="49.5"alt="">
        </header>
        <div class="center">
            <!-- Βήμα 10: Form της drop down list για επιλογή ασφαλιστικού προϊόντος
            Μόλις γίνει submit το αποτέλεσμα θα φανεί στην clientByProduct.php   -->
            <h1>Επιλογή Προϊόντος</h1>
            <form action="clientByProduct.php" method="POST">
                <select name="products" id="products">
                    <option selected="selected">Select...</option>
                    <option value="Ασφάλεια Υγείας">Ασφάλεια Υγείας</option>
                    <option value="Σοβαρής Ασθένειας">Σοβαρής Ασθένειας</option>
                    <option value="Ασφάλεια Σπιτιού">Ασφάλεια Σπιτιού</option>
                    <option value="Ασφάλεια Αυτοκινήτου">Ασφάλεια Αυτοκινήτου</option>
                </select>
                <br><br>
                <input type="submit" value="Submit">
            </form>


        </div>
        <div class="footer">
            <form name="goBack" method="post" action="index.html">
            <p><input type="submit" name="submit" value="Return to menu"></p>
        </div>
</body>
</html>
