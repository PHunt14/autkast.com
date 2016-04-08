<?php session_start();
if(ISSET($_SESSION['username'])){
?>
<h1>This is a setting page</h1>
Go to <a href='user.php'>User</a> | <a href="logout-script.php">Logout</a> | <a href="http://tutorial.world.edu/website-programming/how-to-create-login-logout-page-using-mysql-database-php-script/">Tutorial</a>
<?php
}else{
?>This page just for registered users. You are not authorized to access this page. Please <a href="login-form.php">Login</a> first<?php
}
?>
