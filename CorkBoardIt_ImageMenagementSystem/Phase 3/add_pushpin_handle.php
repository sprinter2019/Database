<?php
include('lib/common.php');

if (!isset($_SESSION['Email'])) {
    header('Location: login.php');
    exit();
}
//$db = mysqli_connect(DB_HOST, DB_USER, DB_PASS, DB_SCHEMA, DB_PORT);
$varchar_user=$_SESSION['Email'];
$varchar_URL=$_POST["URL"];
$varchar_description=$_POST["Description"];
$varchar_tags=$_POST["Tags"];//get all the parameters
$int_corkboardid=$_SESSION["corkboardID"];//get the corkboardid from url of post
$query="insert into pushpin(cork_board_id, URL,description, date_pinned) VALUES ('$int_corkboardid','$varchar_URL','$varchar_description',now());";//insert and return key
mysqli_query($db, $query);
$int_pushpin_id=mysqli_insert_id($db);//back the insert key ID

if (!$int_pushpin_id) {
    print "This PushPin already exists!";
    header("refresh:0.3; url=view_corkboard.php?corkboard_id={$int_corkboardid}");
} else {
    mysqli_query($db,"update corkboard set date_updated=now() where corkboardID='$int_corkboardid' ");//update the timestamp fpr corkboard

    if (!empty($varchar_tags)) {
        $array_tags=explode(",",$varchar_tags);//tags to array tags

        foreach ($array_tags as $single_tags)//foreach for tags
        {
            mysqli_query($db,"insert into pushpintag(pushpin_id, tag) VALUES ('$int_pushpin_id','$single_tags')");
        }
    }

    print "<script language=\"JavaScript\">\r\n";
    print " alert(\"pushpin uploaded\");\r\n";
    print " location.replace(\"./view_pushpin.php?pushpin_id={$int_pushpin_id}\");\r\n";//can add link to the original pushpin...
    print "</script>";
    exit;
}

$db->close();

?>
