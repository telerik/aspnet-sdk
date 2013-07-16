using System;
using System.Collections.Generic;
using System.Linq;
using OrderCart;
using Telerik.Web.UI;

public partial class RadGridWithCustomObject : System.Web.UI.Page
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
		//The collection that should be traversed.
		Contractors contractors = new Contractors();
		List<Customer> customers = contractors.GetAllCustomers();
		//Get the PK of the element that should be updated.
		string customerID = item.OwnerTableView.DataKeyValues[item.ItemIndex][RadGrid1.MasterTableView.DataKeyNames[0]].ToString();
		//Query the model for the element that should be updated.
		Customer customerToUpdate = (from customer in customers
									 where customer.CustomerID == customerID.ToString()
									 select customer).FirstOrDefault();
		item.UpdateValues(customerToUpdate);
		contractors.UpdateCustomer(customerToUpdate);
	}

	protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
	{
		GridDataItem item = (GridDataItem)e.Item;	
		//Get the primary key value using the DataKeyValue.       
		string customerID = item.OwnerTableView.DataKeyValues[item.ItemIndex][RadGrid1.MasterTableView.DataKeyNames[0]].ToString();
		Contractors contractors = new Contractors();
		//Query the model for the element that should be deleted.
		Customer customerToDelete = (from customer in contractors.GetAllCustomers()
									 where customer.CustomerID == customerID
									 select customer).FirstOrDefault();
		//Delete the element.
		contractors.DeleteCustomer(customerToDelete);
	}

	protected void RadGrid1_InsertCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
	{
		GridEditFormItem item = (GridEditFormItem)e.Item;
		Contractors contractors = new Contractors();
		//Create the empty element that should be inserted.
		Customer customerToAdd = new Customer();
		int customerID;
		int.TryParse(contractors.GetAllCustomers().Last().CustomerID, out customerID);
		//Increment the PK field.
		customerToAdd.CustomerID = (++customerID).ToString();
		//Apply the vlaues from the editor controls.
		item.UpdateValues(customerToAdd);
		//Add the element.
		contractors.AddCustomer(customerToAdd);
	}

	protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
	{
		Contractors contractors = new Contractors();
		//The collection that holds the data.
		List<Customer> customers = contractors.GetAllCustomers();
		//Set the maximum amount of items the Grid will display.
		RadGrid1.VirtualItemCount = customers.Count;		
		//Set the datasource to the Grid instance.
		RadGrid1.DataSource = customers.Skip(RadGrid1.PageSize * RadGrid1.CurrentPageIndex).Take(RadGrid1.PageSize);
	}
}