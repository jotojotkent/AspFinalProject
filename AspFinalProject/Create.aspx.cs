using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AspFinalProject
{
    public partial class Create : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void bttnCreate_Click(object sender, EventArgs e)
        {
            
            if (txtCPass.Text == txtConfirm.Text) { 

                Response.Redirect("Login.aspx");
                lblValidation.Text = "Account Successfully created!";
            }
            else
            {
                lblValidation.Text = "Invalid, Passwords don't match!";
            }
        }
        protected void login_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
}