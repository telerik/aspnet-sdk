using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Configuration;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Telerik.Web.UI;
using System.Collections;
using System.Linq;


public partial class Default : System.Web.UI.Page 
{
    public DataTable SessionDataSource
    {
        get
        {
            string sessionKey = "SessionDataSource";

            if (Session[sessionKey] == null || !IsPostBack)
            {

                DataTable dt = new DataTable();

                dt.Columns.Add(new DataColumn("OrderID", typeof(int)));              
                dt.Columns.Add(new DataColumn("OrderDate", typeof(DateTime)));
                dt.Columns.Add(new DataColumn("Freight", typeof(decimal)));
                dt.Columns.Add(new DataColumn("ShipName", typeof(string)));
                dt.Columns.Add(new DataColumn("ShipCountry", typeof(string)));
                dt.Columns.Add(new DataColumn("OrderNumbers", typeof(int)));
                dt.Columns.Add(new DataColumn("Price", typeof(int)));
                dt.Columns.Add(new DataColumn("TotalPrice", typeof(int)));

                dt.PrimaryKey = new DataColumn[] { dt.Columns["OrderID"] };

                for (int i = 0; i < 3; i++)
                {
                    int index = i + 1;

                    DataRow row = dt.NewRow();

                    row["OrderID"] = index;
                    row["OrderDate"] = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, 0, 0, 0).AddHours(index);
                    row["Freight"] = index * 0.1 + index * 0.01;
                    row["ShipName"] = "Name " + index;
                    row["ShipCountry"] = "Country " + index;
                    row["OrderNumbers"] = index +index;
                    row["Price"] = index * 2;

                    dt.Rows.Add(row);
                }

                Session[sessionKey] = dt;
            }
            return (DataTable)Session[sessionKey];
        }
    }


    protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        RadGrid1.DataSource = SessionDataSource;
    }

    // https://docs.telerik.com/devtools/aspnet-ajax/controls/grid/data-editing/edit-mode/batch-editing/server-side-api
    protected void RadGrid1_BatchEditCommand(object sender, GridBatchEditingEventArgs e)
    {
        foreach (GridBatchEditingCommand command in e.Commands)
        {
            Hashtable newValues = command.NewValues;
            Hashtable oldValues = command.OldValues;

            DataRow editedRow = newValues["OrderID"] != null ?
                SessionDataSource.Select(string.Format("OrderID = '{0}'", newValues["OrderID"].ToString())).FirstOrDefault() :
                SessionDataSource.NewRow();

            switch (command.Type)
            {
                case GridBatchEditingCommandType.Insert:
                    DataRow lastOrder = SessionDataSource.Select("OrderID = MAX(OrderID)").FirstOrDefault();

                    int OrderID = 1;

                    if (lastOrder != null)
                    {
                        OrderID = Convert.ToInt32(lastOrder["OrderID"]) + 1;
                    }

                    editedRow["OrderID"] = OrderID;

                    foreach (string key in command.NewValues.Keys)
                    {
                        editedRow[key] = newValues[key];
                    }

                    SessionDataSource.Rows.Add(editedRow);

                    break;
                case GridBatchEditingCommandType.Update:
                    foreach (string key in command.NewValues.Keys)
                    {
                        if (newValues[key] != oldValues[key]) //You may want to implement stronger difference checks here, or a check for the command name (e.g., when inserting there is little point in looking up old values
                        {
                            editedRow[key] = newValues[key];
                        }
                    }
                    break;
                case GridBatchEditingCommandType.Delete:
                    editedRow.Delete();
                    break;
                default:
                    break;
            }
        }
    }
}
