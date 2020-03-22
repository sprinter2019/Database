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

<title>Add PushPin to CorkBoard</title>
</head>
    
<body>

<div class="container">

<?php
include('lib/menu.php');
?>   

<form action="add_pushpin_handle.php" method="post" name="add_pushpin" target="_self">
  <p><?php echo nl2br("<h2><b>Add Pushpin</b></h2>");
        $int_corkBoardID=$_GET["corkboardID"];//url get the ID
        $_SESSION["corkboardID"]=$int_corkBoardID;
        $query="select title from corkboard where corkBoardID='$int_corkBoardID'";
        $result=mysqli_query($db,$query);
        //echo $query;
        while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
           echo "<h3>to " . $row["title"] . "</h3>";//get sql result
        }
        $db->close();//get name for the corkboardtitle
        ?> </p>
  <p>
    <label for="URL">URL：</label>
    <input type="text" name="URL" id="URL" pattern="(http(s?):)([/|.|\w|\s|-])*\.(?:jpg|gif|png)" title="url must contain .jpg/gif/png as ending" required>
  </p>
  <p>
    <label for="Description">Description</label>
    :
    <textarea name="Description" rows="6" id="Description" required=""></textarea>
  </p>
  <p>
    <label for="Tags">Tags (optional):</label>
    <input type="text" name="Tags" id="Tags">
  </p>
  <p>
    <button class="btn btn-primary" type="submit">Add</button>
    <?php
    print "<input type='button' class='btn btn-danger' onClick=\"window.location='view_corkboard.php?corkboard_id={$int_corkBoardID}';\" value='Cancel'/>";
    ?>
  </p>
</form>

