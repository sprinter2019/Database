<?php
	include('../lib/common.php');

	if (!isset($_SESSION['Email'])) {
        header('Location: ../login.php');
        exit();
    }

	if (isset($_POST['pushpin_id'])) {

        $query = "DELETE FROM `Like` WHERE email='{$_SESSION['Email']}' AND pushpin_id={$_POST['pushpin_id']}";
        mysqli_query($db, $query);
    }

    header("Location: ../view_pushpin.php?pushpin_id={$_POST['pushpin_id']}");
?>
?>