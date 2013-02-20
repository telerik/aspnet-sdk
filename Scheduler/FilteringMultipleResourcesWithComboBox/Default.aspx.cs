using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Configuration;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Telerik.Web.UI;
using System.Collections.Generic;

public partial class TelerikWebForm : System.Web.UI.Page
{
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
           
                IList<RadComboBoxItem> comboItems = new List<RadComboBoxItem>();
                RadCombobox1.Items.Clear();
                //int resourceIndex = 0;
                string selectedLetter = Hiddenfield1.Value;
                char[] sep = { ',' };
                string[] newResources = selectedLetter.Split(sep, StringSplitOptions.RemoveEmptyEntries);

                foreach (Resource resource in pagedResources)
                {

                    bool isSelected = false;
                    for (int i = 0; i < newResources.Length; i++)
                    {
                        if (resource.Text != newResources[i])
                        {
                            isSelected = true;
                        }
                        else
                        {
                            isSelected = false;
                            break;
                        }
                    }
                    if (isSelected)
                    {
                       RadScheduler1.Resources.Remove(resource);
                        remainingResources.Add(resource);
                        RadCombobox1.Items.Add(new RadComboBoxItem(resource.Text));
                    }
                    else
                    {
                        RadComboBoxItem newItem = new RadComboBoxItem(resource.Text);
                        newItem.Checked = true;
                        RadCombobox1.Items.Add(newItem);
                    }
                }
              
            //    Hiddenfield1.Value = "ready";
            //}
            //else
            //{
            //    foreach (Resource resource in pagedResources)
            //    {
            //        RadCombobox1.Items.Add(new RadComboBoxItem(resource.Text));
            //    }
            //}
            Session["remainingResources"] = remainingResources;
          
      

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
                remainingResources.Clear();
                Session["remainingResources"] = remainingResources;
            }
        }
    }
   
    protected void RadButton1_Click(object sender, EventArgs e)
    {
        IList<Resource> remainingResources = Session["remainingResources"] as List<Resource>;
        int count = 0;
        Hiddenfield1.Value = null;

        foreach (RadComboBoxItem item in RadCombobox1.CheckedItems)
        {
                Hiddenfield1.Value += "," + item.Text;
                foreach (Resource res in RadScheduler1.Resources.GetResourcesByType("User"))
                {
                    remainingResources.Add(res);
                }
            
        }
        //  PageSize = rch.CheckedItems.Count;
        Session["remainingResources"] = remainingResources;

        RadScheduler1.Rebind();
    }
}
