using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace SayoCafe.admin
{
    public partial class menu : System.Web.UI.Page
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
                    Response.Redirect("~/admin/login.aspx");
                }
            }
        }
    }
}
