using System;
using System.Web.UI;
using System.Web.UI.WebControls;

using Telerik.Web.UI;

namespace Telerik.GridExamplesCSharp.AJAX.ClientEditBatchUpdates
{
    public partial class DefaultCS : System.Web.UI.Page
    {

        private void SetMessage(string message)
        {
            Label1.Text = string.Format("<span>{0}</span>", message);
        }
        protected void RadGrid1_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem dataItem = (GridDataItem)e.Item;

                TextBox txtBox = (TextBox)dataItem.FindControl("txtBoxName");
                TextBoxSetting stringSetting = (TextBoxSetting)RadInputManager1.GetSettingByBehaviorID("StringBehavior");
                stringSetting.TargetControls.Add(new TargetInput(txtBox.UniqueID, true));

                txtBox = (TextBox)dataItem.FindControl("txtQuantityPerUnit");
                stringSetting.TargetControls.Add(new TargetInput(txtBox.UniqueID, true));

                txtBox = (TextBox)dataItem.FindControl("txtUnitPrice");
                NumericTextBoxSetting currencySetting = (NumericTextBoxSetting)RadInputManager1.GetSettingByBehaviorID("CurrencyBehavior");
                currencySetting.TargetControls.Add(new TargetInput(txtBox.UniqueID, true));

                txtBox = (TextBox)dataItem.FindControl("txtUnitsOnOrder");
                NumericTextBoxSetting numericSetting = (NumericTextBoxSetting)RadInputManager1.GetSettingByBehaviorID("NumberBehavior");
                numericSetting.TargetControls.Add(new TargetInput(txtBox.UniqueID, true));
            }
        }

        protected void RadAjaxManager1_AjaxRequest(object sender, Web.UI.AjaxRequestEventArgs e)
        {
            if (e.Argument == string.Empty)
            {
                RadGrid1.Rebind();
            }
            string[] editedItemIds = e.Argument.Split(':');
            int i;
            for (i = 0; i <= editedItemIds.Length - 2; i++)
            {
                string productId = editedItemIds[i];
                GridDataItem updatedItem = RadGrid1.MasterTableView.FindItemByKeyValue("ProductID", int.Parse(productId));

                UpdateValues(updatedItem);
            }
        }
        protected void UpdateValues(GridDataItem updatedItem)
        {
            TextBox txtBox = (TextBox)updatedItem.FindControl("txtBoxName");
            SqlDataSource1.UpdateParameters["ProductName"].DefaultValue = txtBox.Text;

            txtBox = (TextBox)updatedItem.FindControl("txtQuantityPerUnit");
            SqlDataSource1.UpdateParameters["QuantityPerUnit"].DefaultValue = txtBox.Text;

            txtBox = (TextBox)updatedItem.FindControl("txtUnitPrice");
            SqlDataSource1.UpdateParameters["UnitPrice"].DefaultValue = txtBox.Text;

            txtBox = (TextBox)updatedItem.FindControl("txtUnitsOnOrder");
            SqlDataSource1.UpdateParameters["UnitsOnOrder"].DefaultValue = txtBox.Text;

            DropDownList ddl = (DropDownList)updatedItem.FindControl("ddlUnitsInStock");
            SqlDataSource1.UpdateParameters["UnitsInStock"].DefaultValue = ddl.SelectedValue;

            CheckBox chkBox = (CheckBox)updatedItem.FindControl("chkBoxDiscontinued");
            SqlDataSource1.UpdateParameters["Discontinued"].DefaultValue = chkBox.Checked.ToString();

            SqlDataSource1.UpdateParameters["ProductID"].DefaultValue = updatedItem.GetDataKeyValue("ProductID").ToString();

            try
            {
                SqlDataSource1.Update();
            }
            catch (Exception ex)
            {
                SetMessage(Server.HtmlEncode("Unable to update Products. Reason: " + ex.StackTrace).Replace("'", "&#39;").Replace("\r\n", "<br />"));
            }
            SetMessage("Product with ID: " + updatedItem.GetDataKeyValue("ProductID") + " updated");

        }
}
}
