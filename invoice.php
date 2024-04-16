<!-- modal_content.php -->

<!-- Your modal content goes here -->
<div id="invoiceModal" class="modal" >
    <div class="modal-content">
        <style>
            .invoice {
                width: 80%;
                margin: auto;
                border: 1px solid #ccc;
                padding: 20px;
            }

            .invoice table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            .invoice th,
            .invoice td {
                border: 1px solid #000;
                /* Black border */
                padding: 12px;
                text-align: left;
            }

            .invoice th {
                background-color: #f2f2f2;
            }

            .invoice.total {
                margin-top: 20px;
                text-align: right;
            }

            .invoice-logo {
                text-align: center;
                margin-bottom: 20px;
            }

            .invoice-logo img {
                max-width: 80%;
                height: auto;
            }

            .download-button {
                background-color: #ffa500;
                /* Orange background */
                color: #fff;
                /* White text */
                padding: 10px;
                border: none;
                cursor: pointer;
            }
        </style>

        <script src="https://rawgit.com/eKoopmans/html2pdf/master/dist/html2pdf.bundle.js"></script>
        <div class="invoice">
            <div class="invoice-logo">
                <img src="logo.png" alt="Your Company Logo">
            </div>
            <h2>Invoice</h2>
            <p>Invoice Number: #123456</p>
            <p>Date: <?php echo date('Y-m-d'); ?></p>

            <table>
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Quantity</th>
                        <th>Unit Price</th>
                        <th>Total</th>
                    </tr>
                </thead>
                <tbody id="invoiceTableBody">
                </tbody>
            </table>

            <div class="total">
                <p>Total: <span id="totalAmount"></span></p>
            </div>

            <button class="download-button" onclick="downloadInvoice()">Download Invoice (PDF)</button>
        </div>
    </div>
</div>
<script>
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
</script>