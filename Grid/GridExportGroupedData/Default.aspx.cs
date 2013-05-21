using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xls = Telerik.Web.UI.ExportInfrastructure;
using Telerik.Web.UI;

public partial class RadGridBiffExport : System.Web.UI.Page
{    
    private xls.Table table = new xls.Table();
    private int row = 1;
    private int currentHeaderItemIndex = 0;

    protected void ExportButton_Click(object sender, ImageClickEventArgs e)
    {
        RadGrid1.CurrentPageIndex = 0;
        RadGrid1.AllowPaging = false;        
        RadGrid1.Rebind();
        TraverseGridStructure();
        ExportGrid();
    }

    private void TraverseGridStructure()
    {
        GridHeaderItem headers = RadGrid1.MasterTableView.GetItems(GridItemType.Header)[0] as GridHeaderItem;
        int startIndex = RadGrid1.MasterTableView.GroupByExpressions.Count + 2;
        for (int i = startIndex; i < headers.Cells.Count; i++)
        {
            table.Cells[i - 1, row].Value = headers.Cells[i].Text;
        }
        row++;

        GridItem[] headerCollection = RadGrid1.MasterTableView.GetItems(GridItemType.GroupHeader);
        foreach (GridDataItem item in RadGrid1.MasterTableView.Items)
        {
            string[] groupIndexArray = item.GroupIndex.Split('_');
            TraverseHeaderItems(headerCollection, groupIndexArray);

            for (int i = groupIndexArray.Length + 1; i < item.Controls.Count; i++)
            {
                table.Cells[i - 1, row].Value = (item.Controls[i] as GridTableCell).Text;
            }
            row++;
        }
    }

    private void TraverseHeaderItems(GridItem[] headerCollection, string[] groupIndexArray)
    {
        if (currentHeaderItemIndex == headerCollection.Length)
        {
            return;
        }
        string[] headerIndex = headerCollection[currentHeaderItemIndex].GroupIndex.Split('_');

        for (int j = 0; j < headerIndex.Length; j++)
        {
            if (headerIndex[j] != groupIndexArray[j])
            {
                return;
            }
        }

        GridGroupHeaderItem currentHeaderItem = headerCollection[currentHeaderItemIndex] as GridGroupHeaderItem;
        table.Cells[headerIndex.Length, row].Value = currentHeaderItem.DataCell.Text;
        currentHeaderItemIndex++;
        row++;
        TraverseHeaderItems(headerCollection, groupIndexArray);
    }

    private void ExportGrid()
    {
        xls.ExportStructure structure = new xls.ExportStructure();
        structure.Tables.Add(table);
        xls.XlsBiffRenderer renderer = new xls.XlsBiffRenderer(structure);
        byte[] renderedBytes = renderer.Render();

        Response.Clear();
        Response.AppendHeader("Content-Disposition:", "attachment; filename=ExportFile.xls");
        Response.ContentType = "application/vnd.ms-excel";
        Response.BinaryWrite(renderedBytes);
        Response.End();
    }
    
}