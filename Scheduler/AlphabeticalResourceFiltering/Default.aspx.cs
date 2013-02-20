using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class _Default : System.Web.UI.Page
{
    private int PageSize = 2;

    protected void Page_Init(object sender, EventArgs e)
    {
        XmlSchedulerProvider provider = new XmlSchedulerProvider(Server.MapPath("~/App_Data/Appointments_MultipleResources.xml"), true);
        RadScheduler1.Provider = provider;
    }
    protected void RadScheduler1_DataBound(object sender, EventArgs e)
    {
        RadScheduler1.ResourceTypes.FindByName("User").AllowMultipleValues = true;
     
        IList<Resource> pagedResources = new List<Resource>(RadScheduler1.Resources.GetResourcesByType("User"));
        IList<Resource> remainingResources = new List<Resource>();
     
        int resourceIndex = 0;
        string selectedLetter = Hiddenfield1.Value;
       
        if (Hiddenfield1.Value!="All")
        {
            if (String.IsNullOrEmpty(selectedLetter))
            {
                selectedLetter = "A";
            }
            foreach (Resource resource in pagedResources)
            {
                if (!resource.Text.StartsWith(selectedLetter))
                {
                    RadScheduler1.Resources.Remove(resource);
                    remainingResources.Add(resource);
                }
                resourceIndex++;
            }
        }
      
       
        Session["remainingResources"] = remainingResources;
      
    }
    protected void NextPage_Click(object sender, EventArgs e)
    {
        IList<Resource> remainingResources = Session["remainingResources"] as List<Resource>;
        int count = 0;

        RadButton lb = (RadButton)sender;
        if (lb.Text=="All")
        {
            count = 7; //the count of all the resources you are using
            foreach (Resource res in RadScheduler1.Resources.GetResourcesByType("User"))
            {
                remainingResources.Add(res);
            }
            Hiddenfield1.Value = lb.Text;
        }
        else
        {
            for (int i = 0; i < remainingResources.Count; i++)
            {
                Resource item = remainingResources[i];
                if (item.Text.StartsWith(lb.Text))
                {
                    count++;
                }

            }
            Hiddenfield1.Value = lb.Text;
            foreach (Resource res in RadScheduler1.Resources.GetResourcesByType("User"))
            {
                remainingResources.Add(res);
            }
        }
       
        PageSize = count;
        Session["remainingResources"] = remainingResources;

        RadScheduler1.Rebind();
    }
    protected void PrevPage_Click(object sender, EventArgs e)
    {
        int pageIndex = (int?)ViewState["PageIndex"] ?? 0;
        pageIndex = Math.Max(pageIndex - 1, 0);
        ViewState["PageIndex"] = pageIndex;
        RadScheduler1.Rebind();
    }

    protected void RadScheduler1_AppointmentCommand(object sender, AppointmentCommandEventArgs e)
    {
        if (e.CommandName == "Cancel")
            RadScheduler1.Rebind();
    }
    protected void RadScheduler1_FormCreating(object sender, SchedulerFormCreatingEventArgs e)
    {
        if (e.Mode == SchedulerFormMode.AdvancedEdit || e.Mode == SchedulerFormMode.AdvancedInsert)
        {
            IList<Resource> remainingResources = Session["remainingResources"] as List<Resource>;
            if (remainingResources != null)
            {
                foreach (Resource resource in remainingResources)
                {
                    RadScheduler1.Resources.Add(resource);
                }
                Session.Remove("remainingResources");
            }
        }
    }
}
