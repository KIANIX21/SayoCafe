using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using MySql.Data.MySqlClient;

namespace SayoCafe.admin
{
    public partial class update_menu : System.Web.UI.Page
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

        protected void btnUpdate_Click(object sender, EventArgs e)
        {

            // Get the menucode from query string
            string menuCode = Request.QueryString["menucode"];

            // Update the menu data in database
            string connString = "Server=localhost;Database=db_sayocafe;Uid=root;Pwd=;";
            using (MySqlConnection connection = new MySqlConnection(connString))
            {
                connection.Open();
                string query = "UPDATE menu SET menuname = @menuName, categcode = @categoryCode, menuprice = @price, menustock = @stock, menusubtitle = @description WHERE menucode = @menucode";
                using (MySqlCommand command = new MySqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@menuName", txtMenuName.Text);
                    command.Parameters.AddWithValue("@categoryCode", txtCategoryCode.Text);
                    command.Parameters.AddWithValue("@price", txtPrice.Text);
                    command.Parameters.AddWithValue("@stock", txtStock.Text);
                    command.Parameters.AddWithValue("@description", txtDescription.Text);
                    command.Parameters.AddWithValue("@menucode", menuCode);
                    int rowsAffected = command.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        Response.Redirect("menu.aspx?update=success");
                    }
                    else
                    {
                        Response.Redirect("menu.aspx?update=error");
                    }
                }
            }
        }
    }
}
