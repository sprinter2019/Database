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

<title>Popular Sites</title>
</head>

<body>

<div class="container">

<?php
    include('lib/menu.php');
?>


<font color="green">
<h3>
<?php echo nl2br("Popular Sites\n"); ?>
</h3>
</font>
<br>



<div class="mt-auto bg-light">


<table class="table table-bordered">
<thead>
<th scope="col">Site</th>
<th scope="col">PushPins</th>
</thead>


<?php

    $query = "SELECT SUBSTR( PushPin .URL, INSTR( PushPin .URL, \"/\")+2, INSTR(SUBSTR( PushPin .URL, INSTR( PushPin .URL, \"/\")+2), \"/\")-1) AS PrimaryURL, COUNT( `PushPin` .`pushPinID`) AS Pushpins FROM PushPin GROUP by PrimaryURL ORDER by COUNT( `PushPin` .`pushPinID`) DESC";
    

    $result = mysqli_query($db, $query);

    if (!empty($result) && (mysqli_num_rows($result) == 0) ) {
        array_push($error_msg,  "SELECT ERROR: find Fpopular tags <br>" . __FILE__ ." line:". __LINE__ );
    }
    while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){
        
        print "<tr>";

        print "<td>{$row['PrimaryURL']}</td>";
        print "<td>{$row['Pushpins']}</td>";
        print "</tr>";
   }
    
?>

</table>

</div>
</body>
</html>
