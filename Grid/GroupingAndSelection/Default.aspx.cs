using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Telerik.Web.UI;
using System.Text.RegularExpressions;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public DataTable GetDataTable(string query)
    {
        String ConnString = ConfigurationManager.ConnectionStrings["NorthwindConnectionString"].ConnectionString;
        SqlConnection conn = new SqlConnection(ConnString);
        SqlDataAdapter adapter = new SqlDataAdapter();
        adapter.SelectCommand = new SqlCommand(query, conn);

        DataTable myDataTable = new DataTable();

        conn.Open();
        try
        {
            adapter.Fill(myDataTable);
        }
        finally
        {
            conn.Close();
        }

        return myDataTable;
    }
    public static int firstPageIndex;
    
    protected void RadGrid1_NeedDataSource(object source, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid1.DataSource = GetDataTable("SELECT * FROM Orders");
    }

}
