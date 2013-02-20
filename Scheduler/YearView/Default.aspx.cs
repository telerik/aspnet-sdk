using System;
using Telerik.Web.UI;

public partial class RadSchedulerWebForm1 : System.Web.UI.Page 
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
        if (!IsPostBack)
        {
            RadScheduler1.SelectedDate = new DateTime(RadScheduler1.SelectedDate.Year, 1, 1);
            RadScheduler2.SelectedDate = new DateTime(RadScheduler1.SelectedDate.Year, 2, 1);
            RadScheduler3.SelectedDate = new DateTime(RadScheduler1.SelectedDate.Year, 3, 1);
            RadScheduler4.SelectedDate = new DateTime(RadScheduler1.SelectedDate.Year, 4, 1);
            RadScheduler5.SelectedDate = new DateTime(RadScheduler1.SelectedDate.Year, 5, 1);
            RadScheduler6.SelectedDate = new DateTime(RadScheduler1.SelectedDate.Year, 6, 1);
            RadScheduler7.SelectedDate = new DateTime(RadScheduler1.SelectedDate.Year, 7, 1);
            RadScheduler8.SelectedDate = new DateTime(RadScheduler1.SelectedDate.Year, 8, 1);
            RadScheduler9.SelectedDate = new DateTime(RadScheduler1.SelectedDate.Year, 9, 1);
            RadScheduler10.SelectedDate = new DateTime(RadScheduler1.SelectedDate.Year, 10, 1);
            RadScheduler11.SelectedDate = new DateTime(RadScheduler1.SelectedDate.Year, 11, 1);
            RadScheduler12.SelectedDate = new DateTime(RadScheduler1.SelectedDate.Year, 12, 1);
        }
    }

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        RadScheduler1.Provider = new XmlSchedulerProvider(Server.MapPath("~/App_Data/Appointments.xml"), true);
        RadScheduler2.Provider = new XmlSchedulerProvider(Server.MapPath("~/App_Data/Appointments.xml"), true);
        RadScheduler3.Provider = new XmlSchedulerProvider(Server.MapPath("~/App_Data/Appointments.xml"), true);
        RadScheduler4.Provider = new XmlSchedulerProvider(Server.MapPath("~/App_Data/Appointments.xml"), true);
        RadScheduler5.Provider = new XmlSchedulerProvider(Server.MapPath("~/App_Data/Appointments.xml"), true);
        RadScheduler6.Provider = new XmlSchedulerProvider(Server.MapPath("~/App_Data/Appointments.xml"), true);
        RadScheduler7.Provider = new XmlSchedulerProvider(Server.MapPath("~/App_Data/Appointments.xml"), true);
        RadScheduler8.Provider = new XmlSchedulerProvider(Server.MapPath("~/App_Data/Appointments.xml"), true);
        RadScheduler9.Provider = new XmlSchedulerProvider(Server.MapPath("~/App_Data/Appointments.xml"), true);
        RadScheduler10.Provider = new XmlSchedulerProvider(Server.MapPath("~/App_Data/Appointments.xml"), true);
        RadScheduler11.Provider = new XmlSchedulerProvider(Server.MapPath("~/App_Data/Appointments.xml"), true);
        RadScheduler12.Provider = new XmlSchedulerProvider(Server.MapPath("~/App_Data/Appointments.xml"), true);
    }


    protected void RadScheduler_TimeSlotCreated(object sender, TimeSlotCreatedEventArgs e)
    {
        RadScheduler scheduler = (RadScheduler)sender;

        if (e.TimeSlot.Start.Month!= Int32.Parse(scheduler.ID.Substring(12)))
        {
            e.TimeSlot.CssClass += "Disabled";
        }
    }
   
}
