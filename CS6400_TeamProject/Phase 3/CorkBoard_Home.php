<?php

    include('lib/common.php');

    if (!isset($_SESSION['Email'])) {
        header('Location: login.php');
        exit();
    }
    
    
    $query = "SELECT name " .
    "FROM User " .
    "WHERE User.email='{$_SESSION['Email']}'";
    
    $result = mysqli_query($db, $query);
    include('lib/show_queries.php');
    
    if ( !is_bool($result) && (mysqli_num_rows($result) > 0) ) {
        $row = mysqli_fetch_array($result, MYSQLI_ASSOC);
    } else {
        array_push($error_msg,  "Query ERROR: Failed to get User profile...<br>" . __FILE__ ." line:". __LINE__ );
    }

?>


<?php
    include('lib/header.php');
?>

<title>CorkBoardIt Home Page</title>
</head>

<body>

<div class="container">

<?php
    include('lib/home_menu.php');
?>

<font color="green">
<h4>
<?php echo "Home Page for\n"; ?>
</h4>
<h2>
<?php echo $row['name']; ?>
</h2>
</font>

<hr>

<div>
<h2>Recent CorkBoard Updates</h2>
<div class="mt-auto bg-light">
<table class="table">
<tbody>
<?php
    $query = "SELECT CorkBoard.corkBoardID AS corkBoardID, CorkBoard.date_updated AS date_updated, CorkBoard.title AS title, User.name AS name, password " . 
    "FROM CorkBoard " . 
    "JOIN User " .
    "ON CorkBoard.owner=User.email " .
    "LEFT JOIN PrivateCorkBoard " .
    "ON CorkBoard.corkBoardID=PrivateCorkBoard.corkBoardID " .
    "WHERE (CorkBoard.owner='{$_SESSION['Email']}' " .
    "OR CorkBoard.corkBoardID IN " .
    "(SELECT cork_board_id " .
    "FROM Watch " .
    "WHERE email='{$_SESSION['Email']}') " .
    "OR CorkBoard.owner IN " .
    "(SELECT followee_email " .
    "FROM Follow ".
    "WHERE follower_email='{$_SESSION['Email']}')) " .
    "AND CorkBoard.corkBoardID IN " . 
    "(SELECT DISTINCT cork_board_id FROM PushPin) " . 
    "ORDER BY CorkBoard.date_updated DESC ".
    "LIMIT 4";
    
    $result = mysqli_query($db, $query);

    if (mysqli_num_rows($result) == 0) {
        print "<div>No Updates.</div>";
    }
    
    while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
        print "<tr><td><h4><a href='view_corkboard.php?corkboard_id={$row['corkBoardID']}'>{$row['title']}</a>";
        if (!is_null($row['password'])) {
            print " <font color='red'>(private)</font>";
        }
        print "</h4>";
        print "Updated by <b>{$row['name']}</b> on <b>{$row['date_updated']}</b></td></tr>";
    }

?>
</tbody>
</table>
</div>
</div>
<hr>

<div>
    <h2>My CorkBoards
    <a href="Add_CorkBoard.php" class="btn btn-primary" role="button">Add CorkBoard</a>
    </h2>
</div>

<div class="mt-auto bg-light">
<table class="table">
<tbody>
<?php
    $query = "SELECT title, corkBoardID, pushpin_count, password " .
    "FROM " .
    "(SELECT cb.title, cb.corkBoardID, COUNT(PushPin.pushPinID) AS pushpin_count, password " .
    "FROM " . 
    "(SELECT title, corkBoardID " .
    "FROM CorkBoard " .
    "WHERE CorkBoard.owner='{$_SESSION['Email']}') AS cb " .
    "LEFT JOIN " .
    "PushPin " . 
    "ON cb.corkBoardID=PushPin.cork_board_id " . 
    "LEFT JOIN " . 
    "PrivateCorkBoard " .
    "ON cb.corkBoardID=PrivateCorkBoard.corkBoardID " . 
    "GROUP BY cb.corkBoardID) AS list " . 
    "ORDER BY title";

    $result = mysqli_query($db, $query);

    if (mysqli_num_rows($result) == 0) {
        print "<div>You have no CorkBoards.</div>";
    }
    
    while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
        print "<tr><td><h4><a href='view_corkboard.php?corkboard_id={$row['corkBoardID']}'>{$row['title']}</a> ";

        if (!is_null($row['password'])) {
            print "<font color='red'>(private)</font> ";
        }

        print "with {$row['pushpin_count']} PushPins</h4></td></tr>";
    }
    
?>
</tbody>
</table>
</div>
<hr>

<div class="container">
    <form action="search.php">
        <div class="form-row">
            <div class="col-md-10">
                <input type="text" class="form-control" name="search_key" placeholder="Search description, tags and CorkBoard category" required>
            </div>

            <div class="col-md-2">
                <button type="submit" class="btn btn-primary">PushPin Search</button>
            </div>
        </div>
    </form>
</div>

</div>
<br>
</body>
</html>
