<?php include '../includes/session.php'; ?>
<?php include '../includes/header.php'; ?>

<body class="hold-transition skin-blue sidebar-mini">
  <div class="wrapper">

    <?php include '../includes/navbar.php'; ?>
    <?php include '../includes/menubar.php'; ?>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
      <!-- Content Header (Page header) -->
      <section class="content-header">
        <h1>
          Accepted Orders
        </h1>
        <ol class="breadcrumb">
          <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
          <li class="active">Manage</li>
          <li class="active">Accepted Orders</li>
        </ol>
      </section>

      <!-- Main content -->
      <section class="content">
        <?php
        if (isset($_SESSION['error'])) {
          echo "
            <div class='alert alert-danger alert-dismissible'>
              <button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;</button>
              <h4><i class='icon fa fa-warning'></i> Error!</h4>
              " . $_SESSION['error'] . "
            </div>
          ";
          unset($_SESSION['error']);
        }
        if (isset($_SESSION['success'])) {
          echo "
            <div class='alert alert-success alert-dismissible'>
              <button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;</button>
              <h4><i class='icon fa fa-check'></i> Success!</h4>
              " . $_SESSION['success'] . "
            </div>
          ";
          unset($_SESSION['success']);
        }
        ?>
        <div class="panel panel-default" style="overflow-x:auto;">
          <div class="row">
            <div class="col-xs-12">
              <div class="box">

                <div class="box-body">
                  <table id="example1" class="table table-bordered">
                    <thead>
                      <th>OID</th>
                      <th>Item - cost*(Qty)</th>
                      <th>Catogory</th>
                      <th>Added Date</th>
                    </thead>
                    <tbody>
                      <?php
                      $conn = $pdo->open();
                      try {
                        $stmt = $conn->prepare("SELECT * FROM orders left join items on orders_items=items_id WHERE item_chef_id=:orders_chef_id AND orders_accept=:orders_accept");
                        $stmt->execute(['orders_chef_id' => $_SESSION['vm_id_admin'], 'orders_accept' => 1]);
                        foreach ($stmt as $row) {
                          echo "<tr  style='background-color:lightgreen'>";
                          echo "<td>" . $row['orders_id'] . "</td>";
                          echo "<td>" . $row['items_name'] . " - " . $row['items_cost'] . "*(" . $row['orders_qty'] . ")</td>";

                          switch ($row['item_category']) {
                            case 0:
                              $label = 'Veg';
                              break;
                            case 1:
                              $label = 'Non-Veg';
                              break;
                            default:
                              $label = 'Unknown';
                              break;
                          }
                          echo "<td>";
                          $stmtcatname = $conn->prepare("SELECT category_name FROM category WHERE category_id=:item_meal_type");
                          $stmtcatname->execute(['item_meal_type' => $row['item_meal_type']]);
                          foreach ($stmtcatname as $rowcatname)
                            echo htmlspecialchars($label) . " - " . htmlspecialchars($rowcatname['category_name']);
                          echo "</td>";
                          echo "<td>" . $row['items_add_date'] . "</td>";

                          echo "</tr>";
                        }
                      } catch (PDOException $e) {
                        echo "Something Went Wrong.";
                      }

                      $pdo->close();
                      ?>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
      <!-- Add -->
    </div>

    <!--accept orders-->

    <!-- ./wrapper -->
  </div>
  <?php include '../includes/scripts.php'; ?>
</body>

</html>