using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataContext;
using Telerik.Web.UI;
using Telerik.Web.Zip;

public partial class _Default : System.Web.UI.Page
{
    private DataClassesDataContext context;
    protected ZipPackage Package { get; set; }

    protected override void OnLoad(EventArgs e)
    {
        base.OnLoad(e);

        if (!Page.IsPostBack)
        {
            if (ListViewAlbums.SelectedIndexes.Count == 0)
            {
                ListViewAlbums.SelectedIndexes.Add(0);
                HiddenFieldSelectedItem.Value = "0";
            }
        }
    }
    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        context = new DataClassesDataContext();
        ListViewAlbums.NeedDataSource += ListViewAlbums_NeedDataSource;
        ListViewAlbums.ItemInserting += ListViewAlbums_ItemInserting;
        ListViewAlbums.ItemUpdating += ListViewAlbums_ItemUpdating;
        ListViewAlbums.ItemDeleting += ListViewAlbums_ItemDeleting;

        ImagesListView.NeedDataSource += ImagesListView_NeedDataSource;
        ImagesListView.ItemCommand += ImagesListView_ItemCommand;
        ImagesListView.ItemDeleting += ImagesListView_ItemDeleting;
        ImagesListView.ItemUpdating += ImagesListView_ItemUpdating;

