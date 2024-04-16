<?php
include 'includes/session.php';
$cart_items_id = test_input($_GET['id']);
$return_id = test_input($_GET['return_id']);
$cart_user_id = $_COOKIE['inbox_id'];
//Sanitizing inputs.
if ($cart_items_id > 0) {
    $conn = $pdo->open();
    $stmt = $conn->prepare("SELECT COUNT(*) AS numrows,cart_qty,cart_id FROM cart WHERE cart_items_id=:cart_items_id && cart_user_id=:cart_user_id");
    $stmt->execute(['cart_items_id' => $cart_items_id, 'cart_user_id' => $cart_user_id]);
    $row = $stmt->fetch();
   if ($row['numrows'] > 0) {
    $qty = $row['cart_qty'] + 1;
    $stmt1 = $conn->prepare("UPDATE cart SET cart_qty=:qty WHERE cart_id=:id");
    $stmt1->execute(['qty' => $qty, 'id' => $row['cart_id']]);
    $_SESSION['success'] = " Item quantity added to the cart : ".$qty;
   } else {
       try {
            date_default_timezone_set('Asia/Kolkata');
            $today = date('Y-m-d h:i:s a');
            $stmt = $conn->prepare("INSERT INTO cart (cart_items_id, cart_qty, cart_user_id,cart_added_date) VALUES (:cart_items_id, :cart_qty, :cart_user_id, :cart_added_date)");
            $stmt->execute(['cart_items_id' => $cart_items_id, 'cart_qty' => 1, 'cart_user_id' => $cart_user_id, 'cart_added_date' => $today]);
            if (!isset($_POST['buy_now']))
                $_SESSION['success'] = "Item added to cart : 1";
       } catch (PDOException $e) {
            $pdo->close();
           $_SESSION['error'] = "Something Went Wrong.";
           header('location: MyHome?meal_type=' . $return_id);
       }
   }
    $pdo->close();
} else {
    $_SESSION['error'] = 'Wrong Inputs.';
}
header('location: MyHome?meal_type=' . $return_id);