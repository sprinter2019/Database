<?php
	include('../lib/common.php');

	if (!isset($_SESSION['Email'])) {
        header('Location: ../login.php');
        exit();
    }

	if (isset($_POST['comment']) && isset($_POST['pushpin_id'])) {

        $query = "INSERT INTO Comment (email, pushpin_id, date_time, `text`) VALUES ('{$_SESSION['Email']}', {$_POST['pushpin_id']}, CURRENT_TIMESTAMP, '{$_POST['comment']}')";

        mysqli_query($db, $query);
    }
    
    header("Location: ../view_pushpin.php?pushpin_id={$_POST['pushpin_id']}");
?>