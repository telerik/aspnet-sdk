using System;
using System.Linq;
using NorthwindDAL;
using Telerik.Web.UI;

public partial class RadGridWithManualCRUD : System.Web.UI.Page
{
	//Indicates whether the Grid has a filter or group expression applied.
	public bool ShouldApplySortFilterOrGroup
	{
		get
		{
			return RadGrid1.MasterTableView.FilterExpression != "" ||
				   (RadGrid1.MasterTableView.GroupByExpressions.Count > 0 || isGrouping) ||
				   RadGrid1.MasterTableView.SortExpressions.Count > 0;
		}
	}

	//Indicates whether the group has been destroyed.
	bool isGrouping = false;

	protected void RadGrid1_GroupsChanging(object source, GridGroupsChangingEventArgs e)
	{
		isGrouping = true;
		if (e.Action == GridGroupsChangingAction.Ungroup && RadGrid1.CurrentPageIndex > 0)
		{
			isGrouping = false;
		}
	}

	protected void RadGrid1_UpdateCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
	{
		GridEditFormItem item = (GridEditFormItem)e.Item;
		//Instantiate the context.
		using (NorthwindEntities context = new NorthwindEntities())
		{
			//Get the primary key value using the DataKeyValue.       
			int orderID = int.Parse(item.OwnerTableView.DataKeyValues[item.ItemIndex][RadGrid1.MasterTableView.DataKeyNames[0]].ToString());
			//Query the model for the element that should be updated.
			Order orderToUpdate = (from order in context.Orders
								   where order.OrderID == orderID
								   select order).FirstOrDefault();
			//Update the element.
			item.UpdateValues(orderToUpdate);
			//Submit the changes back to the context.
			context.SaveChanges();
		}
	}

	protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
	{
		GridDataItem item = (GridDataItem)e.Item;
		//Instantiate the context.
		using (NorthwindEntities context = new NorthwindEntities())
		{
			//Get the primary key value using the DataKeyValue.       
			int orderID = int.Parse(item.OwnerTableView.DataKeyValues[item.ItemIndex][RadGrid1.MasterTableView.DataKeyNames[0]].ToString());
			//Query the model for the element that should be deleted.
			Order orderToDelete = (from order in context.Orders
								   where order.OrderID == orderID
								   select order).FirstOrDefault();
			//Delete the element.
			context.Orders.DeleteObject(orderToDelete);
			//Submit the changes back to the context.
			context.SaveChanges();
		}
	}

	protected void RadGrid1_InsertCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
	{
		GridEditFormItem item = (GridEditFormItem)e.Item;
		//Instantiate the context.
		using (NorthwindEntities context = new NorthwindEntities())
		{
			//Create the empty element that should be inserted.
			Order orderToAdd = new Order();
			int lastOrderID = context.Orders.ToList().Last().OrderID;
			//Apply the vlaues from the editor controls.
			item.UpdateValues(orderToAdd);
			//Increment the PK field.
			orderToAdd.OrderID = ++lastOrderID;
			//Add the element.
			context.Orders.AddObject(orderToAdd);
			//Submit the changes back to the context.
			context.SaveChanges();
		}
	}

	protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
	{
		//Instantiate the context.
		using (NorthwindEntities context = new NorthwindEntities())
		{
			//Set the maximum amount of items the Grid will display.
			RadGrid1.VirtualItemCount = context.Orders.Count();
			//Query the model for the items for the current page.
			var ordersToBind = (from order in context.Orders
								orderby order.OrderID
								select order).Skip(RadGrid1.PageSize * RadGrid1.CurrentPageIndex).Take(RadGrid1.PageSize);
			//Set the datasource to the Grid instance.
			RadGrid1.DataSource = ordersToBind;
		}
	}
}