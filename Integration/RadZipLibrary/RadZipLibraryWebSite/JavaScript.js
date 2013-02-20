var deletedItemIndex = null;
function conditionalPostback(sender, e)
{
    var theRegexp = new RegExp("\.ButtonDownloadAllAsZip|\.DownloadImageButton", "ig");
    if (e.get_eventTarget().match(theRegexp))
    {
        e.set_enableAjax(false);
    }
}

function selectItem(index)
{
    if (hiddenField.value != index)
    {
        hiddenField.value = index;
        ajaxpanel.ajaxRequest(index);
    }
}

function imageDivMouseOver(object)
{
    setTimeout(function ()
    {
        $(object.children[1]).show("fast");
    }, 100);
}

function imageDivMouseOut(object, e)
{
    setTimeout(function ()
    {
        if (!checkMouseCollision($(object), e))
        {
            $(object.children[1]).hide("fast");
        }
    }, 100);
}

function checkMouseCollision(obj, e)
{
    var offset = obj.offset();
    objX = offset.left;
    objY = offset.top;
    objW = obj.width() + 1;
    objH = obj.height() + 1;

    var mouseX = e.pageX;
    var mouseY = e.pageY;
    $().mousemove(function (e)
    {
        mouseX = e.pageX;
        mouseY = e.pageY;
    });

    if ((mouseX > objX && mouseX < objX + objW) && (mouseY > objY && mouseY < objY + objH))
    {
        return true;
    };

    return false;
}

function confirmCallBackFn(args)
{
    if (args)
    {
        listView.fireCommand("Delete", deletedItemIndex);
    }
}

function fireConfirm(id)
{
    deletedItemIndex = id;
    radconfirm("Delete album: Are you sure?", confirmCallBackFn, 330, 100, null, "Delete album", null);
}
function openWin(clickedImg)
{
    var imgSrc = clickedImg.src;
    imgHolder.src = imgSrc;
    previewWin.show();
}

function sizePreviewWindow()
{
    previewWin.autoSize(true);
}