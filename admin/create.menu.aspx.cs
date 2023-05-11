using MySql.Data.MySqlClient;
using System;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SayoCafe.admin
{
    public partial class create_menu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Get admin code from session
            string Admincode = (string)Session["admincode"];
            if (Admincode == null)
            {
                Response.Redirect("~/login.aspx");
            }
            else
            {
                // Show admin code in textbox
                admincode.Text = Admincode;
            }
        }


        protected void btnCreate_Click(object sender, EventArgs e)
        {
            string connString = "Server=localhost;Database=db_sayocafe;Uid=root;Pwd=;";
            using (MySqlConnection connection = new MySqlConnection(connString))
            {
                connection.Open();
                string query = "INSERT INTO menu (menuname, categcode, menuprice, menustock, menusubtitle, admincode, image) VALUES (@menuName, @categoryCode, @price, @stock, @description, @adminCode, @image)";
                using (MySqlCommand command = new MySqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@menuName", txtName.Text);
                    command.Parameters.AddWithValue("@categoryCode", txtCateg.Text);
                    command.Parameters.AddWithValue("@price", Convert.ToDecimal(txtPrice.Text));
                    command.Parameters.AddWithValue("@stock", Convert.ToInt32(txtStock.Text));
                    command.Parameters.AddWithValue("@description", txtDeskripsi.Text);
                    command.Parameters.AddWithValue("@adminCode", Session["admincode"].ToString());

                    // Upload the image file
                    if (imageUpload.HasFile)
                    {
                        string fileName = Path.GetFileName(imageUpload.PostedFile.FileName);
                        string fileExtension = Path.GetExtension(fileName).ToLower();
                        if (fileExtension == ".jpg" || fileExtension == ".jpeg" || fileExtension == ".png")
                        {
                            string filePath = Server.MapPath("~/menu/" + fileName);
                            imageUpload.SaveAs(filePath);

                            // Read the uploaded image into a byte array
                            byte[] imageData = File.ReadAllBytes(filePath);

                            // Add the byte array as the value of the @image parameter
                            command.Parameters.Add("@image", MySqlDbType.Blob, imageData.Length).Value = imageData;
                        }
                    }

                    int rowsAffected = command.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        Response.Redirect("menu.aspx");
                    }
                    else
                    {
                        Response.Write("Error: Failed to add new menu item.");
                    }
                }
            }
        }
    }
}
