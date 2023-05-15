<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cart.aspx.cs" Inherits="SayoCafe.cart" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SayoCafe</title>

    <!-- CSS -->
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/cart.css">

    <!-- Fonts-->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,300;0,400;0,700;1,700&display=swap" rel="stylesheet">

    <!-- Feather Icons-->
    <script src="https://unpkg.com/feather-icons"></script>
    <style>
        /* Style untuk modal */
.modal {
  display: none;
  position: fixed;
  z-index: 1;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0,0,0,0.4);
}

/* Style untuk konten modal */
.modal-content {
  background-color: blue;
  margin: 10% auto;
  padding: 20px;
  border: 1px solid #888;
  width: 80%;
}

/* Style untuk tombol close */
.close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

/* Style untuk tombol close pada hover */
.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}

    </style>
</head>
<body>

    <!-- Navbar -->
    <!-- Navbar -->
    <nav class="navbar">
        <a href="index.aspx" class="navbar-logo">Sayonara<span>Cafe</span>.</a>
        <div class="navbar-nav">
            <a href="menu.aspx">Menu</a>
        </div>

        <div class="navbar-extra">
            <a href="../cart.aspx" id="shopping-cart"><i data-feather="shopping-cart"></i></a>
            <a href="#" id="hamburger-menu"><i data-feather="menu"></i></a>
        </div>

    </nav>


    <!-- Menu Section -->
    <div class="container">
        <h1>Keranjang Belanja</h1>
        <table>
        <thead>
      <tr>
        <th>Nama Menu</th>
        <th>Harga</th>
        <th>Kategori</th>
        <th>Quantity</th>
        <th>Total</th>
        <th></th>
      </tr>
    </thead>
       <tbody>
       </tbody>
        </table>

<div class="checkout">
  <a href="#" class="btn-konfirmasi" onclick="showModal()">Bayar</a>
</div>
<div id="myModal" class="modal">
  <div class="modal-content">
    <span class="close" onclick="hideModal()">&times;</span>
    <h2>Konfirmasi Pembelian</h2>
    <p>Silakan cek kembali pesanan Anda:</p>
    <table id="checkout-table">
      <thead>
        <tr>
          <th>Nama Menu</th>
          <th>Harga</th>
          <th>Kategori</th>
          <th>Jumlah</th>
          <th>Total Harga</th>
        </tr>
      </thead>
      <tbody>
      </tbody>
    </table>
<div class="customer-info">
    <h2>Informasi Pelanggan</h2>
    <form id="form1" runat="server">
    <div class="customer-field">
        <label for="nama-pelanggan">Nama Pelanggan:</label>
        <asp:TextBox ID="namaPelangganInput" runat="server" placeholder="Masukkan Nama Pelanggan"></asp:TextBox>
    </div>
    <div class="customer-field">
        <label for="nomor-meja">Nomor Meja:</label>
        <asp:TextBox ID="nomorMejaInput" runat="server" placeholder="Masukkan Nomor Meja"></asp:TextBox>
    </div>
    <div class="customer-field">
        <label for="no-hp">No. HP:</label>
        <asp:TextBox ID="noHpInput" runat="server" placeholder="Masukkan No. HP"></asp:TextBox>
    </div>
    <div class="customer-field">
        <label for="transcode">Transcode Terakhir:</label>
        <asp:Label ID="transcodeLabel" runat="server" ></asp:Label>
    </div>
        </form>
</div>
    <button class="btn-konfirmasi-pembelian" onclick="konfirmasiPembelian()">Konfirmasi Pembelian</button>
  </div>
