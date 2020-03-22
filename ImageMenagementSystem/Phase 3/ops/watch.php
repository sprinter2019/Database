<?php 
    if ($_POST && isset($_POST['corkboard_id'])) {
        if ($_POST['watch_op']) {
            $query = "INSERT INTO Watch (email, cork_board_id) VALUES ('{$_SESSION['Email']}', '{$_POST['corkboard_id']}')";
        } else if ($_POST['unwatch_op']) {
            $query = "DELETE FROM Watch WHERE email='{$_SESSION['Email']}' AND cork_board_id='{$_POST['corkboard_id']}'";
        }
        mysqli_query($db, $query);

        header("Location: view_corkboard.php?corkboard_id={$_POST['corkboard_id']}");
    }
?>