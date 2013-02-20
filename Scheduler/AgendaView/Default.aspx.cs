using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Collections.Generic;
using System.Configuration;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Telerik.Web.UI;

public partial class RadSchedulerWebForm : System.Web.UI.Page 
{
   

    protected void Page_Load(object sender, EventArgs e)
    {
        if (RadScheduler1.SelectedView == SchedulerViewType.TimelineView)
        {

            RadScheduler1.RowHeight = 60;
            RadScheduler1.AppointmentTemplate = new AppTemplate();
            RadScheduler1.GroupBy = "Date,Room";
            RadScheduler1.GroupingDirection = GroupingDirection.Vertical;
           
        }
    }
    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        RadScheduler1.Provider = new XmlSchedulerProvider(Server.MapPath("~/App_Data/AppointmentsAgenda.xml"), true);
    }


    public class AppTemplate : ITemplate
    {
        public void InstantiateIn(Control container)
        {
            Label start = new Label(); 
            start.DataBinding += start_DataBinding;
            container.Controls.Add(start);
            Label subject = new Label();
            subject.DataBinding += subject_DataBinding;
            container.Controls.Add(subject);
            RadTreeView tree = new RadTreeView();
            
        }

        void subject_DataBinding(object sender, EventArgs e)
        {
            Label subject = (Label)sender;
            subject.CssClass = "templateSubject";
            IDataItemContainer aptContainer = (IDataItemContainer)subject.BindingContainer;

            //Access the appointment object and set its AllowEdit property:  
            SchedulerAppointmentContainer aptCont = (SchedulerAppointmentContainer)subject.Parent;
            Appointment app = aptCont.Appointment;


            string strSubject = HttpUtility.HtmlEncode((string)DataBinder.Eval(aptContainer.DataItem, "Subject"));
            subject.Text = strSubject;  
        }

        private void start_DataBinding(object sender, EventArgs e)
        {
            Label start = (Label)sender;
            start.CssClass = "templateStart";
            IDataItemContainer aptContainer = (IDataItemContainer)start.BindingContainer;

            //Access the appointment object and set its AllowEdit property:  
            SchedulerAppointmentContainer aptCont = (SchedulerAppointmentContainer)start.Parent;
            Appointment app = aptCont.Appointment;
           

            DateTime startTime = (DateTime)DataBinder.Eval(aptContainer.DataItem, "Start");
            start.Text =startTime.ToString("dddd, MMM, dd");
        }
    }
   

    protected void RadScheduler1_NavigationComplete1(object sender, SchedulerNavigationCompleteEventArgs e)
    {
        
        RadScheduler scheduler = (RadScheduler)sender;

        if (e.Command == SchedulerNavigationCommand.SwitchToSelectedDay) {
            scheduler.SelectedView = SchedulerViewType.TimelineView;
        }

        if (scheduler.SelectedView!=SchedulerViewType.TimelineView)
        {
            if (e.Command == SchedulerNavigationCommand.SwitchToTimelineView)
            {
                RadScheduler1.RowHeight = 60;
                RadScheduler1.AppointmentTemplate = new AppTemplate();
                RadScheduler1.GroupBy = "Date,Room";
                RadScheduler1.GroupingDirection = GroupingDirection.Vertical;
            }
            else
            {
                RadScheduler1.RowHeight = 25;
            }
        }
        else
        {
            if (e.Command == SchedulerNavigationCommand.NavigateToPreviousPeriod || 
                e.Command == SchedulerNavigationCommand.NavigateToNextPeriod || e.Command == SchedulerNavigationCommand.SwitchToSelectedDay)
            {
                RadScheduler1.RowHeight = 60;
                RadScheduler1.AppointmentTemplate = new AppTemplate();
                RadScheduler1.GroupBy = "Date,Room";
                RadScheduler1.GroupingDirection = GroupingDirection.Vertical;
            }
            else
            {
                RadScheduler1.RowHeight = 25;
            }
        }
    }
    protected void RB_Click(object sender, EventArgs e)
    {
        RadScheduler1.TimelineView.SlotDuration = TimeSpan.FromDays((double)RNT.Value);
    }
}
