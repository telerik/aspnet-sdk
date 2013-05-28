using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class PivotGrid_Examples_Templates_TemplateInfoCS : System.Web.UI.UserControl
{
    static readonly int MinimumQuantity = 40;
    private PivotGridCell container;
    private string fieldName;

    public string TemplateName { get; set; }

    public PivotGridCell Container
    {
        get
        {
            if (container == null)
                container = Parent as PivotGridCell;
            return container;
        }
    }

    public string FieldName
    {
        get
        {
            if (fieldName == null)
                fieldName = Container.Field != null ? Container.Field.UniqueName : "n/a";
            return fieldName;
        }
    }

    protected string GetCellText()
    {
        object dataItemValue = Container.DataItem;
        string dataItemText;

        //set custom format string and horizontal alignment for decimal types
        if (dataItemValue is decimal)
        {
            dataItemText = ((decimal)dataItemValue).ToString("F2");
            Container.HorizontalAlign = HorizontalAlign.Right;
        }
        else
        {
            dataItemText = (dataItemValue ?? "").ToString();
        }

        if (FieldName == "Quantity" && dataItemValue is long && (long)dataItemValue < MinimumQuantity)
        {
            //change the back & fore colors of the cell when Quantity is less than 40
            Container.BackColor = System.Drawing.Color.FromArgb(255, 220, 255);
            Container.ForeColor = System.Drawing.Color.Black;

            //display exclamation mark when Quantity is less than 40 
            dataItemText += " (!)";
        }

        return dataItemText;
    }

    protected string GetToolTipContent()
    {
        string fieldType = String.Empty;

        switch (Container.GetType().Name)
        {
            case "PivotGridDataCell": fieldType = "Aggregate"; break;
            case "PivotGridRowHeaderCell": fieldType = "Row"; break;
            case "PivotGridColumnHeaderCell": fieldType = "Column"; break;
        }

        return String.Format("<b>Template:</b> {0}<br/><b>FieldName:</b> {1}<br/><b>Value:</b> {2}<br/><b>FieldType:</b> {3}", TemplateName, FieldName, container.DataItem, fieldType);
    }
}