<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs"
    Inherits="RadSchedulerWebForm1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server" />
    <style type="text/css">
      
         .Disabled {
            background: silver !important;
            cursor: not-allowed;
            z-index:1000;
        }
        .Disabled.rsAptCreate {
            background: silver !important;
        }


        .hideHeader .rsTimelineView .rsHorizontalHeaderWrapper {
            display: none;
        }
        td.rsVerticalHeaderWrapper table.rsVerticalHeaderTable .rsMainHeader {
            vertical-align: middle;
            line-height: 80px;
            text-align: left;
        }
        
        .rsVerticalHeaderTable th div {
            min-width: 52px;
            
            width: 90px;
        }
        
        .rsAllDayRow {
            height: 80px !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
        <Scripts>
            <%--Needed for JavaScript IntelliSense in VS2010--%>
            <%--For
VS2008 replace RadScriptManager with ScriptManager--%>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
        </Scripts>
    </telerik:RadScriptManager>
        <script type="text/javascript">
            function OnClientFormCreated(sender, args) {
                var $ = $telerik.$;
                $("[id$='ResMonth']").hide();
            }
        </script>
    <div>
        <telerik:RadScheduler runat="server" ID="RadScheduler1" SelectedView="TimelineView" OnTimeSlotCreated="RadScheduler_TimeSlotCreated"
            OnClientFormCreated="OnClientFormCreated"
            StartInsertingInAdvancedForm="true" Height="70px" GroupBy="Month" OverflowBehavior="Expand"
            DayView-UserSelectable="false"  ShowHeader="false"
            WeekView-UserSelectable="false" MonthView-UserSelectable="false">
            <TimelineView NumberOfSlots="31" ColumnHeaderDateFormat="dd" UserSelectable="false"
                TimeLabelSpan="1" GroupingDirection="Vertical" />
            <AdvancedForm Modal="true" />
            <ResourceHeaderTemplate>
                January</ResourceHeaderTemplate>
        </telerik:RadScheduler>
        <telerik:RadScheduler runat="server" ID="RadScheduler2" SelectedView="TimelineView" OnTimeSlotCreated="RadScheduler_TimeSlotCreated"   
            StartInsertingInAdvancedForm="true" ShowHeader="false" ShowDateHeaders="false" DisplayDeleteConfirmation="false"
            CssClass="hideHeader" GroupBy="Month" OverflowBehavior="Expand" class=" hideHeader">
            <TimelineView NumberOfSlots="31" ColumnHeaderDateFormat="dd" UserSelectable="false"
                TimeLabelSpan="1" GroupingDirection="Vertical" />
            <AdvancedForm Modal="true" />
            <ResourceHeaderTemplate>
                February</ResourceHeaderTemplate>
        </telerik:RadScheduler>
        <telerik:RadScheduler runat="server" ID="RadScheduler3" SelectedView="TimelineView" OnTimeSlotCreated="RadScheduler_TimeSlotCreated"
            StartInsertingInAdvancedForm="true" ShowHeader="false" ShowDateHeaders="false"
            CssClass="hideHeader" GroupBy="Month" OverflowBehavior="Expand" class=" hideHeader">
            <TimelineView NumberOfSlots="31" ColumnHeaderDateFormat="dd" UserSelectable="false"
                TimeLabelSpan="1" GroupingDirection="Vertical" />
            <AdvancedForm Modal="true" />
            <ResourceHeaderTemplate>
                March</ResourceHeaderTemplate>
        </telerik:RadScheduler>
        <telerik:RadScheduler runat="server" ID="RadScheduler4" SelectedView="TimelineView" OnTimeSlotCreated="RadScheduler_TimeSlotCreated"
            StartInsertingInAdvancedForm="true" ShowHeader="false" ShowDateHeaders="false"
            CssClass="hideHeader" GroupBy="Month" OverflowBehavior="Expand" class=" hideHeader">
            <TimelineView NumberOfSlots="31" ColumnHeaderDateFormat="dd" UserSelectable="false"
                TimeLabelSpan="1" GroupingDirection="Vertical" />
            <AdvancedForm Modal="true" />
            <ResourceHeaderTemplate>
                April</ResourceHeaderTemplate>
        </telerik:RadScheduler>
        <telerik:RadScheduler runat="server" ID="RadScheduler5" SelectedView="TimelineView" OnTimeSlotCreated="RadScheduler_TimeSlotCreated"
            StartInsertingInAdvancedForm="true" ShowHeader="false" ShowDateHeaders="false"
            CssClass="hideHeader" GroupBy="Month" OverflowBehavior="Expand" class="hideHeader">
            <TimelineView NumberOfSlots="31" ColumnHeaderDateFormat="dd" UserSelectable="false"
                TimeLabelSpan="1" GroupingDirection="Vertical" />
            <AdvancedForm Modal="true" />
            <ResourceHeaderTemplate>
                May</ResourceHeaderTemplate>
        </telerik:RadScheduler>
        <telerik:RadScheduler runat="server" ID="RadScheduler6" SelectedView="TimelineView" OnTimeSlotCreated="RadScheduler_TimeSlotCreated"
            StartInsertingInAdvancedForm="true" ShowHeader="false" ShowDateHeaders="false"
            CssClass="hideHeader" GroupBy="Month" OverflowBehavior="Expand" class=" hideHeader">
            <TimelineView NumberOfSlots="31" ColumnHeaderDateFormat="dd" UserSelectable="false"
                TimeLabelSpan="1" GroupingDirection="Vertical" />
            <AdvancedForm Modal="true" />
            <ResourceHeaderTemplate>
                June</ResourceHeaderTemplate>
        </telerik:RadScheduler>
        <telerik:RadScheduler runat="server" ID="RadScheduler7" SelectedView="TimelineView" OnTimeSlotCreated="RadScheduler_TimeSlotCreated"
            StartInsertingInAdvancedForm="true" ShowHeader="false" ShowDateHeaders="false"
            CssClass="hideHeader" GroupBy="Month" OverflowBehavior="Expand" class=" hideHeader">
            <TimelineView NumberOfSlots="31" ColumnHeaderDateFormat="dd" UserSelectable="false"
                TimeLabelSpan="1" GroupingDirection="Vertical" />
            <AdvancedForm Modal="true" />
            <ResourceHeaderTemplate>
                July</ResourceHeaderTemplate>
        </telerik:RadScheduler>
        <telerik:RadScheduler runat="server" ID="RadScheduler8" SelectedView="TimelineView" OnTimeSlotCreated="RadScheduler_TimeSlotCreated"
            StartInsertingInAdvancedForm="true" ShowHeader="false" ShowDateHeaders="false"
            CssClass="hideHeader" GroupBy="Month" OverflowBehavior="Expand" class=" hideHeader">
            <TimelineView NumberOfSlots="31" ColumnHeaderDateFormat="dd" UserSelectable="false"
                TimeLabelSpan="1" GroupingDirection="Vertical" />
            <AdvancedForm Modal="true" />
            <ResourceHeaderTemplate>
                August</ResourceHeaderTemplate>
        </telerik:RadScheduler>
        <telerik:RadScheduler runat="server" ID="RadScheduler9" SelectedView="TimelineView" OnTimeSlotCreated="RadScheduler_TimeSlotCreated"
            StartInsertingInAdvancedForm="true" ShowHeader="false" ShowDateHeaders="false"
            CssClass="hideHeader" GroupBy="Month" OverflowBehavior="Expand" class=" hideHeader">
            <TimelineView NumberOfSlots="31" ColumnHeaderDateFormat="dd" UserSelectable="false"
                TimeLabelSpan="1" GroupingDirection="Vertical" />
            <AdvancedForm Modal="true" />
            <ResourceHeaderTemplate>
                September</ResourceHeaderTemplate>
        </telerik:RadScheduler>
        <telerik:RadScheduler runat="server" ID="RadScheduler10" SelectedView="TimelineView" OnTimeSlotCreated="RadScheduler_TimeSlotCreated"
            StartInsertingInAdvancedForm="true" ShowHeader="false" ShowDateHeaders="false"
            CssClass="hideHeader" GroupBy="Month" OverflowBehavior="Expand" class=" hideHeader">
            <TimelineView NumberOfSlots="31" ColumnHeaderDateFormat="dd" UserSelectable="false"
                TimeLabelSpan="1" GroupingDirection="Vertical" />
            <AdvancedForm Modal="true" />
            <ResourceHeaderTemplate>
                Octomber</ResourceHeaderTemplate>
        </telerik:RadScheduler>
        <telerik:RadScheduler runat="server" ID="RadScheduler11" SelectedView="TimelineView" OnTimeSlotCreated="RadScheduler_TimeSlotCreated"
            StartInsertingInAdvancedForm="true" ShowHeader="false" ShowDateHeaders="false"
            CssClass="hideHeader" GroupBy="Month" OverflowBehavior="Expand" class="hideHeader">
            <TimelineView NumberOfSlots="31" ColumnHeaderDateFormat="dd" UserSelectable="false"
                TimeLabelSpan="1" GroupingDirection="Vertical" />
            <AdvancedForm Modal="true" />
            <ResourceHeaderTemplate>
                November</ResourceHeaderTemplate>
        </telerik:RadScheduler>
        <telerik:RadScheduler runat="server" ID="RadScheduler12" SelectedView="TimelineView" OnTimeSlotCreated="RadScheduler_TimeSlotCreated"
            StartInsertingInAdvancedForm="true" ShowHeader="false" ShowDateHeaders="false"
            CssClass="hideHeader" GroupBy="Month" OverflowBehavior="Expand" class=" hideHeader">
            <TimelineView NumberOfSlots="31" ColumnHeaderDateFormat="dd" UserSelectable="false"
                TimeLabelSpan="1" GroupingDirection="Vertical" />
            <AdvancedForm Modal="true" />
            <ResourceHeaderTemplate>
                December</ResourceHeaderTemplate>
        </telerik:RadScheduler>
    </div>
    </form>
</body>
</html>