        RadAjaxPanel1.AjaxRequest += RadAjaxPanel1_AjaxRequest;
    }

    void ImagesListView_ItemUpdating(object sender, RadListViewCommandEventArgs e)
    {
        var dataItem = e.ListViewItem as RadListViewDataItem;
        int imageId = Convert.ToInt32(dataItem.GetDataKeyValue("ID").ToString());
        DataContext.Image image = (from a in context.Images
                                   where a.ID == imageId
                                   select a).First();

        RadAsyncUpload radUpload = (e.ListViewItem.FindControl("RadAsyncUpload1") as RadAsyncUpload);
        if (radUpload.UploadedFiles.Count > 0)
        {
            UploadedFile file = radUpload.UploadedFiles[0];
            byte[] data = new byte[file.InputStream.Length];
            file.InputStream.Read(data, 0, (int)file.InputStream.Length);

            image.Data = data;

            context.SubmitChanges();
        }
    }

    void ImagesListView_ItemDeleting(object sender, RadListViewCommandEventArgs e)
    {
        RadListViewDataItem deletedItem = e.ListViewItem as RadListViewDataItem;
        int imageId = Convert.ToInt32(deletedItem.GetDataKeyValue("ID").ToString());
        DataContext.Image image = (from i in context.Images
                                   where i.ID == imageId
                                   select i).First();

        context.Images.DeleteOnSubmit(image);
        context.SubmitChanges();
    }

    void ListViewAlbums_ItemDeleting(object sender, RadListViewCommandEventArgs e)
    {
        RadListViewDataItem deletedItem = e.ListViewItem as RadListViewDataItem;
        int albumID = Convert.ToInt32(deletedItem.GetDataKeyValue("ID").ToString());
        Album album = (from a in context.Albums
                       where a.ID == albumID
                       select a).First();
        context.Images.DeleteAllOnSubmit(album.Images.ToList());
        context.Albums.DeleteOnSubmit(album);
        context.SubmitChanges();

        RadListViewDataItem selectedItem = ListViewAlbums.SelectedItems[0] as RadListViewDataItem;
        if (deletedItem == selectedItem)
        {
            ListViewAlbums.SelectedIndexes.Clear();
            ListViewAlbums.SelectedIndexes.Add(0);

            ImagesListView.Rebind();
        }
    }

    void ListViewAlbums_ItemUpdating(object sender, RadListViewCommandEventArgs e)
    {
        var dataItem = e.ListViewItem as RadListViewDataItem;
        int albumID = Convert.ToInt32(dataItem.GetDataKeyValue("ID").ToString());
        Album album = (from a in context.Albums
                       where a.ID == albumID
                       select a).First();

        UpdateAlbum(e, album);

        context.SubmitChanges();
    }

    private static void UpdateAlbum(RadListViewCommandEventArgs e, Album album)
    {
        album.Name = (e.ListViewItem.FindControl("TextBox1") as TextBox).Text;
        album.Description = (e.ListViewItem.FindControl("TextBox2") as TextBox).Text;
        RadAsyncUpload uploadThumbnail = (e.ListViewItem.FindControl("RadAsyncUpload1") as RadAsyncUpload);

        if (uploadThumbnail.UploadedFiles.Count > 0)
        {
            UploadedFile file = uploadThumbnail.UploadedFiles[0];
            byte[] thumbnailData = new byte[file.InputStream.Length];
            file.InputStream.Read(thumbnailData, 0, (int)file.InputStream.Length);

            album.Thumbnail = thumbnailData;
        }
    }

    void ImagesListView_ItemCommand(object sender, RadListViewCommandEventArgs e)
    {
        if (e.CommandName == "DownloadAllAsZip")
        {
            RadListViewDataItem item = ListViewAlbums.SelectedItems[0];
            int parentID = Convert.ToInt32(item.GetDataKeyValue("ID").ToString());
            string albumName = item.GetDataKeyValue("Name").ToString();
            List<DataContext.Image> allImagesFromAlbum = (from a in context.Images
                                                          where a.AlbumID == parentID
                                                          select a).ToList();

            MemoryStream memStream = new MemoryStream();

            Package = ZipPackage.Create(memStream);

            foreach (var image in allImagesFromAlbum)
            {
                Stream stream = new MemoryStream(image.Data);
                Package.AddStream(stream, image.FileName);
            }

            Package.Close(false);

            memStream.Position = 0;

            if (memStream != null && memStream.Length > 0)
            {
                Response.Clear();
                Response.AddHeader("content-disposition", "attachment; filename=" + albumName + ".zip");
                Response.ContentType = "application/zip";
                Response.BinaryWrite(memStream.ToArray());
                Response.End();
            }
        }
        if (e.CommandName == "DownloadImage")
        {
            RadListViewDataItem item = e.ListViewItem as RadListViewDataItem;
            int imageID = Convert.ToInt32(item.GetDataKeyValue("ID").ToString());
            DataContext.Image image = (from i in context.Images
                                       where i.ID == imageID
                                       select i).First();
            byte[] data = image.Data;
            string name = image.FileName;

            if (data != null && data.Length > 0)
            {
                Response.Clear();
                Response.ContentType = "application/octet-stream";
                Response.AddHeader("content-disposition", "attachment; filename=" + name);
                Response.BinaryWrite(data);
                Response.End();
            }
        }
    }

    void RadAjaxPanel1_AjaxRequest(object sender, AjaxRequestEventArgs e)
    {
        int index = Convert.ToInt32(e.Argument);
        if (!ListViewAlbums.SelectedIndexes.Contains(index))
        {
            ListViewAlbums.SelectedIndexes.Clear();
            ListViewAlbums.SelectedIndexes.Add(index);
            ImagesListView.EditIndexes.Clear();
            ListViewAlbums.Rebind();
            ImagesListView.Rebind();
        }
    }

    void ImagesListView_NeedDataSource(object sender, RadListViewNeedDataSourceEventArgs e)
    {
        RadListViewDataItem item = ListViewAlbums.SelectedItems[0];
        int parentID = Convert.ToInt32(item.GetDataKeyValue("ID").ToString());
        labelAlbumName.Text = item.GetDataKeyValue("Name").ToString();
        ImagesListView.DataSource = from a in context.Images
                                    where a.AlbumID == parentID
                                    select a;
    }

    void ListViewAlbums_ItemInserting(object sender, Telerik.Web.UI.RadListViewCommandEventArgs e)
    {
        Album album = new Album();

        UpdateAlbum(e, album);

        context.Albums.InsertOnSubmit(album);

        RadAsyncUpload uploadAllImages = (e.ListViewItem.FindControl("RadAsyncUpload2") as RadAsyncUpload);
        if (uploadAllImages.UploadedFiles.Count > 0)
        {
            UploadedFile zipFile = uploadAllImages.UploadedFiles[0];
            using (ZipPackage zipPackage = ZipPackage.Open(zipFile.InputStream, FileAccess.Read))
            {
                List<ZipPackageEntry> allEntries = zipPackage.ZipPackageEntries.ToList();
                foreach (ZipPackageEntry entry in allEntries)
                {
                    byte[] imageData = new byte[entry.UncompressedSize];
                    entry.OpenInputStream().Read(imageData, 0, entry.UncompressedSize);

                    DataContext.Image image = new DataContext.Image();
                    image.AlbumID = album.ID;
                    image.FileName = entry.FileNameInZip;
                    image.Data = imageData;

                    album.Images.Add(image);
                }
            }
        }

        context.SubmitChanges();
    }

    void ListViewAlbums_NeedDataSource(object sender, Telerik.Web.UI.RadListViewNeedDataSourceEventArgs e)
    {
        ListViewAlbums.DataSource = from a in context.Albums
                                    select a;
    }

    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);

        if (ListViewAlbums.IsItemInserted)
        {
            ListViewAlbums.FindControl("Button1").Visible = false;
        }
        else
        {
            ListViewAlbums.FindControl("Button1").Visible = true;
        }
    }
}