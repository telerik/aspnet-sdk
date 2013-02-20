<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <telerik:RadSkinManager runat="server" Skin="Metro"></telerik:RadSkinManager>
        <telerik:RadFormDecorator ID="QsfFromDecorator" runat="server" DecoratedControls="All" EnableRoundedCorners="false" />
          <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server">
        </telerik:RadAjaxLoadingPanel>
        <telerik:RadAjaxPanel runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
            <asp:Label runat="server" ID="MessageLabel" ForeColor="Green"></asp:Label>
            <asp:ValidationSummary runat="server" />

            <telerik:RadTreeList ID="RadTreeList1" runat="server" SelectMethod="GetProducts" UpdateMethod="UpdateProduct" 
                DeleteMethod="DeleteProduct" InsertMethod="InsertProduct"
                 ParentDataKeyNames="ReportsTo" 
                DataKeyNames="EmployeeID" AutoGenerateColumns="false">
                <Columns>
                    <telerik:TreeListEditCommandColumn UniqueName="InsertCommandColumn" ButtonType="ImageButton"
                        HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Center">
                    </telerik:TreeListEditCommandColumn>
                    <telerik:TreeListButtonColumn UniqueName="DeleteCommandColumn" Text="Delete" CommandName="Delete"
                        ButtonType="ImageButton" HeaderStyle-Width="40px">
                    </telerik:TreeListButtonColumn>
                    <telerik:TreeListBoundColumn DataField="EmployeeID" HeaderText="ID" ReadOnly="true"
                        UniqueName="EmployeeID" HeaderStyle-Width="60px" ForceExtractValue="Always">
                    </telerik:TreeListBoundColumn>
                    <telerik:TreeListBoundColumn DataField="LastName" HeaderText="Last Name" UniqueName="LastName"
                        HeaderStyle-Width="75px">
                    </telerik:TreeListBoundColumn>
                    <telerik:TreeListBoundColumn DataField="FirstName" HeaderText="First Name" UniqueName="FirstName"
                        HeaderStyle-Width="75px">
                    </telerik:TreeListBoundColumn>
                    <telerik:TreeListBoundColumn DataField="TitleOfCourtesy" HeaderText="Title" UniqueName="Title"
                        HeaderStyle-Width="60px">
                    </telerik:TreeListBoundColumn>
                    <telerik:TreeListBoundColumn DataField="HireDate" HeaderText="Hire Date" UniqueName="HireDate"
                        DataFormatString="{0:d}">
                    </telerik:TreeListBoundColumn>
                    <telerik:TreeListBoundColumn DataField="HomePhone" HeaderText="Home Phone" UniqueName="HomePhone">
                    </telerik:TreeListBoundColumn>
                    <telerik:TreeListBoundColumn DataField="Notes" HeaderText="Notes" UniqueName="Notes"
                        Visible="false">
                    </telerik:TreeListBoundColumn>
                    <telerik:TreeListBoundColumn DataField="ReportsTo" HeaderText="ReportsTo" HeaderStyle-Width="80px"
                        UniqueName="ReportsTo" ReadOnly="true" ForceExtractValue="Always">
                    </telerik:TreeListBoundColumn>
                </Columns>
            </telerik:RadTreeList>
        </telerik:RadAjaxPanel>
    </form>
</body>
</html>
