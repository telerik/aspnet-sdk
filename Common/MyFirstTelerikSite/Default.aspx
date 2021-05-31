<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default" %>

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


        <h1>Add RadEditor to the Application</h1>
        <p>See the steps <a href="https://docs.telerik.com/devtools/aspnet-ajax/getting-started/first-steps#Add-RadEditor-to-the-Application">here</a></p>

        <telerik:RadEditor runat="server" ID="RadEditor1" RenderMode="Lightweight">
            <Content>             
                Congratulations! You have the Telerik UI for ASP.NET controls running in your project!         
            </Content>
        </telerik:RadEditor>



        <h1>Add RadHtmlChart to the Project</h1>
        <p>See the steps <a href="https://docs.telerik.com/devtools/aspnet-ajax/getting-started/first-steps#Add-RadHtmlChart-to-the-Project">here</a></p>

        <telerik:RadHtmlChart ID="RadHtmlChart1" runat="server">
            <ChartTitle Text="Sales Log"></ChartTitle>
            <PlotArea>
                <Series>
                    <telerik:ColumnSeries Name="Clothеs" DataFieldY="values" ColorField="colors">
                        <TooltipsAppearance>
                            <ClientTemplate>
                                There are #=dataItem.description# sold in #=category#
                            </ClientTemplate>
                        </TooltipsAppearance>
                    </telerik:ColumnSeries>
                </Series>
                <XAxis DataLabelsField="labels"></XAxis>
            </PlotArea>
        </telerik:RadHtmlChart>



        <h1>Apply New Skin to the Controls</h1>
        <p>See the steps <a href="https://docs.telerik.com/devtools/aspnet-ajax/getting-started/first-steps#Apply-New-Skin-to-the-Controls">here</a></p>

        <telerik:RadEditor runat="server" ID="RadEditor2" RenderMode="Lightweight" Skin="Glow">
            <Content>             
                Congratulations! You have the Telerik UI for ASP.NET controls running in your project!         
            </Content>
        </telerik:RadEditor>
    </form>
</body>
</html>
