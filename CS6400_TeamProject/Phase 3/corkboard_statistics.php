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

<title>CorkBoard Statistics</title>
</head>


<body>

<div class="container">

<?php
    include('lib/menu.php');
?>


<h3>
<font color="green">
<?php echo nl2br("CorkBoard Statistics\n"); ?>
</font>
</h3>

<br>

<div class="mt-auto bg-light">

<table class="table table-bordered">
<thead>
<tr>
<th>User</th>
<th>Public CorkBoards</th>
<th>Public PushiPins</th>
<th>Private CorkBoards</th>
<th>Private PushPins</th>
</tr>
</thead>

<?php 
//long sql request, will double check after sampledata insert
$query="SELECT User.name, User.email, 
COALESCE(public_boards.counts, 0) AS public_board_count, 
COALESCE(public_pushpins.counts, 0) AS public_pushpin_count, 
COALESCE(private_boards.counts, 0) AS private_board_count, 
COALESCE(private_pushpins.counts, 0) AS private_pushpin_count 
FROM User 
LEFT JOIN 
(SELECT owner, COUNT(CorkBoard.corkBoardID) AS counts 
FROM CorkBoard 
WHERE CorkBoard.corkBoardID NOT IN (SELECT corkBoardID FROM PrivateCorkBoard) 
GROUP BY CorkBoard.owner) AS public_boards 
ON User.email=public_boards.owner 
LEFT JOIN 
(SELECT owner, COUNT(PushPin.pushPinID) AS counts 
FROM PushPin 
JOIN CorkBoard 
ON PushPin.cork_board_id=CorkBoard.corkBoardID 
WHERE CorkBoard.corkBoardID NOT IN (SELECT corkBoardID FROM PrivateCorkBoard) 
GROUP BY CorkBoard.owner) AS public_pushpins 
ON User.email=public_pushpins.owner 
LEFT JOIN 
(SELECT owner, COUNT(CorkBoard.corkBoardID) AS counts 
FROM CorkBoard 
JOIN PrivateCorkBoard 
ON CorkBoard.corkBoardID=PrivateCorkBoard.corkBoardID 
GROUP BY CorkBoard.owner) AS private_boards 
ON User.email=private_boards.owner 
LEFT JOIN 
(SELECT owner, COUNT(PushPin.pushPinID) AS counts 
FROM PushPin 
JOIN PrivateCorkBoard 
ON PushPin.cork_board_id=PrivateCorkBoard.corkBoardID 
JOIN CorkBoard 
ON PushPin.cork_board_id=CorkBoard.corkBoardID 
GROUP BY CorkBoard.owner) AS private_pushpins 
ON User.email=private_pushpins.owner 
ORDER BY public_board_count DESC, 
private_board_count DESC";

$result = mysqli_query($db, $query);

echo "<tbody>";

while($row = mysqli_fetch_array($result, MYSQLI_ASSOC))//填写表格数据
{
    $color = ($row['email']==$_SESSION['Email']) ? "<font color='red'>" : "<font>";
    
    echo "<tr>";
    echo "<td>" . $color . $row['name']. "</font></td>";
    echo "<td>" . $color . $row['public_board_count'] . "</font></td>";
    echo "<td>" . $color . $row['public_pushpin_count'] . "</font></td>";
    echo "<td>" . $color . $row['private_board_count'] . "</font></td>";
    echo "<td>" . $color . $row['private_pushpin_count'] . "</font></td>";
    echo "</tr>";
}
echo "</tbody>";
$result->close();

?>
</table>

</div>
</body>
</html>