<?php

include('lib/common.php');

    if (!isset($_SESSION['Email'])) {
        header('Location: login.php');
        exit();
    }
    
    $Owner= $_SESSION['Email'];
    $DateUpdated=date('Y-m-d H:i:s');
    $Category=$_POST['category'];
    $Title=$_POST['Title'];
    $Password=$_POST['Password'];
    $Visibility=$_REQUEST['Private'];
    
    $query = "INSERT INTO corkboard (owner, date_updated, title, category_name) VALUES ('$Owner','$DateUpdated','$Title', '$Category');";
    
    mysqli_query($db, $query);
    $last_id = mysqli_insert_id($db);
    
 
    if (!$last_id) {
        echo "Error: The tuple already exists in the database!";
    } else {
        if ($Password){
            $query = "INSERT INTO privatecorkboard (corkBoardID, password) VALUES ('$last_id','$Password');";
            mysqli_query($db, $query);
        }
    }
 
    header("refresh:0.3; url=CorkBoard_Home.php");
?>
