<?php
    include('lib/common.php');
    
    if($showQueries){
        array_push($query_msg, "showQueries currently turned ON, to disable change to 'false' in lib/common.php");
    }
    

// Note: known issue with _POST always empty using PHPStorm built-in web server: Use *AMP server instead


if( $_SERVER['REQUEST_METHOD'] == 'POST') {
    
    $enteredEmail = mysqli_real_escape_string($db, $_POST['Email']);
    $enteredPassword = mysqli_real_escape_string($db, $_POST['PIN']);
    
    if (empty($enteredEmail)) {
        array_push($error_msg,  "Please enter an email address.");
    }
    
    if (empty($enteredPassword)) {
        array_push($error_msg,  "Please enter a 4 dgits PIN.");
    }
    
    if (!ctype_digit($enteredPassword)){
        array_push($error_msg,  "PIN can only contain digits!");
    }
    
    elseif (strlen($enteredPassword)!=4){
        array_push($error_msg,  "PIN must be of exactly 4 digits!");
    }
    
    elseif ( !empty($enteredEmail) && !empty($enteredPassword) )   {
        
        $query = "SELECT PIN FROM User WHERE Email='$enteredEmail'";
        
        $result = mysqli_query($db, $query);
        include('lib/show_queries.php');
        $count = mysqli_num_rows($result);
        
        if (!empty($result) && ($count > 0) ) {
            $row = mysqli_fetch_array($result, MYSQLI_ASSOC);
            $storedPassword = $row['PIN'];
            
            $options = [
            'cost' => 8,
            ];
            //convert the plaintext passwords to their respective hashses
            // 'michael123' = $2y$08$kr5P80A7RyA0FDPUa8cB2eaf0EqbUay0nYspuajgHRRXM9SgzNgZO
            $storedHash = password_hash($storedPassword, PASSWORD_DEFAULT , $options);   //may not want this if $storedPassword are stored as hashes (don't rehash a hash)
            $enteredHash = password_hash($enteredPassword, PASSWORD_DEFAULT , $options);
            
            if($showQueries){
                array_push($query_msg, "Plaintext entered PIN: ". $enteredPassword);
                //Note: because of salt, the entered and stored password hashes will appear different each time
                array_push($query_msg, "Entered Hash:". $enteredHash);
                array_push($query_msg, "Stored Hash:  ". $storedHash . NEWLINE);  //note: change to storedHash if tables store the plaintext password value
                //unsafe, but left as a learning tool uncomment if you want to log passwords with hash values
                //error_log('email: '. $enteredEmail  . ' password: '. $enteredPassword . ' hash:'. $enteredHash);
            }
            
            //depends on if you are storing the hash $storedHash or plaintext $storedPassword
            if (password_verify($enteredPassword, $storedHash) ) {
                array_push($query_msg, "PIN is Valid! ");
                $_SESSION['Email'] = $enteredEmail;
                array_push($query_msg, "logging in... ");
                header(REFRESH_TIME . 'url=CorkBoard_Home.php');        //to view the password hashes and login success/failure
                
            } else {
                array_push($error_msg, "Login failed: " . $enteredEmail . NEWLINE);
                array_push($error_msg, "To demo enter: ". NEWLINE . "john.doe@gatech.edu". NEWLINE ."1234");
            }
            
        } else {
            array_push($error_msg, "The username entered does not exist: " . $enteredEmail);
        }
    }
}
?>


<!doctype html>
<html lang="en">


<title>CorkBoardIt Login</title>
</head>
<body>

<link rel="stylesheet" href="css/style.css">


<div id="main_container">
<div id="header">
<div class="topleft">
<img src="img/GT_img_02.png" style="opacity:0.75;background-color:E9E5E2;" border="2" alt="" title="CorkBoardIt Logo" width="25%" height="auto"/>
</div>
</div>
</div>

<div class="box_login">
Login

<dev class="login_margin">
</dev>

<div class="text_loginbox">

<form action="login.php" method="post" enctype="multipart/form-data">

<div class="login_form_row">
<label class="CBlogin_label1">Email</label>
<input type="text" name="Email" value="dschrute@dundermifflin.com"
class="CBlogin_input1"/>
</div>


<div class="login_form_row">
<label class="CBlogin_label2">PIN</label>
<input type="password" name="PIN" value="1234"
class="CBlogin_input2"/>
</div>
<input type="image" src="img/login.gif" class="CBlogin"/>
<form/>

</div>

<div class="clear"></div>


</div>

</div>


</div>
</body>
</html>
