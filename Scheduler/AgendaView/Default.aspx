<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="RadSchedulerWebForm" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .templateStart {
            position: relative;
            top: 21px;
            left: 26px;
        }

        .templateSubject {
            position: relative;
            top: 21px;
            left: 126px;
        }
    </style>
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server" />
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
            <Scripts>
            </Scripts>
        </telerik:RadScriptManager>
        <script type="text/javascript">
            (function () {
                Sys.Application.add_load(function myfunction() {
                    var $ = $telerik.$,
                        scheduler = $find("<%= RadScheduler1.ClientID %>");

                    $(".rsDateHeader").click(function myfunction(e) {
                        e.preventDefault();
                        e.stopPropagation();
                        var date = new Date();
                        // Date headers have an href in the format #yyyy-MM-dd
                        var dateMatch = $(this).attr("href").match(/#(\d{4}-\d{2}-\d{2})/);
                        if (dateMatch && dateMatch.length == 2) {
                            //parse the string and create new javescript Date format
                            var parts = $.map(dateMatch[1].split("-"), function (part) { return parseInt(part, 10); });
                            date = new Date(parts[0], parts[1] - 1, parts[2]);
                        }
                        scheduler._switchToSelectedDay(date);
                    });
                })
            })();
        </script>
        <telerik:RadNumericTextBox runat="server" ID="RNT" Label="Duration of Agenda in Days" Skin="Metro" LabelWidth="150px" Width="200px"></telerik:RadNumericTextBox>
        <telerik:RadButton runat="server" ID="RB" OnClick="RB_Click" Text="Change Duration" Skin="Metro"></telerik:RadButton>
        <telerik:RadScheduler runat="server" ID="RadScheduler1" SelectedView="MonthView" Skin="Metro" OnNavigationComplete="RadScheduler1_NavigationComplete1">
            <WeekView UserSelectable="false" />
            <DayView UserSelectable="false" />
            <Localization HeaderTimeline="Agenda" />
            <ResourceStyles>
                <telerik:ResourceStyleMapping Type="User" Text="Alex" ApplyCssClass="rsCategoryBlue"></telerik:ResourceStyleMapping>
                <telerik:ResourceStyleMapping Type="User" Text="Bob" ApplyCssClass="rsCategoryOrange"></telerik:ResourceStyleMapping>
                <telerik:ResourceStyleMapping Type="User" Text="Charlie" ApplyCssClass="rsCategoryGreen"></telerik:ResourceStyleMapping>
            </ResourceStyles>
            <TimelineView NumberOfSlots="1" />
        </telerik:RadScheduler>
    </form>
</body>
</html>
