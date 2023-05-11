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
            string connectionString = "server=namaServer;database=namaDatabase;uid=username;pwd=password";
            MySqlConnection connection = new MySqlConnection(connectionString);
        }
    }
}