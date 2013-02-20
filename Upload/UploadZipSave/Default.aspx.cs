using System;
using System.IO;
using System.Linq;
using Telerik.Web.UI;
using Telerik.Web.Zip;

public partial class _Default : System.Web.UI.Page
{
    public const string TargetFolder = "TargetFolder";
    public const string ZipExtenson = "zip";

    protected ZipPackage Package { get; set; }
    protected bool PackageInitialized { get; set; }
    protected string PackageName { get; set; }


    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (PackageInitialized)
        {
            UpdateStatus();
            ClosePackage();
        }
    }

    protected void RadAsyncUpload1_FileUploaded(object sender, Telerik.Web.UI.FileUploadedEventArgs e)
    {
        InitPackage();
        Push(e.File);
    }

    public void Push(UploadedFile file)
    {
        Package.AddStream(file.InputStream, file.GetName());
    }

    protected virtual void InitPackage()
    {
        if (!PackageInitialized)
        {
            PackageName = GetFullFilePath(GetArchiveName());
            var stream = File.Create(PackageName);
            Package = ZipPackage.Create(stream);
            PackageInitialized = true;
        }
    }

    protected virtual void ClosePackage()
    {
        Package.Close(true);
    }

    protected virtual void UpdateStatus()
    {
        Status.Text = string.Format("Package saved to: {0}", Path.Combine(PackageName));
    }

    protected string GetArchiveName()
    {
        var t = PackageNameInput.Text;
        return !string.IsNullOrEmpty(t) ? t : DateTime.Now.ToString("ddMMyyyy");
    }

    protected string GetTargetFolder()
    {
        return Server.MapPath(TargetFolder);
    }

    protected string GetFullFilePath(string fileName)
    {
        return Path.ChangeExtension(Path.Combine(GetTargetFolder(), fileName), ZipExtenson);
    }
}