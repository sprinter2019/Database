<?php

    include('lib/common.php');

    if (!isset($_SESSION['Email'])) {
        header('Location: login.php');
        exit();
    }

    //get the corkboard id from the url and store it in $var
    if(isset($_GET['corkboard_id'])){
        $var = $_GET['corkboard_id'];
    } else {
        header('Location: CorkBoard_Home.php');
    }

    $query = "SELECT corkBoardID FROM PrivateCorkBoard WHERE corkBoardID={$var}";
    $result = mysqli_query($db, $query);

    if (mysqli_num_rows($result) > 0 && !isset($_SESSION["corkboard_id={$var}"])) {
        header("Location: Private_CorkBoard.php?corkboard_id={$var}");
    }

?>

<?php
    include('lib/header.php');
    include('ops/follow.php');
    include('ops/watch.php');
?>

<title>View CorkBoard</title>
</head>

<body>

<div class="container">
    <?php 
    include('lib/menu.php');

    //query corkboard owner, category, title, last updated date
    $query = "SELECT `user`.`name`, `user`.`email`, `category_name`, `title`, `date_updated` FROM corkboard INNER JOIN `user` ON `corkboard`.`owner` = `user`.`email` WHERE corkBoardID = $var";

    $result = mysqli_query($db, $query);
    $row = mysqli_fetch_array($result, MYSQLI_ASSOC);
    ?>

    <div class="mt-auto bg-light">

    <div class='row'>
        <div class='col-md-3'>
            <h2><b><?php echo $row['name']; ?></b></h2>
        </div>

        <div class='col-md-5'>
        <?php
            // follow button
            $owner = $row['email'];
            $title = $row['title'];
            $category_name = $row['category_name'];
            $date_updated = $row['date_updated'];

            $query = "SELECT follower_email, followee_email " .
            "FROM Follow " .
            "WHERE follower_email='{$_SESSION['Email']}' AND followee_email='{$owner}'";

            $result = mysqli_query($db, $query);
            $row = mysqli_fetch_array($result, MYSQLI_ASSOC);

            if (mysqli_num_rows($result) > 0) {
                print "<form method='POST'>
                <input type='hidden' name='corkboard_id' value={$var}>
                <input type='hidden' name='followee_email' value='{$owner}'>
                <input type='hidden' name='unfollow_op' value=true>
                <input type='hidden' name='source' value='view_corkboard'>
                <button type='submit' class='btn btn-outline-primary'>
                Unfollow
                </button>
                </form>";
            } else if (strcmp($owner, $_SESSION['Email']) != 0) {
                print "<form method='POST'>
                <input type='hidden' name='corkboard_id' value={$var}>
                <input type='hidden' name='followee_email' value='{$owner}'>
                <input type='hidden' name='follow_op' value=true>
                <input type='hidden' name='source' value='view_corkboard'>
                <button type='submit' class='btn btn-outline-primary'>
                Follow
                </button>
                </form>";
            }
        ?>
        </div>

        <div class='col-md-3'>
            <span style="float:right;color:blue;"><b><?php echo $category_name; ?></b></span>
        </div>
        
    </div>

    <div class='row'>
        <div class='col-md-8'>
            <h4><?php echo $title; ?></h4>
        </div>
    </div>

    <div class='row'>
        <div class='col-md-10'>
            <h6>
            <?php 

            $query = "SELECT COUNT(pushPinID) as pushpin_count FROM PushPin WHERE cork_board_id={$var}";
            $result = mysqli_query($db, $query);
            $row = mysqli_fetch_array($result, MYSQLI_ASSOC);

            if ($row['pushpin_count'] > 0) {
                echo "Last Updated " . $date_updated; 
            } else {
                echo "Created at " . $date_updated; 
            }
            
            ?>
            </h6>
        </div>
        
        <div class='col-md-2'>
        <?php

        if ($owner == $_SESSION['Email']) {
            echo "<a href='add_pushpin.php?corkboardID={$var}' class='btn btn-outline-primary' role='button'>Add Pushpin</a>";
        }
        ?>
        </div>
    </div>

    <hr>
        <?php
            $query = "SELECT pushPinID, URL, description FROM pushpin WHERE cork_board_id = $var";

            $result = mysqli_query($db, $query);

            if (mysqli_num_rows($result) == 0) {
                print "<div>This CorkBoard has no PushPins yet.</div>";
            }

            while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
                print "<div class='row'><div class='col-md-2'><a href='view_pushpin.php?pushpin_id={$row['pushPinID']}'><img style='width:250px;height:250px;' src='{$row['URL']}' alt='{$row['description']}'></a></div></div>";
            }
            
        ?>
    <hr>

    <div class='row'>
        <?php
            //Number of watchers
            $query = "SELECT count(watch.email) AS watchers FROM watch WHERE cork_board_id = $var";
            $result = mysqli_query($db, $query);

            if (!is_bool($result) && (mysqli_num_rows($result) > 0)) {
                $row = mysqli_fetch_array($result, MYSQLI_ASSOC);
            } else {
                array_push($error_msg, "Query ERROR: Failed to load watchers...<br>" . __FILE__ . " line:" . __LINE__);
            }
            
            //watch button
            $query1 = "SELECT email, cork_board_id, `password` FROM watch LEFT JOIN privatecorkboard ON watch.cork_board_id = privatecorkboard.corkBoardID WHERE cork_board_id = {$var} AND email = '{$_SESSION['Email']}'";
            $result1 = mysqli_query($db, $query1);
            $row1  = mysqli_fetch_array($result1, MYSQLI_ASSOC);
            
            $query2 = "SELECT `owner` FROM corkboard WHERE corkBoardID = $var";
            $result2 = mysqli_query($db, $query2);
            $row2 = mysqli_fetch_array($result2, MYSQLI_ASSOC);

            $owner2 = $row2['owner'];

            // check if corkboard is private
            $query3 = "SELECT COUNT(corkBoardID) AS counts FROM PrivateCorkBoard
                WHERE corkBoardID={$var}";
            $row3 = mysqli_fetch_array(mysqli_query($db, $query3), MYSQLI_ASSOC);
            $isPublic = ($row3['counts'] == 0) ? true : false;

            // show # of watchers
            echo "<div class='col-md-10'>";
            if ($isPublic) {
                echo "This CorkBoard has <b>" . $row['watchers'] . "</b> watchers.";
            } else {
                echo "Private CorkBoard cannot be watched.";
            }
            echo "</div>";

            // show watch button
            if (strcmp($owner2, $_SESSION['Email']) != 0) {
                if ($isPublic) {
                    if (mysqli_num_rows($result1) > 0) {
                        print "<form method='POST'>
                        <input type='hidden' name='corkboard_id' value={$var}>
                        <input type='hidden' name='email' value={$_SESSION['Email']}>
                        <input type='hidden' name='unwatch_op' value=true>
                        <button type='submit' class='btn btn-outline-primary'>
                        Unwatch
                        </button>
                        </form>";
                    } else {
                        print "<form method='POST'>
                        <input type='hidden' name='corkboard_id' value={$var}>
                        <input type='hidden' name='email' value={$_SESSION['Email']}>
                        <input type='hidden' name='watch_op' value=true>
                        <button type='submit' class='btn btn-outline-primary'>
                        Watch
                        </button>
                        </form>";
                    }
                } else {
                    print "<button type='button' class='btn btn-outline-primary disabled'>Watch</button>";
                }
            }
        ?>
        <br><hr>
    </div>
    <br>
</div>
</body>
