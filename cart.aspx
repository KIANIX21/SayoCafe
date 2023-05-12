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
            // Get cart items from session storage
            const cartItems = JSON.parse(sessionStorage.getItem('cart'));

            // Get table element and add header row
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
            </thead>
        `;

            // If cart has items, add rows for each item
            if (cartItems) {
                let i = 0;
                while (i < cartItems.length) {
                    tableRows += `
                    <tbody>
                        <tr>
                            <td>${cartItems[i].name}</td>
                            <td>${cartItems[i].price}</td>
                            <td>${cartItems[i].category}</td>
                            <td><input type="number" min="1" value="${cartItems[i].quantity}" class="item-quantity"></td>
                            <td><button class="remove-item" data-index="${i}">Remove</button></td>
                        </tr>
                    </tbody>
                `;
                    i++;
                }
            } else {
                // If cart is empty, set table rows to empty string
                tableRows = ``;
            }

            // Set the table's innerHTML to the generated rows
            table.innerHTML = tableRows;

            // Add event listeners for remove item buttons
            const removeItemButtons = document.querySelectorAll('.remove-item');
            removeItemButtons.forEach((button) => {
                button.addEventListener('click', () => {
                    // Get index of item to remove from button's data-index attribute
                    const index = button.dataset.index;
                    const cart = JSON.parse(sessionStorage.getItem('cart'));
                    // Remove item from cart array and update session storage
                    cart.splice(index, 1);
                    sessionStorage.setItem('cart', JSON.stringify(cart));
                    // Render the updated cart items
                    renderCartItems();
                });
            });

            // Add event listeners for quantity input fields
            const quantityInputs = document.querySelectorAll('.item-quantity');
            quantityInputs.forEach((input) => {
                input.addEventListener('change', () => {
                    // Get index of item to update from its row index
                    const index = input.closest('tr').rowIndex - 1;
                    const cart = JSON.parse(sessionStorage.getItem('cart'));
                    // Update item quantity in cart array and update session storage
                    cart[index].quantity = input.value;
                    sessionStorage.setItem('cart', JSON.stringify(cart));
                    // Render the updated cart items
                    renderCartItems();
                });
            });
        };

        // Render the cart items when the page loads
        renderCartItems();

        // Add event listener for add to cart button
        const addToCartButton = document.querySelector('.btn');
        addToCartButton.addEventListener('click', () => {
            // Ambil data produk yang ingin ditambahkan ke keranjang
            const productName = document.getElementById('namaMakanan').textContent;
            const productPrice = document.querySelector('h4').textContent;
            const categname = document.getElementById('categName').textContent;

            console.log('productName:', productName);
            console.log('productPrice:', productPrice);
            console.log('categname:', categname);

            // Buat objek produk baru
            const product = { name: productName, price: productPrice, category: categname };

            // Cek apakah keranjang belanja sudah ada di session storage
            let cart = sessionStorage.getItem('cart');
            if (cart === null) {
                // Jika belum ada, buat keranjang baru
                cart = [];
            } else {
                // Jika sudah ada, parsing isi keranjang menjadi array
                cart = JSON.parse(cart);
            }

            // Cek apakah produk sudah ada di dalam keranjang
            const existingProductIndex = cart.findIndex(item => item.name === productName);
            console.log('existingProductIndex:', existingProductIndex);
            console.log('cart:', cart);
            if (existingProductIndex > -1) {
                // Jika produk sudah ada, tambahkan kuantitasnya
                cart[existingProductIndex].quantity += 1;
            } else {
                // Jika belum ada, tambahkan produk ke dalam keranjang
                cart.push({ ...product, quantity: 1 });
            }

            // Simpan kembali isi keranjang belanja ke session storage
            sessionStorage.setItem('cart', JSON.stringify(cart));
            renderCartItems();
        });
</script>
</body>
</html>
