<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="menu.aspx.cs" Inherits="SayoCafe.menu" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SayoCafe</title>

    <!-- CSS -->
    <link rel="stylesheet" href="css/style.css">

    <!-- Fonts-->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,300;0,400;0,700;1,700&display=swap" rel="stylesheet">

    <!-- Feather Icons-->
    <script src="https://unpkg.com/feather-icons"></script>
</head>
<body>

 <!-- Navbar -->
 <nav class="navbar">
        <a href="index.aspx" class="navbar-logo">Sayonara<span>Cafe</span>.</a>

        <div class="navbar-extra">
            <a href="cart.aspx" id="shopping-cart"><i data-feather="shopping-cart"></i></a>
            <a href="#" id="hamburger-menu"><i data-feather="menu"></i></a>
        </div>

        </nav>


    <!-- Menu Section -->
    <section id="menu" class="menu">    
    <h2>Makanan <span>Kami.</span></h2>
       <div class="row">
    <% 
    // buat koneksi ke database
    string connectionString = "server=localhost;database=db_sayocafe;uid=root;pwd=;";
    using (MySqlConnection conn = new MySqlConnection(connectionString))
    {
        // buat query untuk mengambil data makanan
        string query = "SELECT menu.menucode, menu.menuname, menu.menuprice, menu.menusubtitle, menu.image, category.categname FROM menu JOIN category on category.categcode=menu.categcode WHERE category.categname LIKE 'Food'";
        MySqlCommand cmd = new MySqlCommand(query, conn);

        // buka koneksi dan jalankan query
        conn.Open();
        MySqlDataReader reader = cmd.ExecuteReader();

        // loop untuk membaca hasil query dan menambahkannya ke elemen HTML
        int count = 0;
        while (reader.Read())
        {
            string menucode = reader["menucode"].ToString();
            string namaMakanan = reader["menuname"].ToString();
            string categmakanan = reader["categname"].ToString();
            string hargaMakanan = ((decimal)reader["menuprice"]).ToString("N0");
            string deskripsiMakanan = reader["menusubtitle"].ToString();
            byte[] imageData = (byte[])reader["image"];
            string base64String = Convert.ToBase64String(imageData, 0, imageData.Length);
            string imageUrl = "data:image/png;base64," + base64String;
    %>
            <div class="col-4">
                <div class="menu-card">
                    <a href="menudetail.aspx?id=<%= menucode %>" data-id="<%= menucode %>"><img src="<%= imageUrl %>" alt="<%= namaMakanan %>" class="menu-card-img"></a>
                    <h3 class="menu-card-title"><%= namaMakanan %></h3>
                    <p class="menu-card-price">IDR <%= hargaMakanan %></p>
                </div>
            </div>
    <% 
            count++;
            if (count % 4 == 0) {
                %>
                </div>
                <div class="row">
                <% 
            }
        }

        // tutup koneksi dan reader
        reader.Close();
        conn.Close();
    }
    %>
</div>

        <h2>Minuman <span>Kami.</span></h2>
        <div class="row">
                <% 
    // buat koneksi ke database
    using (MySqlConnection conn = new MySqlConnection(connectionString))
    {
        // buat query untuk mengambil data makanan
        string query = "SELECT menu.menucode, menu.menuname, menu.menuprice, menu.menusubtitle, menu.image, category.categname FROM menu JOIN category on category.categcode=menu.categcode WHERE category.categname LIKE 'Drink'";
        MySqlCommand cmd = new MySqlCommand(query, conn);

        // buka koneksi dan jalankan query
        conn.Open();
        MySqlDataReader reader = cmd.ExecuteReader();

        // loop untuk membaca hasil query dan menambahkannya ke elemen HTML
        int count = 0;
        while (reader.Read())
        {
            string menucode = reader["menucode"].ToString();
            string namaMakanan = reader["menuname"].ToString();
            string categmakanan = reader["categname"].ToString();
            string hargaMakanan = ((decimal)reader["menuprice"]).ToString("N0");
            string deskripsiMakanan = reader["menusubtitle"].ToString();
            byte[] imageData = (byte[])reader["image"];
            string base64String = Convert.ToBase64String(imageData, 0, imageData.Length);
            string imageUrl = "data:image/png;base64," + base64String;
    %>
            <div class="col-4">
                <div class="menu-card">
                    <a href="menudetail.aspx?id=<%= menucode %>" data-id="<%= menucode %>">
                    <img src="<%= imageUrl %>" alt="<%= namaMakanan %>" class="menu-card-img"></a>
                    <h3 class="menu-card-title"><%= namaMakanan %></h3>
                    <p class="menu-card-price">IDR <%= hargaMakanan %></p>
                </div>
            </div>
    <% 
            count++;
            if (count % 4 == 0) {
                %>
                </div>
                <div class="row">
                <% 
            }
        }

        // tutup koneksi dan reader
        reader.Close();
        conn.Close();
    }
    %>
</div>
    </section>
    

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
</body>
</html>