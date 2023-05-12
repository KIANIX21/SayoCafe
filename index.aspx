<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="SayoCafe.WebForm1" %>
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
        <a href="#" class="navbar-logo">Sayonara<span>Cafe</span>.</a>
    

    <div class="navbar-nav">
        <a href="#home">Home</a>   
        <a href="menu.aspx">Menu</a>
    </div>

    <div class="navbar-extra">
        <a href="cart.aspx" id="shopping-cart"><i data-feather="shopping-cart"></i></a>
        <a href="#" id="hamburger-menu"><i data-feather="menu"></i></a>
    </div>

    </nav>

    <!-- Hero Section -->
<section class="hero" id="home">
  <main class="content">
    <h1>Lengkapi Harimu Dengan Segelas <span>Kopi</span></h1>
    <p>Rasakan Keajaiban Kopi: Aroma Mewah, Rasa Memikat, Kenikmatan Sejati</p>
    <button id="open-modal" class="cta">Pesan Sekarang</button>
  </main>
</section>

<div id="modal" class="modal">
  <div class="modal-content">
    <span class="close">&times;</span>
      <div class="customer-info">
            <h2>Informasi Pelanggan</h2>
<form id="form1" runat="server">
    <div class="customer-field">
        <label for="nama-pelanggan">Nama Pelanggan:</label>
        <input type="text" id="nama_pelanggan" placeholder="Masukkan Nama Pelanggan" name="nama_pelanggan" runat="server">
    </div>
    <div class="customer-field">
        <label for="nomor-meja">Nomor Meja:</label>
        <input type="text" id="nomor_meja" placeholder="Masukkan Nomor Meja" name="nomor_meja" runat="server">
    </div>
    <div class="customer-field">
        <label for="no-hp">No. HP:</label>
        <input type="text" id="no_hp" placeholder="Masukkan No. HP" name="no_hp" runat="server">
    </div>
    <asp:Button ID="btnKonfirmasi" class="cta modal-btn" onclick="KonfirmasiPemesanan_Click" runat="server" Text="Konfirmasi Pemesanan" />
</form>

</div>
  </div>
    </div>
    <!-- Tentang Kami -->
    <section id="about" class="about">
        <h2>Tentang<span> Kami</span></h2>

        <div class="row">
            <div class="about-img">
                <img src="img/tentang-kami.jpg" alt="Tentang Kami">
            </div>
            <div class="content">
                <h3>Mengenai SayoCafe</h3>
                <p>Kelezatan dan Keistimewaan dalam Setiap Detik</p>
                <p>Kami di SayoCafe adalah para penyuka kopi yang berdedikasi untuk memberikan pengalaman tak terlupakan kepada para pengunjung kami.
                  Dengan hati yang penuh cinta, kami menyajikan kopi berkualitas tinggi dengan rasa
                    yang memukau dan inovasi yang menginspirasi.
                    Suasana hangat dan keramahan kami menciptakan lingkungan yang ramah, di mana setiap tamu dihargai dan merasa di rumah.
                    Dukungan kami pada petani kopi lokal adalah cermin dari komitmen kami untuk mendukung komunitas dan menciptakan dampak positif.
                    Kami bangga menjadi tempat di mana kreativitas mekar dan kenikmatan kopi mengalir.
                    Selamat datang di SayoCafe, di mana kelezatan dan kehangatan bertemu dalam harmoni yang sempurna.</p>
            </div>
        </div>
    </section>

    <!-- Menu Section -->
    <section id="menu" class="menu">
        <h2>Menu <span>Kami</span></h2>
        <p>Nikmati kelezatan SayoCafe dengan beberapa menu yang menggugah selera</p>

<div class="row">
   <% 
// buat koneksi ke database
string connectionString = "server=localhost;database=db_sayocafe;uid=root;pwd=;";
using (MySqlConnection conn = new MySqlConnection(connectionString))
{
    // buat query untuk mengambil data makanan
    string query = "SELECT menucode, menuname, menuprice, menusubtitle, image FROM menu LIMIT 4";
    MySqlCommand cmd = new MySqlCommand(query, conn);

    // buka koneksi dan jalankan query
    conn.Open();
    MySqlDataReader reader = cmd.ExecuteReader();

    // loop untuk membaca hasil query dan menambahkannya ke elemen HTML
    while (reader.Read())
    {
        string menucode = reader["menucode"].ToString();
        string namaMakanan = reader["menuname"].ToString();
        string hargaMakanan = ((decimal)reader["menuprice"]).ToString("N0");
        string deskripsiMakanan = reader["menusubtitle"].ToString();
        byte[] imageData = (byte[])reader["image"];
        string base64String = Convert.ToBase64String(imageData, 0, imageData.Length);
        string imageUrl = "data:image/png;base64," + base64String;
%>
<div class="col-lg-3 col-md-4 col-sm-6 mb-4">
    <div class="menu-card">
        <a href="menudetail.aspx?id=<%= menucode %>" data-id="<%= menucode %>"><img src="<%= imageUrl %>" alt="<%= namaMakanan %>" class="menu-card-img"></a>
        <h3 class="menu-card-title"><%= namaMakanan %></h3>
        <p class="menu-card-price">IDR <%= hargaMakanan %></p>
    </div>
</div>
<% 
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
            <a href="#">Home</a>
            <a href="#">Menu</a>
            <a href="#">Kontak</a>
            <a href="#">Tentang Kami</a>
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
