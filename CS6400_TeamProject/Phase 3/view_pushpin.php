<?php
    include('lib/common.php');

    if (!isset($_SESSION['Email'])) {
        header('Location: login.php');
        exit();
    }

    if (isset($_GET['pushpin_id'])){
	  $pushpin_id = $_GET['pushpin_id'];
	}

	if (empty($pushpin_id)) {
        // array_push($error_msg,  "Please enter a non-empty search key.");
        // header(REFRESH_TIME . 'url=CorkBoard_Home.php');
        // print "empty";
    }
?>


<?php
    include('lib/header.php');
    include('ops/follow.php');
?>

<title>View PushPin</title>
</head>

<body>

<div class="container">

<?php
    include('lib/menu.php');
?>

<div class="mt-auto bg-light">

<div class="container">
<br>
<?php
	// pushPin owner
	$query = "SELECT User.name, User.email " . 
	"FROM CorkBoard " .
	"JOIN PushPin " . 
	"ON CorkBoard.corkBoardID=PushPin.cork_board_id " . 
	"JOIN User " . 
	"ON CorkBoard.owner=User.email " . 
	"WHERE PushPin.pushPinID={$pushpin_id}";

	$result = mysqli_query($db, $query);
	$row = mysqli_fetch_array($result, MYSQLI_ASSOC);
	$owner = $row['email'];

	print "<div class='row'><div class='col-md-3'><h2>{$row['name']}</h2></div>";

	// Follow button
	$query = "SELECT follower_email, followee_email " .
	"FROM Follow " .
	"WHERE follower_email='{$_SESSION['Email']}' AND followee_email='{$owner}'";

	$result = mysqli_query($db, $query);
	$row = mysqli_fetch_array($result, MYSQLI_ASSOC);

	print "<div class='col-md-2'>";
	if (mysqli_num_rows($result) > 0) {
		print "<form method='POST'>
		<input type='hidden' name='pushpin_id' value={$pushpin_id}>
		<input type='hidden' name='followee_email' value={$owner}>
		<input type='hidden' name='unfollow_op' value=true>
		<input type='hidden' name='source' value='view_pushpin'>
		<button type='submit' class='btn btn-outline-primary'>
		Unfollow
		</button>
		</form>";
	} else if (strcmp($owner, $_SESSION['Email']) != 0) {
		print "<form method='POST'>
		<input type='hidden' name='pushpin_id' value={$pushpin_id}>
		<input type='hidden' name='followee_email' value={$owner}>
		<input type='hidden' name='follow_op' value=true>
		<input type='hidden' name='source' value='view_pushpin'>
		<button type='submit' class='btn btn-outline-primary'>
		Follow
		</button>
		</form>";
	}
	print "</div></div>";

	// date pinned
	$query = "SELECT date_pinned, title, cork_board_id " .
	"FROM PushPin " . 
	"JOIN CorkBoard " . 
	"ON PushPin.cork_board_id=CorkBoard.corkBoardID " . 
	"WHERE PushPin.pushPinID={$pushpin_id}";

	$result = mysqli_query($db, $query);
	$row = mysqli_fetch_array($result, MYSQLI_ASSOC);

	print "Pinned {$row['date_pinned']} on <a href='view_corkboard.php?corkboard_id={$row['cork_board_id']}'>{$row['title']}</a>";
?>
</div>
<hr>

<div>
<?php
	// website, image, description
	$query = "SELECT URL, description, SUBSTR(URL, INSTR(URL, \"/\")+2, INSTR(SUBSTR(URL, INSTR( URL, \"/\")+2), \"/\")-1) AS PrimaryURL " . 
	"FROM PushPin " . 
	"WHERE pushPinID={$pushpin_id}";

	$result = mysqli_query($db, $query);
	$row = mysqli_fetch_array($result, MYSQLI_ASSOC);

	print "<div class='text-right'>from <b>{$row['PrimaryURL']}</b></div>";
	print "<div class='row'><div class='col-md-2'><a href='{$row['URL']}'><img style='width:500px;height:auto;' src='{$row['URL']}' alt='{$row['description']}'></a></div></div>";
	print "<div>{$row['description']}</div>";

	// tags
	$query = "SELECT tag FROM PushPinTag WHERE pushpin_id={$pushpin_id} ORDER BY tag ASC";
	$result = mysqli_query($db, $query);

	$tags = array();
	while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
		array_push($tags, $row['tag']);
	}
	$tag_list = join(", ", $tags);

	print "<div>Tags: <b>{$tag_list}</b></div>";
?>
</div>
<hr>

<div class="container">
  <div class="row">
    <div class="col-md-1">
      <img src='https://cdn.worldvectorlogo.com/logos/thumbs-up-facebook.svg'  style="width:25px;height:25px;">
    </div>
    <div class="col-md-9">
    	<?php
    		// likes
    		$query = "SELECT `Like`.email, name FROM `Like` JOIN User ON `Like`.email=User.email WHERE `Like`.pushpin_id={$pushpin_id}";
    		$result = mysqli_query($db, $query);

			$i_like = false;
			$people = array();
			while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
				array_push($people, $row['name']);
				if (strcmp($row['email'], $_SESSION['Email']) == 0) {
					$i_like = true;
				}
			}

			if (count($people) == 0) {
				print "Nobody liked this yet";
			} else {
				$people_list = join(", ", $people);
				print "<b>{$people_list}</b> liked this";
			}
    	?>
    </div>
    <div class="col-md-2">
    	<?php
    		if ($i_like) {
    			print "<form method='POST' action='ops/unlike.php'><input type='hidden' name='pushpin_id' value={$pushpin_id}><button type='submit' class='btn btn-outline-primary'>Unlike</button></form>";
    		} else {
    			print "<form method='POST' action='ops/like.php'><input type='hidden' name='pushpin_id' value={$pushpin_id}><button type='submit' class='btn btn-outline-primary'>Like</button></form>";
    		}
    	?>
    </div>
  </div>
</div>
<hr>

<div class="container">
	<form method="POST" action="ops/post_comment.php">
		<div class="form-row">
			<div class="col-md-10">
				<input type="hidden" name="pushpin_id" value=<?php echo "'{$pushpin_id}'" ?>>
		      	<input type="text" class="form-control" name="comment" placeholder="Enter Comment" required>
		    </div>
		    <div class="col-md-2">
		      	<button type="submit" class="btn btn-outline-primary">Post Comment!</button>
		    </div>
		</div>
	</form>
</div>
<br>
<div class="container">
	<table class="table table-borderless">
		<tbody>
			<?php
				$query = "SELECT name, `text` FROM Comment " . 
				"JOIN User " . 
				"ON Comment.email=User.email " . 
				"WHERE Comment.pushpin_id={$pushpin_id} " . 
				"ORDER BY date_time DESC";

				$result = mysqli_query($db, $query);

				while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
					print "<tr><td><b>{$row['name']}</b></td>";
					print "<td>{$row['text']}</td></tr>";
				}
			?>
		</tbody>
	</table>

	
</div>
<hr>

</div>
</div>
</body>
