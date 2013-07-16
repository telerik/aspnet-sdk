using System;
using System.Web;
using Telerik.Web.UI;
using Telerik.Web.Examples.Scheduler.Exchange;

public partial class _Default : System.Web.UI.Page 
{
    protected void Page_Load(object sender, EventArgs e)
    {
	
        //below goes your Exchange account credentials in that order 
		//RadScheduler1.Provider = new ExchangeSchedulerProvider(@"https://yourURL.com/EWS/Exchange.asmx", "username", "password", "domain", "CalendarName");
		//and some credentials for sample purposes
		//RadScheduler1.Provider = new ExchangeSchedulerProvider(@"https://hubcasbg02.telerik.com/EWS/Exchange.asmx", "antoniomoreno", "amorenopassword", "telerik", "antoniomoreno@telerik.com");
    }
    protected void RadScheduler1_AppointmentDataBound(object sender, SchedulerEventArgs e)
    {
    }
}