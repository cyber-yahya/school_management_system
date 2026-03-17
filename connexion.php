<?php
$host = 'localhost';
$dbname = 'tp10';
$user = 'root';
$pw = '0000';


try 
{
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $user,$pw);
    // echo" connexion avec success";
}
catch(PDOException $e)
{
    die("Erreur de connexion". $e -> getMessage());
}
?>