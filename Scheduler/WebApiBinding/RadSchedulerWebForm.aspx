<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RadSchedulerWebForm.aspx.cs" Inherits="RadSchedulerWebForm" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>

        <script type="text/javascript">
            //<![CDATA[
            var categoryNames = new Array();
            var scheduler = null;
            var calendar1 = null;
            var SchedulerNavigationCompleteAlreadyOccurred = false;

            function pageLoad() {

                scheduler = $find('<%=RadScheduler1.ClientID %>');
                calendar1 = $find('<%=RadCalendar1.ClientID %>');
            }
            function rebindScheduler() {
                var scheduler = $find('<%=RadScheduler1.ClientID %>');
              scheduler.rebind();
          }

          function OnClientAppointmentsPopulating(sender, eventArgs) {
              addSelectedCategoriesToArray(categoryNames);
              eventArgs.get_schedulerInfo().CategoryNames = categoryNames;
              categoryNames = new Array(); //clear the array
          }

          function addSelectedCategoriesToArray(categoryNamesArray) {
              var $ = $telerik.$;
              var categoryPanelBar = $find('<%=RadPanelBar1.ClientID %>');
              $(':checkbox:checked', categoryPanelBar.get_element()).each(function () {
                  categoryNames.push($(this).attr('name'));
              });
          }

          function OnClientAppointmentWebServiceInserting(sender, args) {
              //set a default Calendar resource
              if (args.get_appointment().get_resources().get_count() == 0) {
                  var defaultCalendarResource = sender.get_resources().getResourceByTypeAndKey("Calendar", 1);
                  args.get_appointment().get_resources().add(defaultCalendarResource);
              }
          }

          function OnCalendar1DateSelected(sender, args) {
              var selectedDateTriplet = sender.get_selectedDates()[0];
              if (selectedDateTriplet) {

                  var selectedDate = new Date(selectedDateTriplet[0], selectedDateTriplet[1] - 1, selectedDateTriplet[2]);
                  scheduler.set_selectedDate(selectedDate);

              }
          }

          function OnCalendar1ViewChanged(sender, eventArgs) {

              var dateTriplet = sender.get_focusedDate();

              if (!SchedulerNavigationCompleteAlreadyOccurred) {
                  var selectedDate = new Date(dateTriplet[0], dateTriplet[1] - 1, dateTriplet[2]);
                  scheduler.set_selectedDate(selectedDate);
              }
              SchedulerNavigationCompleteAlreadyOccurred = false;
          }

          function OnClientNavigationComplete(sender, args) {
              SchedulerNavigationCompleteAlreadyOccurred = true;
              var selectedDate = sender.get_selectedDate();
              calendar1.navigateToDate([selectedDate.format("yyyy"), selectedDate.format("MM"), selectedDate.format("dd")]);
          }
          //]]>
        </script>
        <div class="qsf-demo-canvas">
            <telerik:RadSplitter runat="server" ID="RadSplitter1" Skin="Default"
                PanesBorderSize="0" Width="1000" Height="450">
                <telerik:RadPane runat="Server" ID="leftPane" Width="220" Scrolling="None">
                    <telerik:RadSplitter runat="server" ID="RadSplitter2" Skin="Default"
                        Orientation="Horizontal" Width="100%">
                        <telerik:RadPane ID="RadPane1" runat="server" Height="180">
                            <telerik:RadCalendar runat="server" ID="RadCalendar1" Skin="Default" EnableMultiSelect="false"
                                FocusedDate="2012/01/31" DayNameFormat="FirstTwoLetters" EnableNavigation="true"
                                EnableMonthYearFastNavigation="true">
                                <ClientEvents OnDateSelected="OnCalendar1DateSelected"
                                    OnCalendarViewChanged="OnCalendar1ViewChanged" />
                            </telerik:RadCalendar>
                        </telerik:RadPane>
                        <telerik:RadSplitBar ID="RadSplitBar1" runat="server" EnableResize="false" />
                        <telerik:RadPane ID="RadPane2" runat="server">

                            <telerik:RadPanelBar runat="server" ID="RadPanelBar1" Skin="Default" Width="100%"
                                ExpandAnimation-Type="None" CollapseAnimation-Type="None" ExpandMode="SingleExpandedItem">
                                <Items>
                                    <telerik:RadPanelItem runat="server" Text="My Calendars" Expanded="true">
                                        <Items>
                                            <telerik:RadPanelItem runat="server">
                                                <ItemTemplate>
                                                    <div class="rpCheckBoxPanel">
                                                        <div class="qsf-chk-personal">
                                                            <label>
                                                                <input id="chkPersonal" type="checkbox" title="Personal" onclick="rebindScheduler()"
                                                                    value="Personal" checked="checked" name="Personal" />
                                                                <span>Personal</span>
                                                            </label>
                                                        </div>
                                                        <div class="qsf-chk-work">
                                                            <label>
                                                                <input id="chkWork" type="checkbox" title="Work" onclick="rebindScheduler()" value="Work"
                                                                    checked="checked" name="Work" />
                                                                <span>Work</span>
                                                            </label>
                                                        </div>
                                                    </div>
                                                    <telerik:RadButton runat="server" ID="Button1" Text="Group" OnClick="Button1_Click"
                                                        Icon-PrimaryIconCssClass="qsf-btn-group" />
                                                    <span title="This button Groups RadScheduler by its Resources creating a separate calendar for each resource item and situating the appropriate appointments there."
                                                        class="qsf-btn-hint">?</span>
                                                </ItemTemplate>
                                            </telerik:RadPanelItem>
                                        </Items>
                                    </telerik:RadPanelItem>
                                </Items>
                            </telerik:RadPanelBar>
                        </telerik:RadPane>
                    </telerik:RadSplitter>
                </telerik:RadPane>
                <telerik:RadSplitBar runat="server" ID="RadSplitBar2" CollapseMode="Forward" EnableResize="false" />
                <telerik:RadPane runat="Server" ID="rightPane" Scrolling="None">
                    <telerik:RadScheduler runat="server" ID="RadScheduler1" Skin="Default" Height="450" 
                        OnClientAppointmentWebServiceInserting="OnClientAppointmentWebServiceInserting"
                        OnClientNavigationComplete="OnClientNavigationComplete"
                        OnClientAppointmentsPopulating="OnClientAppointmentsPopulating"
                        SelectedView="WeekView" ShowFooter="false" SelectedDate="2012-01-31" TimeZoneOffset="03:00:00"
                        DayStartTime="08:00:00" DayEndTime="21:00:00" FirstDayOfWeek="Monday" LastDayOfWeek="Friday"
                        EnableDescriptionField="true" AppointmentStyleMode="Default">
                        <WebServiceSettings Path="api/scheduler" ResourcePopulationMode="ServerSide" UseHttpGet="true" />
                        <AdvancedForm Modal="true"></AdvancedForm>
                        <TimelineView UserSelectable="false"></TimelineView>
                        <ResourceStyles>
                            <%--AppointmentStyleMode must be explicitly set to Default (see above) otherwise setting BackColor/BorderColor
                                   will switch the appointments to Simple rendering (no rounded corners and gradients)--%>
                            <telerik:ResourceStyleMapping Type="Calendar" Text="Personal"
                                BorderColor="#abd962" />
                            <telerik:ResourceStyleMapping Type="Calendar" Text="Work"
                                BorderColor="#25a0da" />
                        </ResourceStyles>
                        <ResourceHeaderTemplate>
                            <div class="rsResourceHeader<%# Eval("Text") %>">
                                <%# Eval("Text") %>
                            </div>
                        </ResourceHeaderTemplate>
                        <TimeSlotContextMenuSettings EnableDefault="true" />
                        <AppointmentContextMenuSettings EnableDefault="true" />
                        <Localization HeaderWeek="Work week" />
                    </telerik:RadScheduler>
                </telerik:RadPane>
            </telerik:RadSplitter>
        </div>

    </form>
</body>
</html>
