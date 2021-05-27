using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HelloRadHtmlChart : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            RadHtmlChart1.DataSource = GetData();
        }
    }

    private DataTable GetData()
    {
        DataTable dt = new DataTable();

        dt.Columns.Add("labels");
        dt.Columns.Add("values");
        dt.Columns.Add("colors");
        dt.Columns.Add("description");

        dt.Rows.Add("Week 1", 3, "#99C794", " 1 blouse and 2 trousers");
        dt.Rows.Add("Week 2", 10, "#5FB3B3", "7 blouses and 3 skirts");
        dt.Rows.Add("Week 3", 7, "#FAC863", "7 skirts");
        dt.Rows.Add("Week 4", 12, "#6699CC", "5 blouses, 5 trousers and 2 skirts");
        return dt;
    }
}