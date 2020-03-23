<?php
    include('lib/common.php');

    if (isset($_GET['search_key'])){
	  $search_key = $_GET['search_key'];
	}
?>


<?php
    include('lib/header.php');
?>

<title>Search Page</title>
</head>

<body>

<div class="container">

<?php
    include('lib/menu.php');
?>

<h2>
<?php echo "PushPin Search Results for: {$search_key}"; ?>
</h2>
<br>
<div class="mt-auto bg-light">

<table class="table">
	<thead>
		<tr>
			<th>PushPin Description</th>
			<th>CorkBoard</th>
			<th>Owner</th>
		</tr>
	</thead>
	
	<tbody>
		<?php
			$query = "SELECT description, title, pushPinID, name " .
			"FROM " .
			"(SELECT description, title, pushPinID, name " .
			"FROM PushPin " .
			"JOIN CorkBoard ON PushPin.cork_board_id=CorkBoard.corkBoardID " .
			"JOIN User ON CorkBoard.owner=User.email " .
			"JOIN PushPinTag ON PushPin.pushPinID=PushPinTag.pushpin_id " .
			"WHERE CorkBoard.corkBoardID NOT IN (SELECT corkBoardID FROM PrivateCorkBoard) " .
			"AND (PushPin.description LIKE '%{$search_key}%' " .
			"OR PushPinTag.tag LIKE '%{$search_key}%' " .
			"OR CorkBoard.category_name LIKE '%{$search_key}%') " .
			"GROUP BY PushPin.pushPinID) AS list " .
			"ORDER BY description";

			$result = mysqli_query($db, $query);
    
    		while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
    			print "<tr><td><a href='view_pushpin.php?pushpin_id={$row['pushPinID']}'>{$row['description']}</a></td>";
    			print "<td>{$row['title']}</td>";
    			print "<td>{$row['name']}</td></tr>";
    		}
		?>
	</tbody>
</table>
</div>
</div>
</body>
