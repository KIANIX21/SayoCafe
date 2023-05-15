using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace SayoCafe
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void KonfirmasiPemesanan_Click(object sender, EventArgs e)
        {
            // Mendapatkan nilai dari input form
            string namaPelanggan = nama_pelanggan.Value;
            string nomorMeja = nomor_meja.Value;
            string noHp = no_hp.Value;

            // Membuat koneksi ke database MySQL
            string connectionString = "server=localhost;database=db_sayocafe;uid=root;pwd=";
            MySqlConnection connection = new MySqlConnection(connectionString);

            try
            {
                // Membuka koneksi ke database
                connection.Open();

                // Membuat perintah SQL untuk menyimpan data pelanggan
                string query = "INSERT INTO transactionheader (custname, numbertable, custphonenum) VALUES (@namaPelanggan, @nomorMeja, @noHp)";
                MySqlCommand command = new MySqlCommand(query, connection);

                // Menambahkan parameter ke perintah SQL
                command.Parameters.AddWithValue("@namaPelanggan", namaPelanggan);
                command.Parameters.AddWithValue("@nomorMeja", nomorMeja);
                command.Parameters.AddWithValue("@noHp", noHp);

                // Menjalankan perintah SQL untuk menyimpan data pelanggan
                command.ExecuteNonQuery();

                // Mendapatkan nilai transcode yang baru ditambahkan
                query = "SELECT transcode FROM transactionheader ORDER BY transcode DESC LIMIT 1";
                command = new MySqlCommand(query, connection);
                MySqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    reader.Read();
                    string transcode = reader.GetString(0);
                    reader.Close();

                    // Menyimpan nilai transcode pada session
                    Session["transcode"] = transcode;

                    // Menampilkan pesan sukses
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Pesanan berhasil disimpan!');", true);

                    // Redirect ke halaman menu
                    Response.Redirect("menu.aspx?code=" + transcode);
                }
                else
                {
                    // Menampilkan pesan error
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Terjadi kesalahan: tidak bisa mendapatkan kode transaksi');", true);
                }
            }
            catch (Exception ex)
            {
                // Menampilkan pesan error
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Terjadi kesalahan: " + ex.Message + "');", true);
            }
            finally
            {
                // Menutup koneksi ke database
                connection.Close();
            }
        }
    }
}