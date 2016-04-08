<?php session_start();
if(ISSET($_SESSION['username'])){
?>
<h1>This is a user page</h1>
Go to <a href='setting.php'>Setting</a> | <a href="logout-script.php">Logout</a> | <a href="http://tutorial.world.edu/website-programming/how-to-create-login-logout-page-using-mysql-database-php-script/">Tutorial</a>
<?php
}else{
?>This page just for registered users. You are not authorized to access this page. Please <a href="login-form.php">Login</a> first<?php
}
?>
