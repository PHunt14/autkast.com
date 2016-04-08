<?php session_start(); 
//load database connection
include("database-connect.php");
$username=$_POST['username'];
$password=$_POST['password'];
// MySQL data
$_SESSION['username']=$username;
$query = $pdo->prepare("select * from user where username LIKE '%$username%' AND password LIKE '%$password%'  LIMIT 0 , 1 ");
$query->execute();
if($check = $query->fetch()){
if($check['username'] == $_POST['username']){
header('Location: user.php');
}else{
echo "You have failed to login. Please <a href='login-form.php'>Login </a> again";
}
} else {
echo "username and password invalid ! Please <a href='login-form.php'>Login</a> again";
}
?>
