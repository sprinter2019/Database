<?php
	if ($_POST && isset($_POST['followee_email'])) {
        if ($_POST['follow_op']) {
            $query = "INSERT INTO Follow (follower_email, followee_email) VALUES ('{$_SESSION['Email']}', '{$_POST['followee_email']}')";
        } else if ($_POST['unfollow_op']) {
            $query = "DELETE FROM Follow WHERE follower_email='{$_SESSION['Email']}' AND followee_email='{$_POST['followee_email']}'";
        }
        mysqli_query($db, $query);

        if ($_POST['source'] == 'view_pushpin') {
            header("Location: view_pushpin.php?pushpin_id={$_POST['pushpin_id']}");
        } else if ($_POST['source'] == 'view_corkboard') {
            header("Location: view_corkboard.php?corkboard_id={$_POST['corkboard_id']}");
        }
    }
?>