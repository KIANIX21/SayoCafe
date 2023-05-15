using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace SayoCafe.admin
{
    public partial class delete_menu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Get the menucode from query string
                string menuCode = Request.QueryString["menucode"];
                // Retrieve the menu data from database
                string connString = "Server=localhost;Database=db_sayocafe;Uid=root;Pwd=;";
                using (MySqlConnection connection = new MySqlConnection(connString))
                {
                    connection.Open();
                    string query = "SELECT * FROM menu WHERE menucode = @menucode";
                    using (MySqlCommand command = new MySqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@menucode", menuCode);
                        using (MySqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                txtMenuName.Text = reader["menuname"].ToString();
                                txtCategoryCode.Text = reader["categcode"].ToString();
                                txtPrice.Text = reader["menuprice"].ToString();
                                txtStock.Text = reader["menustock"].ToString();
                                txtDescription.Text = reader["menusubtitle"].ToString();

                                // Get image as Base64 string
                                byte[] bytes = (byte[])reader["image"];
                                string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);

                                // Set Base64 string to variable
                                string imageBase64String = "data:image/jpeg;base64," + base64String;
                                imgMenu.ImageUrl = imageBase64String;
                            }
                            else
                            {
                                Response.Redirect("menu.aspx");
                            }
                        }
                    }
                }

                // Get admin code from session
                string adminCode = (string)Session["admincode"];
                if (adminCode == null)
                {
                    Response.Redirect("~/login.aspx");
                }
                else
                {
                    // Retrieve admin name from database
                    string connString2 = "Server=localhost;Database=db_sayocafe;Uid=root;Pwd=;";
                    using (MySqlConnection connection2 = new MySqlConnection(connString2))
                    {
                        connection2.Open();
                        string query2 = "SELECT adminname FROM admin WHERE admincode = @admincode";
                        using (MySqlCommand command2 = new MySqlCommand(query2, connection2))
                        {
                            command2.Parameters.AddWithValue("@admincode", adminCode);
                            string adminName = (string)command2.ExecuteScalar();
                            lblAdminName.Text = adminName;
                        }
                    }
                }
            }
        }
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            // Get the menucode from query string
            string menuCode = Request.QueryString["menucode"];

            // Delete the menu data in database
            string connString = "Server=localhost;Database=db_sayocafe;Uid=root;Pwd=;";
            using (MySqlConnection connection = new MySqlConnection(connString))
            {
                connection.Open();
                string query = "DELETE FROM menu WHERE menucode = @menucode";
                using (MySqlCommand command = new MySqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@menucode", menuCode);
                    int rowsAffected = command.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        // Redirect to the show.aspx page with a success message
                        Response.Redirect("menu.aspx?delete=success");
                    }
                    else
                    {
                        // Redirect to the show.aspx page with an error message
                        Response.Redirect("menu.aspx?delete=error");
                    }
                }
            }
        }
    }
}