<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <telerik:RadCodeBlock runat="server">
        <style type="text/css">
            .rpgContentZone th[onclick],
            .rpgContentZone td[onclick]
            {
                cursor: pointer;
            }
        </style>
        <script type="text/javascript">
            function OpenDetailsWindow(argument)
            {
                $find("<%= RadAjaxPanel1.ClientID %>").ajaxRequest(argument);
            }
        </script>
    </telerik:RadCodeBlock>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
         <telerik:RadAjaxLoadingPanel runat="server" ID="RadAjaxLoadingPanel1" Skin="Default"></telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxPanel EnableAJAX="true" ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
        <asp:Label runat="server" ID="label1"></asp:Label>
        <telerik:RadPivotGrid Width="800px" runat="server" ID="RadPivotGrid1" 
             AllowPaging="true" AllowFiltering="false" ShowFilterHeaderZone="false" OnNeedDataSource="RadPivotGrid1_NeedDataSource">
            <PagerStyle Mode="NextPrevNumericAndAdvanced" AlwaysVisible="true"></PagerStyle>
            <Fields>
                <telerik:PivotGridRowField DataField="TransportType">
                </telerik:PivotGridRowField>
                <telerik:PivotGridRowField DataField="Company">
                </telerik:PivotGridRowField>
                <telerik:PivotGridColumnField DataField="Country">
                </telerik:PivotGridColumnField>
                <telerik:PivotGridColumnField DataField="City">
                </telerik:PivotGridColumnField>
                <telerik:PivotGridAggregateField DataField="Profit" Aggregate="Sum" >
                </telerik:PivotGridAggregateField>
                <telerik:PivotGridAggregateField DataField="Expenses" Aggregate="Max">
                </telerik:PivotGridAggregateField>
            </Fields>
            <ClientSettings>
                <Scrolling AllowVerticalScroll="true"></Scrolling>
            </ClientSettings>
        </telerik:RadPivotGrid>
        <telerik:RadWindow ID="RadWindow1" runat="server" MinWidth="900px" MinHeight="450px">
            <ContentTemplate>
                   <telerik:RadAjaxLoadingPanel runat="server" ID="RadAjaxLoadingPanel2" Skin="Default"></telerik:RadAjaxLoadingPanel>
                <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                    <telerik:RadGrid runat="server" ID="RadGrid1" AllowSorting="true" PageSize="5"
                        OnNeedDataSource="RadGrid1_NeedDataSource" AllowPaging="true">
                    </telerik:RadGrid>
                </telerik:RadAjaxPanel>
            </ContentTemplate>
        </telerik:RadWindow>
    </telerik:RadAjaxPanel>
    </form>
</body>
</html>
