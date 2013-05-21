Imports System

Imports Telerik.Web.UI
Imports System.Collections

Namespace Telerik.GridExamplesVBNET.AJAX.ClientEditBatchUpdates

    Partial Public MustInherit Class DefaultVB
        Inherits System.Web.UI.Page

        Private Sub SetMessage(ByVal message As String)
            Label1.Text = String.Format("<span>{0}</span>", message)
        End Sub
        Protected Sub RadGrid1_ItemCreated(ByVal sender As Object, ByVal e As GridItemEventArgs) Handles RadGrid1.ItemCreated
            If TypeOf e.Item Is GridDataItem Then
                Dim dataItem As GridDataItem = CType(e.Item, GridDataItem)

                Dim txtBox As TextBox = CType(dataItem.FindControl("txtBoxName"), TextBox)
                Dim stringSetting As TextBoxSetting = DirectCast(RadInputManager1.GetSettingByBehaviorID("StringBehavior"), TextBoxSetting)
                stringSetting.TargetControls.Add(New TargetInput(txtBox.UniqueID, True))

                txtBox = CType(dataItem.FindControl("txtQuantityPerUnit"), TextBox)
                stringSetting.TargetControls.Add(New TargetInput(txtBox.UniqueID, True))

                txtBox = CType(dataItem.FindControl("txtUnitPrice"), TextBox)
                Dim currencySetting As NumericTextBoxSetting = DirectCast(RadInputManager1.GetSettingByBehaviorID("CurrencyBehavior"), NumericTextBoxSetting)
                currencySetting.TargetControls.Add(New TargetInput(txtBox.UniqueID, True))

                txtBox = CType(dataItem.FindControl("txtUnitsOnOrder"), TextBox)
                Dim numericSetting As NumericTextBoxSetting = DirectCast(RadInputManager1.GetSettingByBehaviorID("NumberBehavior"), NumericTextBoxSetting)
                numericSetting.TargetControls.Add(New TargetInput(txtBox.UniqueID, True))
            End If
        End Sub

        Protected Sub RadAjaxManager1_AjaxRequest(ByVal sender As Object, ByVal e As Web.UI.AjaxRequestEventArgs) Handles RadAjaxManager1.AjaxRequest
            If e.Argument = String.Empty Then
                RadGrid1.Rebind()
            End If
            Dim editedItemIds As String() = e.Argument.Split(":")
            Dim i As Integer
            For i = 0 To editedItemIds.Length - 2
                Dim productId As String = editedItemIds(i)
                Dim updatedItem As GridDataItem = RadGrid1.MasterTableView.FindItemByKeyValue("ProductID", Integer.Parse(productId))

                UpdateValues(updatedItem)
            Next
        End Sub
        Protected Sub UpdateValues(ByVal updatedItem As GridDataItem)
            Dim txtBox As TextBox = CType(updatedItem.FindControl("txtBoxName"), TextBox)
            SqlDataSource1.UpdateParameters("ProductName").DefaultValue = txtBox.Text

            txtBox = CType(updatedItem.FindControl("txtQuantityPerUnit"), TextBox)
            SqlDataSource1.UpdateParameters("QuantityPerUnit").DefaultValue = txtBox.Text

            txtBox = CType(updatedItem.FindControl("txtUnitPrice"), TextBox)
            SqlDataSource1.UpdateParameters("UnitPrice").DefaultValue = txtBox.Text

            txtBox = CType(updatedItem.FindControl("txtUnitsOnOrder"), TextBox)
            SqlDataSource1.UpdateParameters("UnitsOnOrder").DefaultValue = txtBox.Text

            Dim ddl As DropDownList = CType(updatedItem.FindControl("ddlUnitsInStock"), DropDownList)
            SqlDataSource1.UpdateParameters("UnitsInStock").DefaultValue = ddl.SelectedValue

            Dim chkBox As CheckBox = CType(updatedItem.FindControl("chkBoxDiscontinued"), CheckBox)
            SqlDataSource1.UpdateParameters("Discontinued").DefaultValue = chkBox.Checked

            SqlDataSource1.UpdateParameters("ProductID").DefaultValue = updatedItem.GetDataKeyValue("ProductID").ToString()

            Try
                SqlDataSource1.Update()
            Catch ex As Exception
                SetMessage(Server.HtmlEncode("Unable to update Products. Reason: " + ex.StackTrace).Replace("'", "&#39;").Replace(vbCrLf, "<br />"))
            End Try
            SetMessage("Product with ID: " & updatedItem.GetDataKeyValue("ProductID") & " updated")

        End Sub
    End Class
End Namespace