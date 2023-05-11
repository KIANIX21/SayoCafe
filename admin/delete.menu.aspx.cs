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

                                // Convert image from blob to string
                                byte[] bytes = (byte[])reader["image"];
                                string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
                                txtMenuImage.Text = base64String;
                            }
                            else
                            {
                                Response.Redirect("menu.aspx");
                            }
                        }
                    }
                }
            }
        }
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            // Get the menucode from query string
            string menuCode = Request.QueryString["menucode"];

            // Show confirmation dialog before deleting the menu data
            string confirmValue = Request.Form["confirm_value"];
            if (confirmValue == "Yes")
            {
                // Delete the menu data from database
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
                            Response.Redirect("menu.aspx");
                        }
                        else
                        {
                            lblStatus.Text = "Delete failed";
                        }
                    }
                }
            }
            else
            {
                // Show confirmation dialog
                ScriptManager.RegisterStartupScript(this, this.GetType(), "confirm", "if(confirm('Are you sure you want to delete this menu?')){document.getElementById('" + confirmDelete.ClientID + "').click();}", true);
            }
        }
    }
}