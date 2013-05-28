using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using xls = Telerik.Web.UI.ExportInfrastructure;

public partial class ThreeRadGridsExport : System.Web.UI.Page
{
    private xls.ExportStructure structure = new xls.ExportStructure();
    private xls.Table table = new xls.Table();
    private int row = 1;
    private int col = 1;
    private List<RadGrid> gridControlsFound = new List<RadGrid>();

    protected void Button1_Click(object sender, EventArgs e)
    {
        FindGridsRecursive(Page);
        ExportGrid();        
    }

    private void FindGridsRecursive(Control control)
    {
        foreach (Control childControl in control.Controls)
        {
            if (childControl is RadGrid)
            {
                gridControlsFound.Add((RadGrid)childControl);
            }
            else
            {
                FindGridsRecursive(childControl);
            }
        }
    }

    bool isFirstItem = true;    
    private void GenerateTable(RadGrid grid, xls.Table singleTable)
    {
        if (ExportingType.SelectedValue == "1")
        {
            singleTable = new xls.Table(grid.ID);
            row = 1;
            col = 1;
        }
        else
        {
            if (!isFirstItem)
                row++;
            else
                isFirstItem = false;
        }

        GridHeaderItem headerItem = grid.MasterTableView.GetItems(GridItemType.Header)[0] as GridHeaderItem;

        for (int i = 2; i < headerItem.Cells.Count; i++)
        {
            singleTable.Cells[i - 1, row].Value = headerItem.Cells[i].Text;
        }

        row++;

        foreach (GridDataItem item in grid.MasterTableView.Items)
        {
            foreach (GridColumn column in grid.Columns)
            {
                singleTable.Cells[col, row].Value = item[column.UniqueName].Text;
                col++;
            }
            col = 1;
            row++;
        }

        if (ExportingType.SelectedValue == "1")
        {
            structure.Tables.Add(singleTable);            
        }
    }

    private void ExportGrid()
    {
        foreach (RadGrid grid in gridControlsFound)
        {
            grid.AllowPaging = false;
            grid.CurrentPageIndex = 0;
            grid.Rebind();
            GenerateTable(grid, table);
        }
        if (ExportingType.SelectedValue == "2")
        {
            structure.Tables.Add(table);
        }

        xls.XlsBiffRenderer renderer = new xls.XlsBiffRenderer(structure);
        byte[] renderedBytes = renderer.Render();
        Response.Clear();
        Response.AppendHeader("Content-Disposition:", "attachment; filename=ExportFile.xls");
        Response.ContentType = "application/vnd.ms-excel";
        Response.BinaryWrite(renderedBytes);
        Response.End();
    }    
}