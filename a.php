<?php
$rows = [];
if (isset($_GET['record_id'])) {
    $recordId = $_GET['record_id'];
    include 'includes/session.php';
    $conn = $pdo->open();
    $stmt = $conn->prepare("SELECT orders.*, items.items_name FROM orders LEFT JOIN items ON orders.orders_items = items.items_id WHERE orders.orders_id = :recordId");
    $stmt->execute([':recordId' => $recordId]);
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode($rows);
}
?>
