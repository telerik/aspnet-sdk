<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ThreeRadGridsExport.aspx.cs" Inherits="ThreeRadGridsExport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
        <h3>Customers table</h3>
        <telerik:RadGrid ID="CustomersGrid" runat="server" AutoGenerateColumns="false" DataSourceID="SqlDataSource1" AllowPaging="true" PageSize="5">
            <MasterTableView>
                <Columns>
                    <telerik:GridBoundColumn DataField="CustomerID" HeaderText="CustomerID" UniqueName="CustomerID"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CompanyName" HeaderText="CompanyName" UniqueName="CompanyName"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ContactName" HeaderText="ContactName" UniqueName="ContactName"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ContactTitle" HeaderText="ContactTitle" UniqueName="ContactTitle"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Address" HeaderText="Address" UniqueName="Address"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PostalCode" HeaderText="PostalCode" UniqueName="PostalCode"></telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
        <h3>Products table</h3>
        <telerik:RadGrid ID="ProductsGrid" runat="server" AutoGenerateColumns="false" DataSourceID="SqlDataSource2" AllowPaging="true" PageSize="5">
            <MasterTableView>
                <Columns>
                    <telerik:GridBoundColumn DataField="ProductName" HeaderText="ProductName" UniqueName="ProductName"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UnitPrice" HeaderText="UnitPrice" UniqueName="UnitPrice"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UnitsInStock" HeaderText="UnitsInStock" UniqueName="UnitsInStock"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UnitsOnOrder" HeaderText="UnitsOnOrder" UniqueName="UnitsOnOrder"></telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
        <h3>Orders table</h3>
        <telerik:RadGrid ID="OrdersGrid" runat="server" AutoGenerateColumns="false" DataSourceID="SqlDataSource3" AllowPaging="true" PageSize="5">
            <MasterTableView>
                <Columns>
                    <telerik:GridBoundColumn DataField="OrderDate" HeaderText="OrderDate" UniqueName="OrderDate"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RequiredDate" HeaderText="RequiredDate" UniqueName="RequiredDate"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ShipName" HeaderText="ShipName" UniqueName="ShipName"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ShipCity" HeaderText="ShipCity" UniqueName="ShipCity"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ShipCountry" HeaderText="ShipCountry" UniqueName="ShipCountry"></telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
        <br />        
        <telerik:RadComboBox ID="ExportingType" runat="server" Width="300px">
            <Items>
                <telerik:RadComboBoxItem Text="Export grids on the page in a separate spreadsheets" Value="1" />
                <telerik:RadComboBoxItem Text="Export grids on the page in a single spreadsheets" Value="2" />
            </Items>
        </telerik:RadComboBox>
        <asp:Button Text="Export" ID="Button1" OnClick="Button1_Click" runat="server" />

        <asp:SqlDataSource ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:NorthwindConnectionString %>"
        ProviderName="System.Data.SqlClient" SelectCommand="SELECT TOP 10 CustomerID, CompanyName, ContactName, ContactTitle, Address, PostalCode FROM Customers"
        runat="server"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" ConnectionString="<%$ ConnectionStrings:NorthwindConnectionString %>"
        ProviderName="System.Data.SqlClient" SelectCommand="SELECT TOP 10 ProductName, UnitPrice, UnitsInStock, UnitsOnOrder FROM Products"
        runat="server"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource3" ConnectionString="<%$ ConnectionStrings:NorthwindConnectionString %>"
        ProviderName="System.Data.SqlClient" SelectCommand="SELECT TOP 10 ShipName, ShipCity, OrderDate, RequiredDate, ShipCountry FROM Orders"
        runat="server"></asp:SqlDataSource>
    </form>
</body>
</html>
