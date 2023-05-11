using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SayoCafe
{
    public partial class login : System.Web.UI.Page
    {
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string name = txtname.Text;
            string password = txtPassword.Text;

            // Set connection string to your MySQL database
            string connString = "server=localhost;user=root;database=db_sayocafe;password=;";
            MySqlConnection conn = new MySqlConnection(connString);

            try
            {
                // Open database connection
                conn.Open();

                MySqlCommand cmd = new MySqlCommand("SELECT admincode FROM admin WHERE adminname=@adminname AND adminpassword=@adminpassword", conn);
                cmd.Parameters.AddWithValue("@adminname", name);
                cmd.Parameters.AddWithValue("@adminpassword", password);


                MySqlDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    reader.Read();
                    string admincode = reader.GetString(0);
                    reader.Close();
                    conn.Close();
                    // Save admin code to session
                    Session["admincode"] = admincode;
                    Response.Redirect("~/admin/menu.aspx?code=" + admincode);
                }
                else
                {
                    // Show error message
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Email atau password salah!');", true);
                    reader.Close();
                    conn.Close();
                }
            }
            catch (Exception ex)
            {
                // Handle database connection error
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Database error: " + ex.Message + "');", true);
                conn.Close();
            }
        }
    }
}