</div>

    </div>

    <!-- Footer -->
    <footer>
        <div class="social">
            <a href="#"><i data-feather="facebook"></i></a>
            <a href="#"><i data-feather="instagram"></i></a>
            <a href="#"><i data-feather="twitter"></i></a>
        </div>

        <div class="links">
            <a href="index.aspx">Home</a>
            <a href="#menu">Menu</a>
            <a href="#contact">Kontak</a>
            <a href="#about">Tentang Kami</a>
        </div>

        <div class="credit">
            <p>Created by Group 2 | &copy; 2023</p>
        </div>
    </footer>

    <!-- Feather Icon-->
    <script>
        feather.replace()
    </script>

    <!-- Javascript -->
    <script src="js/script.js"></script>
    <script>
        function showModal() {
            // Ambil informasi dari header transaksi
            const namaPelanggan = document.getElementById('namaPelangganInput').value;
            const nomorMeja = document.getElementById('nomorMejaInput').value;
            const noHp = document.getElementById('noHpInput').value;
            const transcode = document.getElementById('transcodeLabel').textContent;

            // Ambil data detail transaksi dari JSON
            const cart = JSON.parse(localStorage.getItem('cart')) || [];

            // Buat HTML untuk tabel detail transaksi
            const tableBody = document.querySelector('#checkout-table tbody');
            tableBody.innerHTML = '';
            cart.forEach(item => {
                const row = tableBody.insertRow();
                const nameCell = row.insertCell(0);
                nameCell.textContent = item.menuName;
                const priceCell = row.insertCell(1);
                priceCell.textContent = `IDR ${item.price.toLocaleString()}`;
                const categoryCell = row.insertCell(2);
                categoryCell.textContent = item.categoryName;
                const quantityCell = row.insertCell(3);
                quantityCell.textContent = item.quantity;
                const totalPriceCell = row.insertCell(4);
                totalPriceCell.textContent = `IDR ${(item.totalPrice).toLocaleString()}`;
            });

            // Tampilkan informasi transaksi pada modal
            document.getElementById('namaPelangganInput').textContent = namaPelanggan;
            document.getElementById('transcodeLabel').textContent = transcode;
            document.getElementById('nomorMejaInput').textContent = nomorMeja;
            document.getElementById('noHpInput').textContent = noHp;

            // Tampilkan modal
            const modal = document.getElementById('myModal');
            modal.style.display = 'block';
        }

        function hideModal() {
            const modal = document.getElementById('myModal');
            modal.style.display = 'none';
        }

        function konfirmasiPembelian() {
            // Setelah proses pembayaran selesai, kosongkan keranjang belanja
            localStorage.removeItem('cart');
            // Sembunyikan modal
            hideModal();
            // Tampilkan pesan sukses
            alert('Pembayaran berhasil!');
        }
    </script>
    <script>
        function displayCart() {
            const cart = JSON.parse(localStorage.getItem('cart')) || [];

            const tableBody = document.querySelector('tbody');

            tableBody.innerHTML = '';

            cart.forEach(item => {
                const row = tableBody.insertRow();

                const nameCell = row.insertCell(0);
                nameCell.textContent = item.menuName;

                const priceCell = row.insertCell(1);
                priceCell.textContent = `IDR ${item.price.toLocaleString()}`;

                const categoryCell = row.insertCell(2);
                categoryCell.textContent = item.categoryName;

                const quantityCell = row.insertCell(3);
                const quantityInput = document.createElement('input');
                quantityInput.type = 'number';
                quantityInput.min = 1;
                quantityInput.value = item.quantity;
                quantityInput.classList.add('item-quantity');
                quantityCell.appendChild(quantityInput);

                const totalPriceCell = row.insertCell(4);
                totalPriceCell.textContent = `IDR ${(item.totalPrice).toLocaleString()}`;

                const removeCell = row.insertCell(5);
                const removeButton = document.createElement('button');
                removeButton.classList.add('remove-item');
                removeButton.textContent = 'Remove';
                removeCell.appendChild(removeButton);
            });
            // Add event listeners for remove item buttons
            const removeItemButtons = document.querySelectorAll('.remove-item');
            removeItemButtons.forEach((button) => {
                button.addEventListener('click', () => {
                    // Get index of item to remove from button's data-index attribute
                    const index = button.dataset.index;
                    const cart = JSON.parse(localStorage.getItem('cart'));
                    // Remove item from cart array and update session storage
                    cart.splice(index, 1);
                    local.setItem('cart', JSON.stringify(cart));
                    // Render the updated cart items
                    displayCart();
                });
            });
        }

        displayCart();
    </script>
</body>
</html>
