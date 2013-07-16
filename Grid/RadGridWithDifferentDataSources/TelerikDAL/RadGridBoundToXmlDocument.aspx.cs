using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.Common.CommandTrees.ExpressionBuilder;
using System.Linq;
using System.Xml.Linq;
using NorthwindDAL.Xml;
using Telerik.Web.UI;

public partial class RadGridBoundToXmlDocument : System.Web.UI.Page
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

	//Applies the changes from the editor controls.
	protected XElement ApplyChanges(XElement element, IDictionary dictionary)
	{
		if (element.Elements().Count() == 0)
		{
			foreach (DictionaryEntry entry in dictionary)
			{
				XElement insertElement = new XElement(entry.Key.ToString(), entry.Value.ToString());
				//Add the supplied values as attributes to the newly created element
				element.Add(insertElement);
			}
		}
		else
		{
			foreach (XElement el in element.Descendants().ToList())
			{
				string key = el.Name.ToString();
				if (dictionary.Contains(key))
				{
					el.Value = dictionary[key].ToString();
				}
			}
		}
		return element;
	}

	protected string GetPath()
	{
		string filePath = "~/App_Data/SouthWind.xml";
		return this.Server.MapPath(filePath);
	}

	protected void RadGrid1_UpdateCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
	{
		GridEditFormItem editForm = (GridEditFormItem)e.Item;
		Hashtable newValues = new Hashtable();
		XMLContext context = new XMLContext();
		XDocument document = context.LoadDocument(GetPath());
		List<XElement> ordersTable = context.GetTable(document, "Orders").ToList();
		//Extract the new values from the editor controls
		editForm.ExtractValues(newValues);

		//Get the "Primary key" value that will be used to perform CRUD operations
		string orderID = editForm.GetDataKeyValue(RadGrid1.MasterTableView.DataKeyNames[0]).ToString();
		//Get a reference to the modified record
		XElement orderToUpdate = (from order in ordersTable
								  where order.Attribute("OrderID").Value == orderID
								  select order).FirstOrDefault();

		context.UpdateElement(ordersTable, ApplyChanges(orderToUpdate, newValues));
		context.SaveChanges(document, GetPath());
		;
	}

	protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
	{
		GridDataItem editForm = (GridDataItem)e.Item;
		XMLContext context = new XMLContext();
		XDocument document = context.LoadDocument(GetPath());
		List<XElement> ordersTable = context.GetTable(document, "Orders").ToList();
		string orderID = editForm.GetDataKeyValue(RadGrid1.MasterTableView.DataKeyNames[0]).ToString();

		XElement orderToDelete = (from order in ordersTable
								  where order.Attribute("OrderID").Value == orderID
								  select order).FirstOrDefault();
		context.DeleteElement(ordersTable, orderToDelete);
		context.SaveChanges(document, GetPath());

	}

	protected void RadGrid1_InsertCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
	{
		GridEditFormItem editForm = (GridEditFormItem)e.Item;
		Hashtable newValues = new Hashtable();
		XMLContext context = new XMLContext();
		XDocument document = context.LoadDocument(GetPath());
		List<XElement> ordersTable = context.GetTable(document, "Orders").ToList();
		//Extract the new values from the editor controls
		editForm.ExtractValues(newValues);
		XElement orderToInsert = new XElement("Order");
		int orderID = int.Parse((from order in ordersTable
								 select order).LastOrDefault().Attribute("OrderID").Value);
		orderToInsert.Add(new XAttribute("OrderID", ++orderID));
		context.InsertElement(document, ApplyChanges(orderToInsert, newValues), "Orders");
		context.SaveChanges(document, GetPath());

	}

	protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
	{
		XMLContext context = new XMLContext();
		XDocument document = context.LoadDocument(GetPath());
		List<XElement> ordersTable = context.GetTable(document, "Orders").ToList();
		//RadGrid1.VirtualItemCount = ordersTable.Count();
		var gridSource = (from order in ordersTable
						  select new
						  {
							  OrderID = order.Attribute("OrderID").Value,
							  CustomerID = order.Element("CustomerID").Value,
							  OrderDate = order.Element("OrderDate").Value,
							  Freight = order.Element("Freight").Value,
							  ShipName = order.Element("ShipName").Value,
							  ShipCity = order.Element("ShipCity").Value,
							  ShipCountry = order.Element("ShipCountry").Value
						  });
		RadGrid1.DataSource = gridSource.Skip(RadGrid1.CurrentPageIndex).Take(RadGrid1.PageSize);

	}
}