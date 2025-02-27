﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server" />
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
            <Scripts>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
            </Scripts>
        </telerik:RadScriptManager>

        <script>

            function OnBatchEditCellValueChanged(sender, args) {

                switch (args.get_columnUniqueName()) {
                    case "OrderNumbers":
                    case "Price":

                        var grid = sender;
                        var masterTable = grid.get_masterTableView();
                        var batMan = grid.get_batchEditingManager();
                        // Instantiate GridDataItems Class to be able to cast TR elements to GridDataItem objects
                        var dataItems = masterTable.get_dataItems();

                        // Cast TR element to GridDataItem object
                        var currentDataItem = args.get_row().control;

                        var orderNumbersCell = currentDataItem.get_cell("OrderNumbers");
                        var orderNumbers = parseInt(batMan.getCellValue(orderNumbersCell));

                        var priceCell = currentDataItem.get_cell("Price");
                        var price = parseInt(batMan.getCellValue(priceCell));

                        var totalPrice = orderNumbers * price;

                        // Since the TotalPrice is a Calculated column that cannot be edited, it has to be manually changed using JavaScript
                        $(currentDataItem.get_cell("TotalPrice")).text(totalPrice);

                        break;

                }
            }

        </script>

        <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" Width="800px"
            AutoGenerateDeleteColumn="true"
            OnBatchEditCommand="RadGrid1_BatchEditCommand"
            OnNeedDataSource="RadGrid1_NeedDataSource">
            <ClientSettings>
                <ClientEvents OnBatchEditCellValueChanged="OnBatchEditCellValueChanged" />
            </ClientSettings>
            <MasterTableView DataKeyNames="OrderID" AutoGenerateColumns="False" CommandItemDisplay="Top" EditMode="Batch" PageSize="2000">
                <Columns>
                    <telerik:GridBoundColumn DataField="OrderID" DataType="System.Int32"
                        FilterControlAltText="Filter OrderID column" HeaderText="OrderID"
                        ReadOnly="True" SortExpression="OrderID" UniqueName="OrderID">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="OrderNumbers" DataType="System.Int32"
                        FilterControlAltText="Filter OrderNumbers column" HeaderText="OrderNumbers"
                        SortExpression="OrderNumbers" UniqueName="OrderNumbers">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Price" DataType="System.Int32"
                        FilterControlAltText="Filter Price column" HeaderText="Price"
                        SortExpression="Price" UniqueName="Price">
                    </telerik:GridBoundColumn>
                    <%--<telerik:GridBoundColumn DataField="TotalPrice" DataType="System.Int32"
                        FilterControlAltText="Filter TotalPrice column" HeaderText="TotalPrice"
                        SortExpression="TotalPrice" UniqueName="TotalPrice">
                    </telerik:GridBoundColumn>--%>

                    <telerik:GridCalculatedColumn UniqueName="TotalPrice" HeaderText="Total Price" DataFields="OrderNumbers, Price" Expression="{0}*{1}">
                    </telerik:GridCalculatedColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </form>
</body>
</html>
