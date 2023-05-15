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
            if (!IsPostBack)
            {
                if (Session["admincode"] != null)
                {
                    string adminCode = Session["admincode"].ToString();
                    string connString = "server=localhost;user=root;database=db_sayocafe;password=;";
                    MySqlConnection conn = new MySqlConnection(connString);
                    try
                    {
                        conn.Open();
                        MySqlCommand cmd = new MySqlCommand("SELECT adminname FROM admin WHERE admincode=@admincode", conn);
                        cmd.Parameters.AddWithValue("@admincode", adminCode);
                        string adminName = cmd.ExecuteScalar().ToString();
                        conn.Close();
                        admincode.Text = adminCode;
                        lblAdminName.Text = adminName;
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Database error: " + ex.Message + "');", true);
                        conn.Close();
                    }
                }
                else
                {
                    Response.Redirect("~/login.aspx");
                }
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
                        // Redirect to the show.aspx page with a success message
                        Response.Redirect("menu.aspx?create=success");
                    }
                    else
                    {
                        // Redirect to the show.aspx page with an error message
                        Response.Redirect("menu.aspx?create=error");
                    }
                }
            }
        }
    }
}
