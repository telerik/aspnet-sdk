using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
public partial class _Default : System.Web.UI.Page
{
   
    protected void Button2_Click(object sender, EventArgs e)
    {
        string data = "<h4>Registeration submitted successfully:</h4>"
                + "Your Name: <b>" + RadTextBox1.Text + "</b><br />"
                + "Number of Rooms: <b>" + RadTextBox2.Text + "</b><br />"
                + "Check-in Date: <b>" + RadTextBox3.Text + "</b><br />"
                + "Check-out Time: <b>" + RadTextBox4.Text + "</b><br />"
                 + "Phone number: <b>" + RadTextBox6.Text + "</b><br />"
                  + "E-mail: <b>" + RadTextBox5.Text + "</b><br />";
        divPreviewResults.Controls.Add(new LiteralControl(data));
    }
   
}

   

