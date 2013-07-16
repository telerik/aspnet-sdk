using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using OrderCart;

public partial class RadGridWithObjectDataSource : System.Web.UI.Page
{
	protected void Page_Load(object sender, EventArgs e)
	{
	}

	protected void ObjectDataSource1_Selected(object sender, ObjectDataSourceStatusEventArgs e)
	{
		List<Customer> customers = e.ReturnValue as List<Customer>;
		RadGrid1.MasterTableView.VirtualItemCount = customers.Count;
	}
}