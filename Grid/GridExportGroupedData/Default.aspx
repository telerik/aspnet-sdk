<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="RadGridBiffExport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
        <script type="text/javascript">
            function onRequestStart(sender, args) {
                if (args.get_eventTarget().indexOf("btnExport") >= 0)
                    args.set_enableAjax(false);
            }
        </script>
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" ClientEvents-OnRequestStart="onRequestStart">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="RadGrid1">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <asp:ImageButton ImageUrl="img/file-extension-xls-biff-icon.png" ID="ExportButtonTop" OnClick="ExportButton_Click" runat="server" />
        <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="false" ShowGroupPanel="true"
            AllowPaging="true" PageSize="10">
            <ExportSettings Excel-Format="Biff" ExportOnlyData="true" OpenInNewWindow="true"></ExportSettings>
            <MasterTableView>
                <GroupByExpressions>
                    <telerik:GridGroupByExpression>
                        <GroupByFields>
                            <telerik:GridGroupByField FieldName="City" HeaderText="City" />
                        </GroupByFields>
                        <SelectFields>
                            <telerik:GridGroupByField FieldName="City" HeaderText="City" />
                        </SelectFields>
                    </telerik:GridGroupByExpression>
                </GroupByExpressions>
                <Columns>
                    <telerik:GridBoundColumn DataField="CompanyName" HeaderText="Company Name" UniqueName="CompanyName"></telerik:GridBoundColumn>              
                    <telerik:GridBoundColumn DataField="ContactName" HeaderText="Contact Name" UniqueName="ContactName"></telerik:GridBoundColumn>              
                    <telerik:GridBoundColumn DataField="Address" HeaderText="Address" UniqueName="Address"></telerik:GridBoundColumn>              
                    <telerik:GridBoundColumn DataField="City" HeaderText="City" UniqueName="City"></telerik:GridBoundColumn>              
                    <telerik:GridBoundColumn DataField="Phone" HeaderText="Phone" UniqueName="Phone"></telerik:GridBoundColumn>              
                    <telerik:GridBoundColumn DataField="Country" HeaderText="Country" UniqueName="Country"></telerik:GridBoundColumn>              
                </Columns>
            </MasterTableView>
            <ClientSettings AllowDragToGroup="true">                
            </ClientSettings>
        </telerik:RadGrid>
        <asp:ImageButton ImageUrl="img/file-extension-xls-biff-icon.png" ID="ExportButtonBottom" OnClick="ExportButton_Click" runat="server" />
        <asp:SqlDataSource ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:NorthwindConnectionString %>"
        ProviderName="System.Data.SqlClient" SelectCommand="SELECT * FROM Customers"
        runat="server"></asp:SqlDataSource>
    </form>
</body>
</html>
