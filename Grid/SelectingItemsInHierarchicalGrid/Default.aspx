<%@ Page EnableViewState="true" Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs"
    Trace="false" Inherits="_Default" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="Form1" method="post" runat="server">
    <telerik:RadScriptManager runat="server">
    </telerik:RadScriptManager>
    <telerik:RadAjaxPanel runat="server" ID="RadAjaxPanel1" EnableAJAX="false">
        <telerik:RadGrid AllowMultiRowSelection="true" ID="RadGrid1" DataSourceID="SqlDataSource1"
            runat="server" Width="95%" AutoGenerateColumns="False" PageSize="3" AllowSorting="True"
            AllowPaging="True" GridLines="None" OnPreRender="RadGrid1_PreRender" OnItemCommand="RadGrid1_ItemCommand">
            <PagerStyle Mode="NumericPages"></PagerStyle>
            <MasterTableView DataSourceID="SqlDataSource1" DataKeyNames="CustomerID" Name="Level1"
                AllowMultiColumnSorting="True" Width="100%">
                <DetailTables>
                    <telerik:GridTableView Name="Level2" DataKeyNames="OrderID" DataSourceID="SqlDataSource2"
                        Width="100%" runat="server">
                        <ParentTableRelation>
                            <telerik:GridRelationFields DetailKeyField="CustomerID" MasterKeyField="CustomerID" />
                        </ParentTableRelation>
                        <DetailTables>
                            <telerik:GridTableView Name="Level3" DataKeyNames="ProductID" DataSourceID="SqlDataSource3"
                                Width="100%" runat="server">
                                <ParentTableRelation>
                                    <telerik:GridRelationFields DetailKeyField="OrderID" MasterKeyField="OrderID"></telerik:GridRelationFields>
                                </ParentTableRelation>
                                <Columns>
                                <telerik:GridTemplateColumn UniqueName="CheckBoxTemplate">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="detailCheckbox" AutoPostBack="true" OnCheckedChanged="DetailCheckbox_CheckedChanged"
                                                runat="server"></asp:CheckBox>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn SortExpression="UnitPrice" HeaderText="Unit Price" HeaderButtonType="TextButton"
                                        DataField="UnitPrice" UniqueName="UnitPrice">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn SortExpression="ProductID" HeaderText="ProductID" HeaderButtonType="TextButton"
                                        DataField="ProductID" UniqueName="ProductID">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn SortExpression="Quantity" HeaderText="Quantity" HeaderButtonType="TextButton"
                                        DataField="Quantity" UniqueName="Quantity">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn SortExpression="Discount" HeaderText="Discount" HeaderButtonType="TextButton"
                                        DataField="Discount" UniqueName="Discount">
                                    </telerik:GridBoundColumn>
                                </Columns>
                                <SortExpressions>
                                    <telerik:GridSortExpression FieldName="Quantity" SortOrder="Descending"></telerik:GridSortExpression>
                                </SortExpressions>
                            </telerik:GridTableView>
                        </DetailTables>
                        <Columns>
                            <telerik:GridTemplateColumn UniqueName="CheckBoxTemplate">
                                <ItemTemplate>
                                    <asp:CheckBox ID="detailCheckbox" AutoPostBack="true" OnCheckedChanged="DetailCheckbox_CheckedChanged"
                                        runat="server"></asp:CheckBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn SortExpression="OrderID" HeaderText="OrderID" HeaderButtonType="TextButton"
                                DataField="OrderID" UniqueName="OrderID">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn SortExpression="OrderDate" HeaderText="Date Ordered" HeaderButtonType="TextButton"
                                DataField="OrderDate" UniqueName="OrderDate">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn SortExpression="EmployeeID" HeaderText="EmployeeID" HeaderButtonType="TextButton"
                                DataField="EmployeeID" UniqueName="EmployeeID">
                            </telerik:GridBoundColumn>
                        </Columns>
                        <SortExpressions>
                            <telerik:GridSortExpression FieldName="OrderDate"></telerik:GridSortExpression>
                        </SortExpressions>
                        <ExpandCollapseColumn Visible="False">
                            <HeaderStyle Width="19px" />
                        </ExpandCollapseColumn>
                        <RowIndicatorColumn Visible="False">
                            <HeaderStyle Width="20px" />
                        </RowIndicatorColumn>
                    </telerik:GridTableView>
                </DetailTables>
                <Columns>
                    <telerik:GridTemplateColumn UniqueName="CheckBoxTemplate">
                        <ItemTemplate>
                            <asp:CheckBox ID="detailCheckbox" AutoPostBack="true" OnCheckedChanged="MasterCheckbox_CheckedChanged"
                                runat="server"></asp:CheckBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn SortExpression="CustomerID" HeaderText="CustomerID" HeaderButtonType="TextButton"
                        DataField="CustomerID" UniqueName="CustomerID">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn SortExpression="ContactName" HeaderText="Contact Name" HeaderButtonType="TextButton"
                        DataField="ContactName" UniqueName="ContactName">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn SortExpression="CompanyName" HeaderText="Company" HeaderButtonType="TextButton"
                        DataField="CompanyName" UniqueName="CompanyName">
                    </telerik:GridBoundColumn>
                </Columns>
                <SortExpressions>
                    <telerik:GridSortExpression FieldName="CompanyName"></telerik:GridSortExpression>
                </SortExpressions>
                <ExpandCollapseColumn>
                    <HeaderStyle Width="19px" />
                </ExpandCollapseColumn>
                <RowIndicatorColumn Visible="False">
                    <HeaderStyle Width="20px" />
                </RowIndicatorColumn>
            </MasterTableView>
            <ClientSettings>
                <Selecting AllowRowSelect="True" UseClientSelectColumnOnly="true" EnableDragToSelectRows="false" />
            </ClientSettings>
        </telerik:RadGrid>
    </telerik:RadAjaxPanel>
    <asp:SqlDataSource ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:NorthwindConnectionString %>"
        ProviderName="System.Data.SqlClient" SelectCommand="SELECT * FROM Customers"
        runat="server"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" ConnectionString="<%$ ConnectionStrings:NorthwindConnectionString %>"
        ProviderName="System.Data.SqlClient" SelectCommand="SELECT * FROM Orders Where CustomerID = @CustomerID"
        runat="server">
        <SelectParameters>
            <asp:SessionParameter Name="CustomerID" SessionField="CustomerID" Type="string">
            </asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource3" ConnectionString="<%$ ConnectionStrings:NorthwindConnectionString %>"
        ProviderName="System.Data.SqlClient" SelectCommand="SELECT * FROM [Order Details] where OrderID = @OrderID"
        runat="server">
        <SelectParameters>
            <asp:SessionParameter Name="OrderID" SessionField="OrderID" Type="Int32"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    </form>
</body>
</html>
