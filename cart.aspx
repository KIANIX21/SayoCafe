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
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,300;0,400;0,700;1,700&display=swap" rel="stylesheet">

    <!-- Feather Icons-->
    <script src="https://unpkg.com/feather-icons"></script>
</head>
<body>

    <!-- Navbar -->
    <!-- Navbar -->
    <nav class="navbar">
        <a href="index.aspx" class="navbar-logo">Sayonara<span>Cafe</span>.</a>
        <div class="navbar-nav">
            <a href="index.aspx">Home</a>
            <a href="menu.aspx">Menu</a>
            <a href="#contact">Kontak</a>
            <a href="#about">Tentang Kami</a>
        </div>

        <div class="navbar-extra">
            <a href="#" id="search"><i data-feather="search"></i></a>
            <a href="../cart.aspx" id="shopping-cart"><i data-feather="shopping-cart"></i></a>
            <a href="#" id="hamburger-menu"><i data-feather="menu"></i></a>
        </div>

    </nav>


    <!-- Menu Section -->
    <div class="container">
        <h1>Keranjang Belanja</h1>

        <div class="customer-info">
            <h2>Informasi Pelanggan</h2>
            <div class="customer-field">
                <label for="nama-pelanggan">Nama Pelanggan:</label>
                <input type="text" id="nama-pelanggan" placeholder="Masukkan Nama Pelanggan">
            </div>
            <div class="customer-field">
                <label for="nomor-meja">Nomor Meja:</label>
                <input type="text" id="nomor-meja" placeholder="Masukkan Nomor Meja">
            </div>
            <div class="customer-field">
                <label for="no-hp">No. HP:</label>
                <input type="text" id="no-hp" placeholder="Masukkan No. HP">
            </div>
        </div>

        <table>
        </table>

        <div class="checkout">
            <a href="#" class="btn-konfirmasi">Bayar</a>
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
        function renderCartItems() {
            const cartItems = JSON.parse(sessionStorage.getItem('cart'));
            const table = document.querySelector('table');
            let tableRows = `
                <thead>
                <tr>
                    <th>Nama Menu</th>
                    <th>Harga</th>
                    <th>Kategori</th>
                    <th>Quantity</th>
                    <th></th>
                </tr>
            </thead> `;

            if (cartItems) {
                let i = 0;
                while (i < cartItems.length) {
                    tableRows += `
            <tbody>
            <tr>
                <td>${cartItems[i].name}</td>
                <td>${cartItems[i].price}</td>
                <td>${cartItems[i].category}</td>
                <td><input type="number" min="1" value="1"></td>
                <td><button class="remove-item" data-index="${i}">Remove</button></td>
            </tr>
            <tbody>`;
                    i++;
                }
            } else {
                tableRows = ``;
            }

            table.innerHTML = tableRows;

            const removeItemButtons = document.querySelectorAll('.remove-item');
            removeItemButtons.forEach((button) => {
                button.addEventListener('click', () => {
                    const index = button.dataset.index;
                    const cart = JSON.parse(sessionStorage.getItem('cart'));
                    cart.splice(index, 1);
                    sessionStorage.setItem('cart', JSON.stringify(cart));
                    renderCartItems();
                });
            });
        }

        renderCartItems();
    </script>
</body>
</html>
