<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="menu.aspx.cs" Inherits="SayoCafe.admin.menu" %>

<%@ Import Namespace="MySql.Data.MySqlClient" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Dashboard - SB Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link href="css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">
    <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
        <!-- Navbar Brand-->
        <a class="navbar-brand ps-3" href="#">Sayo Cafe</a>
        <!-- Sidebar Toggle-->
        <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
        <!-- Navbar Search-->
        <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
        </form>
        <!-- Navbar-->
        <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                    <li>
                        <hr class="dropdown-divider" />
                    </li>
                    <li><a class="dropdown-item" href="../login.aspx">Logout</a></li>
                </ul>
            </li>
        </ul>
    </nav>
    <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">Core</div>
                            <a class="nav-link" href="kategori.aspx">
                                <div class="sb-nav-link-icon"><i class="bi bi-list"></i></div>
                                Kategori
                            </a>
                            <a class="nav-link" href="menu.aspx">
                                <div class="sb-nav-link-icon"><i class="bi bi-menu-button"></i></div>
                                Menu
                            </a>
                           <a class="nav-link" href="Transaction.aspx">
                                <div class="sb-nav-link-icon"><i class="bi bi-menu-button"></i></div>
                                Transaction
                            </a>
                        </div>
                    </div>
<div class="sb-sidenav-footer">
    <div class="small">Logged in as:</div>
    <asp:Label ID="lblAdminName" runat="server"></asp:Label>
</div>
                </nav>
            </div>
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <h1 class="mt-4">Menu</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item active">Menu</li>
                    </ol>
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-table me-1"></i>
                            Data Menu
                        </div>
                        <div class="card-body">
                            <table id="datatablesSimple">
                                <thead>
                                    <tr>
                                        <th>Menu Kode</th>
                                        <th>Admin Kode</th>
                                        <th>Nama Menu</th>
                                        <th>Kategori</th>
                                        <th>Harga</th>
                                        <th>Stock</th>
                                        <th>Deskripsi Menu</th>
                                        <th>Image</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                        //koneksi ke database MySQL
                                        string connString = "Server=localhost;Database=db_sayocafe;Uid=root;Pwd=;";
                                        using (MySqlConnection conn = new MySqlConnection(connString))
                                        {
                                            //query untuk membaca data dari tabel menu
                                            string query = "SELECT * FROM menu";
                                            MySqlCommand cmd = new MySqlCommand(query, conn);

                                            //membuka koneksi dan membaca data menggunakan MySqlDataReader
                                            conn.Open();
                                            MySqlDataReader reader = cmd.ExecuteReader();

                                            // Loop through the results and add them to the table
                                            while (reader.Read())
                                            {
                                                string menuCode = reader["menucode"].ToString();
                                                string adminCode = reader["admincode"].ToString();
                                                string menuName = reader["menuname"].ToString();
                                                string categCode = reader["categcode"].ToString();
                                                string menuPrice = ((decimal)reader["menuprice"]).ToString("N0");
                                                int menuStock = reader.GetInt32("menustock");
                                                string menuSubtitle = reader["menusubtitle"].ToString();
                                                byte[] imageBytes = (byte[])reader["image"];
                                                string imageBase64String = Convert.ToBase64String(imageBytes);
                                    %>
                                    <tr>
                                        <td><%= menuCode %></td>
                                        <td><%= adminCode %></td>
                                        <td><%= menuName %></td>
                                        <td><%= categCode %></td>
                                        <td><%= menuPrice %></td>
                                        <td><%= menuStock %></td>
                                        <td><%= menuSubtitle %></td>
                                        <td>
                                            <img src="data:image/jpeg;base64,<%=imageBase64String %>" /></td>
                                        <td>
                                            <a href="update.menu.aspx?menucode=<%= menuCode %>"><i class="fas fa-edit"></i></a>
                                            <a href="delete.menu.aspx?menucode=<%= menuCode %>"><i class="fas fa-trash" style="padding-left: 2px;"></i></a>
                                        </td>
                                    </tr>
                                    <% 
                                            }

                                            // Close the database connection
                                            reader.Close();
                                        }
                                    %>
                                </tbody>
                            </table>

                            <div style="text-align: right;" class="mb-4">
                                <a href="create.menu.aspx">
                                    <button class="btn btn-primary">Tambah Menu</button></a>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
            <footer class="py-4 bg-light mt-auto">
                <div class="container-fluid px-4">
                    <div class="d-flex align-items-center justify-content-between small">
                        <div class="text-muted">Copyright &copy; Your Website 2023</div>
                        <div>
                            <a href="#">Privacy Policy</a>
                            &middot;
                                <a href="#">Terms &amp; Conditions</a>
                        </div>
                    </div>
                </div>
            </footer>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="js/scripts.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
    <script src="assets/demo/chart-area-demo.js"></script>
    <script src="assets/demo/chart-bar-demo.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
    <script src="js/datatables-simple-demo.js"></script>am
</body>
</html>
