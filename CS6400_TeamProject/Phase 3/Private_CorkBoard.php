<?php

    include('lib/common.php');

    if($showQueries) {
        array_push($query_msg, "showQueries currently turned ON, to disable change to 'false' in lib/common.php");
    }

    if(isset($_GET['corkboard_id'])){
        $var = $_GET['corkboard_id'];
    } else {
        header("Location: CorkBoard_Home.php");
    }

    if($_SERVER['REQUEST_METHOD'] == 'POST') {
       
        $enteredPassword = mysqli_real_escape_string($db, $_POST['password']);

        if (empty($enteredPassword)){
            array_push($error_msg, "Please enter a password.");
        }

        elseif( !empty($enteredPassword)) {
            $query = "SELECT `password` FROM privateCorkboard WHERE corkBoardID = $var";

            $result = mysqli_query($db, $query);
            include('lib/show_queries.php');
            $count = mysqli_num_rows($result);

            if (!empty($result) && ($count > 0)) {
                $row = mysqli_fetch_array($result, MYSQLI_ASSOC);
                $storedPassword = $row['password'];

                $options = [
                    'cost' => 8,
                ];

                $storedHash = password_hash($storedPassword, PASSWORD_DEFAULT, $options);
                $enteredHash = password_hash($enteredPassword, PASSWORD_DEFAULT, $options);

                if($showQueries){
                    array_push($query_msg, "Plaintext entered PIN: ". $enteredPassword);
                    array_push($query_msg, "Entered Hash:". $enteredHash);
                    array_push($query_msg, "Stored Hash: ". $storedHash . NEWLINE);
                }

                if (password_verify($enteredPassword, $storedHash)) {
                    array_push($query_msg, "Password is Valid!");
                    $_SESSION["corkboard_id={$var}"] = true;
                    array_push($query_msg, "logging in...");
                    header(REFRESH_TIME . "url=view_corkBoard.php?corkboard_id=$var");
                } else {
                    array_push($error_msg, "Login failed: ");
                }
            } 
        }
    }
?>


<?php
    include('lib/header.php');
?>

<title>CorkBoardIt Login</title>
</head>

<body>
<div class="container">

<?php 
    include('lib/menu.php');
?>

<div class="row justify-content-center">
<div class="col-4 p-4 bg-light">
    <font color="red">
        <?php 
            $query = "SELECT title FROM CorkBoard WHERE corkBoardID=$var";
            $result = mysqli_query($db, $query);
            $row = mysqli_fetch_array($result, MYSQLI_ASSOC);
            print "The CorkBoard you are trying to view is private. Please enter the password for <b>{$row['title']}</b> to continue.";
        ?>
    </font>
</div>
</div>

<br>

<div class="row justify-content-center">
<?php
    print "<form action=\"Private_CorkBoard.php?corkboard_id=$var\" method='post' enctype='multipart/form-data'>";
?>

<div class="form-group">
    <label for="password">Password:</label>
    <input type="password" name="password" required />
</div>

<div class="form-group">
    <button type="submit" class="btn btn-primary btn-block">OK</button>
    <?php 
        print "<input type='button' class='btn btn-danger btn-block' onClick=\"window.location='CorkBoard_Home.php';\" value='Cancel'/>";
    ?>
</div>
</form>
</div>

<?php include("lib/error.php"); ?>

</div>
</body>
</html>
