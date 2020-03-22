<?php

include('lib/common.php');

    if (!isset($_SESSION['Email'])) {
        header('Location: login.php');
        exit();
    }
    

?>

<?php
    include('lib/header.php');
?>

<title>Popular Tags</title>
</head>


<body>

<div class="container">

<?php
    include('lib/menu.php');
?>


<font color="green">
<h3>
<?php echo nl2br("Popular Tags\n"); ?>
</h3>
</font>
<br>



<div class="mt-auto bg-light">


<table class="table table-bordered">
<thead>
<th scope="col">Tag</th>
<th scope="col">PushPins</th>
<th scope="col">Unique CorkBoards</th>
</thead>


<?php

    $query = "SELECT PushPinTag .tag, COUNT( PushPin .pushPinID) AS `PushPins`, COUNT( CorkBoard .corkBoardID) AS `Unique CorkBoards` FROM PushPin INNER JOIN PushPinTag ON PushPinTag .pushpin_id= PushPin .pushPinID INNER JOIN CorkBoard ON CorkBoard .corkBoardID= PushPin .cork_board_id GROUP BY PushPinTag .tag ORDER BY `PushPins` DESC LIMIT 5";
    
    
    $result = mysqli_query($db, $query);

    
    if (!empty($result) && (mysqli_num_rows($result) == 0) ) {
        array_push($error_msg,  "SELECT ERROR: find Fpopular tags <br>" . __FILE__ ." line:". __LINE__ );
    }
   
    while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){
        
        $id=$row['tag'];
        print "<tr>";
        print "<td><a href='search.php?search_key=$id'> $id </a></td>";
        print "<td>{$row['PushPins']}</td>";
        print "<td>{$row['Unique CorkBoards']}</td>";
        print "</tr>";
   }
    
?>

</table>

</div>
</body>
</html>
