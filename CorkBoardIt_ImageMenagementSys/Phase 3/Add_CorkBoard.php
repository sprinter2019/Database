<?php

include('lib/common.php');

    if (!isset($_SESSION['Email'])) {
        header('Location: login.php');
        exit();
    }
?>

<link rel="stylesheet" href="css/bootstrap.css">

<!doctype html>
<html lang="en">

<script src="https://code.jquery.com/jquery.min.js" type="text/javascript"></script>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>

<script type="text/javascript">
$(function load(){
  document.getElementById("Password").disabled=true;
  });

function ViewPass(key) {
    if (key=='D'){
        document.getElementById("Password").disabled=true;
        document.getElementById("Password").value = "";
    } else if (key=='E') {
        document.getElementById("Password").disabled=false;
    }
};
</script>


<div class="logo">
<img src="img/CB_logo.png" style="opacity:1;background-color:E9E5E2;" border="0" width="210px" align="right" alt="" title="CorkBoard Logo"/>
</div>

<title>Add CorkBoard</title>
<body>

<hr>

<div class="container">
<a href="CorkBoard_Home.php" class="btn btn-info" role="button" >Home</a>
<a href="logout.php" class="btn btn-danger" role="button">Log Out</a>

<hr>

<font color="green">
<h3>
<?php echo nl2br("Add CorkBoard\n"); ?>
</h3>
</font>
<hr>
<div style="width: 60%; margin:0 auto"class="mt-auto bg-warning">
<div class="features">
<div>
<h2>

<form name="profileform" action="Add_CorkBoard_query.php" method="post">
<table>

<tr>
<td><b style="margin-left: 15px;">Title</b></td>
<td>
<input type="text" name="Title" placeholder="Enter a Title" size="41" required>
</td>
</tr>
<br>


<tr>
<td><b style="margin-right: 40px; margin-left: 15px;">Category</b></td>
<td>

<?php
    $query = "SELECT * FROM category";
    $result = mysqli_query($db, $query);

    if (!empty($result) && (mysqli_num_rows($result) == 0) ) {
        array_push($error_msg, "SELECT ERROR: find CorkBoard categories <br>" . __FILE__ ." line:". __LINE__ );
    }

    echo "<select name='category'>";
    while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){
                echo "<option value=\"{$row['name']}\">{$row['name']}</option>";
    }
    echo "</select>";
?>

</td>
</tr>
<td><b style="margin-left: 15px">Visibility</b></td>
<td>

<input type="radio" name="Visibility" value="Public" checked onclick="ViewPass('D');">Public<br>
<input type="radio" name="Visibility" value="Private" onclick="ViewPass('E');">Private
<input style="margin-left: 20px" type="text" name="Password" id="Password" placeholder="Enter Password" required size="30%"><br>
</td>


</table>

<div style="margin-left: 70%">
<button type="submit" class="btn btn-success">Add</button>

<?php
    print "<input type='button' class='btn btn-danger' onClick=\"window.location='CorkBoard_Home.php';\" value='Cancel'/>";
?>

</form>
</div>
</h2>
</div>

</div>

</body>
</html>
