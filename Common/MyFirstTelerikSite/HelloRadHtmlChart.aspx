<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HelloRadHtmlChart.aspx.cs" Inherits="HelloRadHtmlChart" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager runat="server"></telerik:RadScriptManager>

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
    </form>
</body>
</html>
