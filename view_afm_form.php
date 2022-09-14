
<html lang="en" dir="ltr">
    <head>
        <meta charset="utf-8">
        <title> Εμφάνιση Πελατών ανά ΑΦΜ & Μηναίου Κόστους</title>
        <link rel="stylesheet" href="style.css">
        <meta charset="UTF-8">
    </head>
    <body>
        <header>
            <img src="images/logo.png" width="580" height="49.5"alt="">
        </header>

        <!-- Βήμα 11: Form όπου ο χρήστης εισάγει ΑΦΜ και μια ημερομηνία μορφής "2020-09-09"
        και επιστρέφεται το πλήθος συμφβολαίων και το μηνιαίο ποσό πληρωμής.
        Μόλις γίνει submit το αποτέλεσμα θα φανεί στην view_afm.php.                    -->
        <div class="center">
            <h1>Επιλογή Προϊόντος</h1>
            <form action="view_afm.php" method ="post">
                <label for="AFM">ΑΦΜ:</label>
                <input type="text" id="AFM" name="AFM">
                <label for="DATE">Ημερομηνία:</label>
                <input type="text" id="DATE" name="DATE">
                <input type="submit" value="Submit">
            </form>

        </div>

        <div class="footer">
            <form name="goBack" method="post" action="index.html">
        	<p><input type="submit" name="submit" value="Return to menu"></p>
        </div>

    </body>
</html>
