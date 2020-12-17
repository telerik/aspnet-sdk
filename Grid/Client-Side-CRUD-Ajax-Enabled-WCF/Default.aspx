<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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
       

        <script type="text/javascript">
            function ParameterMap(sender, args) {
                //If you want to send a parameter to the select call you can modify the if 
                //statement to check whether the request type is 'read':
                //if (args.get_type() == "read" && args.get_data()) {

                if (args.get_type() != "read" && args.get_data()) {
                    args.set_parameterFormat({ customersJSON: kendo.stringify(args.get_data().models) });
                }
            }

            function Parse(sender, args) {
                var response = args.get_response().d;

                if (response) {
                    args.set_parsedData(response.Data);
                }
            }
        </script>

        <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" ClientDataSourceID="RadClientDataSource1" AllowPaging="true">
            <MasterTableView ClientDataKeyNames="CustomerID" EditMode="Batch" CommandItemDisplay="Top" BatchEditingSettings-HighlightDeletedRows="true">
                <Columns>
                    <telerik:GridBoundColumn DataField="CustomerID" HeaderText="Customer ID" ReadOnly="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CompanyName" HeaderText="Company Name" ColumnEditorID="GridTextBoxEditor">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ContactName" HeaderText="Contact Name" ColumnEditorID="GridTextBoxEditor">
                    </telerik:GridBoundColumn>
                    <telerik:GridClientDeleteColumn HeaderText="Delete">
                        <HeaderStyle Width="70px" />
                    </telerik:GridClientDeleteColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>


        <telerik:RadClientDataSource ID="RadClientDataSource1" runat="server" AllowBatchOperations="true">
            <ClientEvents OnCustomParameter="ParameterMap" OnDataParse="Parse" />
            <DataSource>
                 <WebServiceDataSourceSettings BaseUrl="GridCrud.svc/">
                    <Select Url="GetCustomers" DataType="JSON" />
                    <Update Url="UpdateCustomers" DataType="JSON" />
                    <Insert Url="InsertCustomers" DataType="JSON" />
                    <Delete Url="DeleteCustomers" DataType="JSON" />
                </WebServiceDataSourceSettings>
            </DataSource>
            <Schema>
                <Model ID="CustomerID">
                    <telerik:ClientDataSourceModelField FieldName="CustomerID" DataType="Number" />
                    <telerik:ClientDataSourceModelField FieldName="CompanyName" DataType="String" />
                    <telerik:ClientDataSourceModelField FieldName="ContactName" DataType="String" />
                    <telerik:ClientDataSourceModelField FieldName="ContactTitle" DataType="String" />
                </Model>
            </Schema>
        </telerik:RadClientDataSource>

    </form>
</body>
</html>
