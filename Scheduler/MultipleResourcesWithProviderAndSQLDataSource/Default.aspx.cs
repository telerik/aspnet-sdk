using System;
using System.Web.UI;
using System.Drawing;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Configuration;
using System.Data.Common;

public partial class RadSchedulerAdvancedForm : System.Web.UI.Page 
{

    protected void Page_Init(object sender, EventArgs e)
    {
        var connString = ConfigurationManager.ConnectionStrings["TelerikVSXConnectionString"].ConnectionString;
        var factory = DbProviderFactories.GetFactory("System.Data.SqlClient");
        RadScheduler1.Provider = new SchedulerDBProvider() { ConnectionString = connString, DbFactory = factory, PersistChanges = true };

       
    }

}
