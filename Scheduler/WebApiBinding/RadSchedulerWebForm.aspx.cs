using System;
using System.Web.UI;
using Telerik.Web.UI;

public partial class RadSchedulerWebForm : System.Web.UI.Page
{
    protected void Button1_Click(object sender, System.EventArgs e)
    {
        RadButton button = (RadButton)sender;
        if (button.Text == "Group")
        {
            RadScheduler1.GroupBy = "Calendar";
            RadScheduler1.Resources.Clear();
            button.Text = "Ungroup";
            button.Icon.PrimaryIconCssClass = "qsf-btn-ungroup";
        }
        else
        {
            RadScheduler1.GroupBy = "";
            RadScheduler1.Resources.Clear();
            button.Text = "Group";
            button.Icon.PrimaryIconCssClass = "qsf-btn-group";
        }

    }
 
}
