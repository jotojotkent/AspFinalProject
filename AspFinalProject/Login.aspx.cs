using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AspFinalProject
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void bttnLogin_Click(object sender, EventArgs e)
        {
            string userName = txtUName.Text.Trim();
            string passWord = txtPWord.Text;
            if (userName == "Kent" && passWord == "kentz123")
            {
                Response.Redirect("Dashboard.aspx");
            }
            else
            {
                lblMess.Text = "Invalid Username or Password";
            }
        }
        protected void createAccount_Click(object sender, EventArgs e)
        {
            Response.Redirect("Create.aspx");
        }
    }
}