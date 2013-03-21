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
using System.Linq;
using System.IO;
using System.Text;
using System.Net;

public partial class Default : System.Web.UI.Page
{
    private readonly int WesternEuropean = 1252;
    private string fileName = "RadGridServerExportDemo";
    private readonly string[] fileExtensions = new string[] { ".xls", ".pdf", ".doc", ".csv" };
    private FileInfo fileInfo = null;

    private bool IsExported
    {
        get
        {
            if (fileInfo == null) return false;
            else return File.Exists(fileInfo.FullName);
        }
    }

    private string PhysicalPathToFile
    {
        get { return Server.MapPath("~/" + fileName); }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fileInfo = GetLastExportedFile();
            ShowLastExportedDateForCurrentFormat();
            RadComboBox1.SelectedValue = fileInfo != null ? fileInfo.Extension.Remove(0, 1).ToUpper() : "XLS";
        }
    }

    protected FileInfo GetLastExportedFile()
    {
        DateTime currentTime = DateTime.MinValue;
        FileInfo newestFile = null;

        foreach (string currentfileExtension in fileExtensions)
        {
            FileInfo currentFile = new FileInfo(PhysicalPathToFile + currentfileExtension);
            if (currentFile.Exists)
            {
                if (currentFile.LastWriteTime > currentTime)
                {
                    currentTime = currentFile.LastWriteTime;
                    newestFile = new FileInfo(currentFile.FullName);
                }
            }
        }

        if (newestFile == null)
            return null;

        return newestFile;
    }

    protected void ButtonExport_Click(object sender, EventArgs e)
    {
        switch (RadComboBox1.SelectedValue.ToLower())
        {
            case "xls": RadGrid1.MasterTableView.ExportToExcel(); break;
            case "pdf": RadGrid1.MasterTableView.ExportToPdf(); break;
            case "doc": RadGrid1.MasterTableView.ExportToWord(); break;
            case "csv": RadGrid1.MasterTableView.ExportToCSV(); break;
        }
    }

    protected void RadGrid1_GridExporting(object sender, GridExportingArgs e)
    {
        using (FileStream fs = new FileStream(String.Format("{0}.{1}", PhysicalPathToFile, RadComboBox1.SelectedValue), FileMode.Create))
        {
            byte[] output = Encoding.GetEncoding(WesternEuropean).GetBytes(e.ExportOutput);
            fs.Write(output, 0, output.Length);
        }

        Response.Redirect(Request.Url.GetLeftPart(UriPartial.Path).ToString());
    }

    protected void FileStream_Click(object sender, EventArgs e)
    {
        fileInfo = new FileInfo(PhysicalPathToFile + "." + RadComboBox1.SelectedValue);
        FileInfo exportedFile = new FileInfo(PhysicalPathToFile + fileInfo.Extension);

        if (fileInfo.Exists)
        {
            Response.Clear();
            Response.AppendHeader("Content-Disposition:", "attachment; filename=" + fileInfo.Name);
            Response.AppendHeader("Content-Length", fileInfo.Length.ToString());
            Response.ContentType = SetMimeType(exportedFile.Extension);
            Response.TransmitFile(fileInfo.FullName);
            Response.End();
        }
    }

    private string SetMimeType(string fileExt)
    {
        string mimeType = String.Empty;
        switch (fileExt.ToLower())
        {
            case ".xls": mimeType = "application/vnd.ms-excel"; break;
            case ".pdf": mimeType = "application/pdf"; break;
            case ".doc": mimeType = "application/msword"; break;
            case ".csv": mimeType = "text/csv"; break;
        }

        return mimeType;
    }

    protected void RadComboBox1_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        fileInfo = new FileInfo(PhysicalPathToFile + "." + RadComboBox1.SelectedValue);
        ShowLastExportedDateForCurrentFormat();
    }

    private void ShowLastExportedDateForCurrentFormat()
    {
        if (IsExported)
            LastExportedDate.Text = String.Format("Last Exported {0} file: <strong>{1}</strong>", fileInfo.LastWriteTime.ToShortTimeString(), fileInfo.Name);
        else
            LastExportedDate.Text = String.Format("No Exported {0} file", RadComboBox1.SelectedValue);

        ToggleFileLinks();
    }

    private void ToggleFileLinks()
    {
        FileHyperLink.Visible = FileStream.Visible = IsExported;

        if (IsExported)
            FileHyperLink.NavigateUrl = "~/" + fileName + fileInfo.Extension;
    }
}
