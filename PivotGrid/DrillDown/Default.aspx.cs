using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;


public partial class _Default : System.Web.UI.Page
{
    List<PivotGridField> rowFields;
    List<PivotGridField> columnFields;
    List<PivotGridField> aggregateFields;
    int index = 0;
    int[] allFakeColumnCells = null;
    bool isFirstDataCell = true;
    int countOfFakeRowCells = 0;
    int cellsCount = 0;
    string firstRowID = string.Empty;
    string currentRowID = string.Empty;
    int key = 0;

    public Dictionary<int, string> Arguments
    {
        get
        {
            if (Session["Arguments"] == null)
            {
                Session["Arguments"] = new Dictionary<int, string>();
            }

            return Session["Arguments"] as Dictionary<int, string>;
        }
        set
        {
            Session["Arguments"] = value;
        }
    }

    public DataTable GridDataSource
    {
        get
        {
            return Session["GridDataSource"] as DataTable;
        }
        set
        {
            Session["GridDataSource"] = value;
        }
    }

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);

        RadPivotGrid1.CellDataBound += RadPivotGrid1_CellDataBound;
        RadPivotGrid1.DataBinding += RadPivotGrid1_DataBinding;
        RadPivotGrid1.ItemCommand += RadPivotGrid1_ItemCommand;
        RadAjaxPanel1.AjaxRequest += RadAjaxPanel1_AjaxRequest;
    }

    void RadPivotGrid1_DataBinding(object sender, EventArgs e)
    {
        Arguments.Clear();
    }

    void RadPivotGrid1_ItemCommand(object sender, PivotGridCommandEventArgs e)
    {
        RadWindow1.VisibleOnPageLoad = false;
    }

    void RadAjaxPanel1_AjaxRequest(object sender, AjaxRequestEventArgs e)
    {
        StringBuilder whereClause = new StringBuilder();
        if (!string.IsNullOrEmpty(e.Argument.ToString()))
        {
            string[] elements = e.Argument.ToString().Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);
            foreach (var element in elements)
            {
                var group = element.Split(new char[] { '~' }, StringSplitOptions.RemoveEmptyEntries);
                int firstPart = Convert.ToInt32(group[0]);
                int secondPart = Convert.ToInt32(group[1]);
                whereClause.Append(string.Format("{0} = '{1}' AND ", Arguments[firstPart], Arguments[secondPart]));
            }

            // Remove the last " AND " clause
            whereClause.Remove(whereClause.Length - 5, 5);

            GridDataSource = GetDataTable(string.Format("SELECT * FROM Transportation WHERE {0}", whereClause.ToString()));
        }
        //Executed when row and column grandtotal cell is clicked
        else
        {
            GridDataSource = GetDataTable("SELECT * FROM Transportation");
        }

        RadWindow1.VisibleOnPageLoad = true;
        RadGrid1.Rebind();
    }

    void RadPivotGrid1_CellDataBound(object sender, PivotGridCellDataBoundEventArgs e)
    {
        PivotGridDataCell cell = e.Cell as PivotGridDataCell;

        if (cell != null)
        {
            // If this is the first data cell we need to populate the collecion which fake columns cells count
            if (isFirstDataCell)
            {
                PopulateFakeColumnsCellCollection(cell);
                isFirstDataCell = false;
            }
            // We do not need to attach onclick event on cell which does not have values
            if (cell.DataItem != null)
            {
                string argument = GetCommandArguments(cell);
                string script = string.Format("OpenDetailsWindow('{0}')", argument);
                cell.Attributes.Add("onclick", script);
            }
            index++;
        }
    }

    // This methos is executed only for the first cell from the first row
    private void PopulateFakeColumnsCellCollection(PivotGridDataCell cell)
    {
        PivotGridDataItem item = cell.NamingContainer as PivotGridDataItem;
        cellsCount = item.Cells.Count;
        allFakeColumnCells = new int[cellsCount];
        firstRowID = item.UniqueID;

        for (int i = 0; i < cellsCount; i++)
        {
            int countOfFakeCells = GetCountOfFakeColumnCells(item.Cells[i] as PivotGridDataCell);
            allFakeColumnCells[i] = countOfFakeCells;
        }
    }

    protected override void OnLoad(EventArgs e)
    {
        base.OnLoad(e);
        //Get all row, column and aggregate fields. If the drag-drop field functionality is enabled this needs to be performed every time when fields are reordered. 
        rowFields = RadPivotGrid1.Fields.Where(f =>
         f is PivotGridRowField && f.IsHidden == false).OrderBy(f => f.ZoneIndex).ToList();
        columnFields = RadPivotGrid1.Fields.Where(f =>
             f is PivotGridColumnField && f.IsHidden == false).OrderBy(f => f.ZoneIndex).ToList();
        aggregateFields = RadPivotGrid1.Fields.Where(f =>
             f is PivotGridAggregateField && f.IsHidden == false).OrderBy(f => f.ZoneIndex).ToList();
    }

    public string GetCommandArguments(PivotGridDataCell cell)
    {
        // True when first cell of each row is hit
        if (currentRowID != cell.NamingContainer.UniqueID)
        {
            index = 0;
            currentRowID = cell.NamingContainer.UniqueID;
            countOfFakeRowCells = GetCountOfFakeRowCells(cell);
        }

        object[] rowIndexes = cell.ParentRowIndexes;
        object[] columnIndexes = cell.ParentColumnIndexes;

        int rowIndexesCount = rowIndexes.Count();
        int columnIndexesCount = columnIndexes.Count();

        int countOfFakeColumnCells = allFakeColumnCells[index];

        rowIndexesCount -= countOfFakeRowCells;
        columnIndexesCount -= countOfFakeColumnCells;

        StringBuilder buider = BuildArguments(rowIndexes, columnIndexes, rowIndexesCount, columnIndexesCount);

        return buider.ToString();
    }

    private StringBuilder BuildArguments(object[] rowIndexes, object[] columnIndexes, int rowIndexesCount, int columnIndexesCount)
    {
        StringBuilder buider = new StringBuilder();

        ReplaceArgumentsWithNumbers(rowIndexes, rowFields, rowIndexesCount, buider);
        ReplaceArgumentsWithNumbers(columnIndexes, columnFields, columnIndexesCount, buider);

        // Remove the semicolon in the end 
        if (buider.Length > 1)
        {
            buider.Remove(buider.Length - 1, 1);
        }

        return buider;
    }

    private void ReplaceArgumentsWithNumbers(object[] cellIndexes, List<PivotGridField> fields, int indexesCount, StringBuilder buider)
    {
        for (int i = 0; i < indexesCount; i++)
        {
            string firstPart = fields[i].DataField;
            string secondPart = cellIndexes[i].ToString();
            if (Arguments.ContainsValue(firstPart))
            {
                buider.Append(Arguments.FirstOrDefault(a => a.Value == firstPart).Key);
                AppendSecondParts(buider, secondPart);
            }
            else
            {
                Arguments.Add(key, firstPart);
                buider.Append(string.Format("{0}", key.ToString()));
                key++;
                AppendSecondParts(buider, secondPart);
            }
        }
    }

    private void AppendSecondParts(StringBuilder buider, string secondPart)
    {
        if (Arguments.ContainsValue(secondPart))
        {
            buider.Append(string.Format("~{0};", Arguments.FirstOrDefault(a => a.Value == secondPart).Key));
        }
        else
        {
            Arguments.Add(key, secondPart);
            buider.Append(string.Format("~{0};", key.ToString()));
            key++;
        }
    }

    private int GetCountOfFakeColumnCells(PivotGridDataCell cell)
    {
        int count = 0;
        if (aggregateFields.Count > 1)
        {
            if (RadPivotGrid1.AggregatesPosition == PivotGridAxis.Columns)
            {
                if (cell.CellType == PivotGridDataCellType.DataCell ||
                    cell.CellType == PivotGridDataCellType.RowTotalDataCell ||
                    cell.CellType == PivotGridDataCellType.RowAndColumnTotal ||
                    cell.CellType == PivotGridDataCellType.RowGrandTotalDataCell ||
                    cell.CellType == PivotGridDataCellType.ColumnGrandTotalRowTotal)
                {
                    count++;
                }
            }
        }

        // if column total or grand total cell is hit we need to escape its values from query
        if (cell.CellType == PivotGridDataCellType.ColumnTotalDataCell ||
            cell.CellType == PivotGridDataCellType.RowAndColumnTotal ||
            cell.CellType == PivotGridDataCellType.ColumnGrandTotalRowTotal ||
            cell.CellType == PivotGridDataCellType.ColumnGrandTotalDataCell ||
            cell.CellType == PivotGridDataCellType.RowGrandTotalColumnTotal)
        {
            count++;
        }

        return count;
    }

    private int GetCountOfFakeRowCells(PivotGridDataCell cell)
    {
        int count = 0;
        //if aggregates are more than one additional cells are rendered, so we need to exclude their values from the query
        if (aggregateFields.Count > 1)
        {
            if (RadPivotGrid1.AggregatesPosition == PivotGridAxis.Rows)
            {
                if (cell.CellType != PivotGridDataCellType.RowTotalDataCell &&
                    cell.CellType != PivotGridDataCellType.ColumnGrandTotalRowTotal)
                {
                    count++;
                }
            }
        }

        // if row total or grand total cell is hit we need to escape its values from query
        if (cell.CellType == PivotGridDataCellType.RowTotalDataCell ||
            cell.CellType == PivotGridDataCellType.ColumnGrandTotalRowTotal ||
            cell.CellType == PivotGridDataCellType.RowGrandTotalDataCell)
        {
            count++;
        }

        return count;
    }

    protected void RadPivotGrid1_NeedDataSource(object sender, PivotGridNeedDataSourceEventArgs e)
    {
        (sender as RadPivotGrid).DataSource = GetDataTable("SELECT * FROM Transportation");
    }

    public DataTable GetDataTable(string query)
    {
        String ConnString = ConfigurationManager.ConnectionStrings["TelerikConnectionString"].ConnectionString;
        SqlConnection conn = new SqlConnection(ConnString);
        SqlDataAdapter adapter = new SqlDataAdapter();
        adapter.SelectCommand = new SqlCommand(query, conn);

        DataTable myDataTable = new DataTable();

        conn.Open();
        try
        {
            adapter.Fill(myDataTable);
        }
        finally
        {
            conn.Close();
        }

        return myDataTable;
    }

    protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        RadGrid1.DataSource = GridDataSource;
    }
}