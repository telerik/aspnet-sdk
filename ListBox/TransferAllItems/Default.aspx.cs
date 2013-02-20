using System;
using System.Linq;
using Telerik.Web.UI;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Init(object sender, EventArgs e)
    {
        // add large number of items to RadListBox

        for (int i = 0; i < 40; i++)
        {
            var item = new RadListBoxItem(i.ToString());
            RadListBox1.Items.Add(item);
        }
        
    }
}