﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="menudetail.aspx.cs" Inherits="SayoCafe.menudetail" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../css/Style.css">
    <link rel="stylesheet" href="../css/detail.menu.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" integrity="sha512-+4zCK9k+qNFUR5X+cKL9EIR+ZOhtIloNl9GIKS57V1MyNsYpYcUrUeQc9vNfzsWfV28IaLL3i96P9sdNyeRssA==" crossorigin="anonymous" />
    <title>Deskripsi Produk</title>
    <!-- Feather Icons-->
    <script src="https://unpkg.com/feather-icons"></script>
    <style>
        input[type=number] {
  width: 40px;
  height: 40px;
}

    </style>
</head>
<body>
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
        <%
            string id = Request.QueryString["id"];
            string connectionString = "server=localhost;database=db_sayocafe;uid=root;pwd=;";
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                string query = "SELECT menu.menuname, menu.menuprice, menu.menusubtitle, menu.image, category.categname FROM menu JOIN category on category.categcode = menu.categcode WHERE menucode = @id";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@id", id);

                conn.Open();
                MySqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    string namaMakanan = reader["menuname"].ToString();
                    decimal hargaMakanan = (decimal)reader["menuprice"];
                    string deskripsiMakanan = reader["menusubtitle"].ToString();
                    string categname = reader["categname"].ToString();
                    byte[] imageData = (byte[])reader["image"];
                    string base64String = Convert.ToBase64String(imageData, 0, imageData.Length);
                    string imageUrl = "data:image/png;base64," + base64String;

        %>

<div class="small-container single-product">
    <div class="row">
        <div class="col-2">
            <img src="<%= imageUrl %>" alt="" width="80%" id="product-img">
        </div>
        <div class="col-2">
            <p>Menu - <%= namaMakanan %></p>
            <p id="categName"><%= categname %></p>
            <h1 id="namaMakanan"><%= namaMakanan %></h1>
            <h4 id="hargaMakanan">IDR <%= hargaMakanan.ToString("N0") %></h4>
            <input type="number" id="quantity" value="1">
            <br>
            <button id="btnAdd" class="btn">Add To Cart</button>
            <h3>Deskripsi Menu</h3>
            <br>
            <p><%= deskripsiMakanan %></p>
        </div>
    </div>
</div>
<%
        }
    reader.Close();
    conn.Close();
} 
%>

        <!-- Footer -->
    <footer>
        <div class="social">
            <a href="#"><i data-feather="facebook"></i></a>
            <a href="#"><i data-feather="instagram"></i></a>
            <a href="#"><i data-feather="twitter"></i></a>
        </div>

        <div class="links">
            <a href="#home">Home</a>
            <a href="#menu">Menu</a>
            <a href="#contact">Kontak</a>
            <a href="#about">Tentang Kami</a>
        </div>

        <div class="credit">
            <p>Created by Group 2 | &copy; 2023</p>
        </div>
    </footer>
              <script>
                feather.replace()
              </script>
    <script src="js/script.js"></script>
<script>
    btnAdd.addEventListener('click', () => {
        // Ambil data produk yang ingin ditambahkan ke keranjang
        const productName = document.getElementById('namaMakanan').textContent;
        const productPriceElement = document.getElementById('hargaMakanan');
        const productPrice = parseFloat(productPriceElement.textContent.replace('IDR ', '').replace('.', ''));
        const categoryElement = document.getElementById('categName');
        const categoryName = categoryElement.textContent;
        let quantity = parseFloat(document.getElementById('quantity').value) || 1; // Ambil nilai quantity, defaultnya 1 jika tidak ada input quantity dari pengguna

        // Hitung total harga
        let totalPrice = productPrice * quantity;

        // Buat objek item cart
        const itemCart = {
            menuName: productName,
            categoryName: categoryName,
            price: productPrice,
            quantity: quantity,
            totalPrice: totalPrice
        };

        // Simpan objek item cart ke dalam array "cart"
        let cart = JSON.parse(localStorage.getItem('cart')) || [];

        // Cek apakah item sudah ada di cart
        let itemAlreadyInCart = false;
        for (let i = 0; i < cart.length; i++) {
            if (cart[i].menuName === itemCart.menuName && cart[i].categoryName === itemCart.categoryName) {
                cart[i].quantity += itemCart.quantity;
                cart[i].totalPrice += itemCart.totalPrice;
                itemAlreadyInCart = true;
                break;
            }
        }

        // Jika item belum ada di cart, maka tambahkan item ke cart
        if (!itemAlreadyInCart) {
            cart.push(itemCart);
        }

        localStorage.setItem('cart', JSON.stringify(cart));
        alert(`Menu ${productName} berhasil ditambahkan ke keranjang`);
    });
</script>

</body>
</html>
