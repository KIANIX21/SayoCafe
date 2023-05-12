using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace SayoCafe
{
    public partial class cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Membuat koneksi ke database MySQL
                string connectionString = "server=localhost;database=db_sayocafe;uid=root;pwd=";
                MySqlConnection connection = new MySqlConnection(connectionString);
                try
                {
                    // Membuka koneksi ke database
                    connection.Open();

                    // Membuat perintah SQL untuk mengambil transcode terakhir
                    string query = "SELECT * FROM transactionheader ORDER BY transcode DESC LIMIT 1";
                    MySqlCommand command = new MySqlCommand(query, connection);

                    // Mengeksekusi perintah SQL dan mengambil hasilnya
                    MySqlDataReader reader = command.ExecuteReader();

                    // Menampilkan hasil query pada input field
                    if (reader.Read())
                    {
                        namaPelangganInput.Text = reader.GetString("custname");
                        nomorMejaInput.Text = reader.GetString("numbertable");
                        noHpInput.Text = reader.GetString("custphonenum");
                        transcodeLabel.Text = reader.GetString("transcode");
                    }

                    // Menutup koneksi ke database
                    reader.Close();
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
}