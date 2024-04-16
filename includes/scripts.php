<!-- jQuery 3 -->
<script src="bower_components/jquery/dist/jquery.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="bower_components/jquery-ui/jquery-ui.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- Select2 -->
<script src="bower_components/select2/dist/js/select2.full.min.js"></script>
<!-- Moment JS -->
<script src="bower_components/moment/moment.js"></script>
<!-- DataTables -->
<script src="bower_components/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="bower_components/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
<!-- ChartJS -->
<script src="bower_components/chart.js/Chart.js"></script>
<!-- daterangepicker -->
<script src="bower_components/moment/min/moment.min.js"></script>
<script src="bower_components/bootstrap-daterangepicker/daterangepicker.js"></script>
<!-- datepicker -->
<script src="bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
<!-- bootstrap time picker -->
<script src="plugins/timepicker/bootstrap-timepicker.min.js"></script>
<!-- Slimscroll -->
<script src="bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="bower_components/fastclick/lib/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/adminlte.min.js"></script>
<!-- CK Editor -->
<script src="bower_components/ckeditor/ckeditor.js"></script>
<!-- Active Script -->
<link href="src/facebox.css" media="screen" rel="stylesheet" type="text/css" />
<script src="src/facebox.js" type="text/javascript"></script>
<script type="text/javascript">
  jQuery(document).ready(function($) {
    $('a[rel*=facebox]').facebox({
      loadingImage : 'src/loading.gif',
      closeImage   : 'src/closelabel.png'
    })
  })
</script>
<script>
$(function(){
	/** add active class and stay opened when selected */
	var url = window.location;
  
	// for sidebar menu entirely but not cover treeview
	$('ul.sidebar-menu a').filter(function() {
	    return this.href == url;
	}).parent().addClass('active');

	// for treeview
	$('ul.treeview-menu a').filter(function() {
	    return this.href == url;
	}).parentsUntil(".sidebar-menu > .treeview-menu").addClass('active');

});
</script>
<!-- Data Table Initialize -->
<script>
  $(function () {
    $('#example1').DataTable({
      responsive: true
    })
    $('#example2').DataTable({
      'paging'      : true,
      'lengthChange': false,
      'searching'   : false,
      'ordering'    : true,
      'info'        : true,
      'autoWidth'   : false
    })
  })
</script>
<script>
  $(function(){
    //Initialize Select2 Elements
    $('.select2').select2()

    //CK Editor
    CKEDITOR.replace('editor1')
    CKEDITOR.replace('editor2')
  });
</script>


<script>
    function openInvoiceModal(recordId) {
        var modal = document.getElementById("invoiceModal");
        modal.style.display = "block";

        // Now, let's make an AJAX request to pass the recordId to your PHP script
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                var responseData = JSON.parse(this.responseText);
                var tbody = document.getElementById("invoiceTableBody");
                var totalAmount = 0;

                // Clear existing rows
                tbody.innerHTML = "";

                // Populate table rows
                responseData.forEach(function(rowData) {
                    var row = document.createElement("tr");
                    var total = rowData.orders_qty * rowData.orders_cost;

                    row.innerHTML = "<td>" + rowData.items_name + "</td>" +
                                    "<td>" + rowData.orders_qty + "</td>" +
                                    "<td>" + rowData.orders_cost + "</td>" +
                                    "<td>" + total + "</td>";
                    tbody.appendChild(row);

                    totalAmount += total;
                });

                // Update total amount
                document.getElementById("totalAmount").textContent = totalAmount;
            }
        };
        xhttp.open("GET", "a.php?record_id=" + recordId, true);
        xhttp.send();
    }

    function downloadInvoice() {
        var element = document.querySelector('.invoice');
        var button = document.querySelector('.download-button');

        // Hide the button temporarily
        button.style.display = 'none';

        // Use html2pdf library to convert HTML to PDF
        html2pdf(element, {
            margin: 10,
            filename: 'invoice.pdf',
            image: {
                type: 'jpeg',
                quality: 0.98
            },
            html2canvas: {
                scale: 2
            },
            jsPDF: {
                unit: 'mm',
                format: 'a4',
                orientation: 'portrait'
            }
        }).then(() => {
            // Show the button again after PDF generation
            button.style.display = 'block';
        });
    }
    function closeInvoiceModal() {
        var modal = document.getElementById("invoiceModal");
        modal.style.display = "none"; // Hide the modal
    }

    // Close the modal when clicking outside of it
    window.onclick = function(event) {
        var modal = document.getElementById("invoiceModal");
        if (event.target == modal) {
            closeInvoiceModal(); // Close the modal
        }
      }
</script>

