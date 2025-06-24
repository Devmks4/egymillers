<?php
$host = 'fdb1028.awardspace.net:3306';
$db = '4638597_egymillers';
$user = '4638597_egymillers';
$pass = 'egy123456';

$conn = new mysqli($host, $user, $pass, $db);
$conn->set_charset("utf8mb4");

if ($conn->connect_error) {
    die(json_encode(['error' => 'Connection failed']));
}

$result = $conn->query("SELECT * FROM products_prices");
$prices = [];

while($row = $result->fetch_assoc()) {
    $prices[] = $row;
}

echo json_encode($prices,JSON_UNESCAPED_UNICODE);
?>