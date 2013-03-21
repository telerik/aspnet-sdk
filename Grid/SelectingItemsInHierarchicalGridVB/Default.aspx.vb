Imports System.Data.SqlClient
Imports System.Data
Imports Telerik.Web.UI

Partial Class _Default
    Inherits System.Web.UI.Page

    Private ReadOnly CheckBoxId As String = "detailCheckBox"

    ''' <summary>
    ''' This HashSet stores the rows which are expanded
    ''' </summary>
    Private Property ExpandedRows() As HashSet(Of String)
        Get
            Dim obj As Object = Session("ExpandedRows")
            If obj Is Nothing Then
                Session("ExpandedRows") = New HashSet(Of String)()
            End If
            Return DirectCast(Session("ExpandedRows"), HashSet(Of String))
        End Get
        Set(value As HashSet(Of String))
            Session("ExpandedRows") = value
        End Set
    End Property

    ''' <summary>
    ''' The dictionary is used to store the selected items for each TableView
    ''' </summary>
    Private Property TableViews() As Dictionary(Of String, HashSet(Of String))
        Get
            Dim obj As Object = Session("Dictionary")
            If obj Is Nothing Then
                Session("Dictionary") = New Dictionary(Of String, HashSet(Of String))()
            End If
            Return DirectCast(Session("Dictionary"), Dictionary(Of String, HashSet(Of String)))
        End Get
        Set(value As Dictionary(Of String, HashSet(Of String)))
            Session("Dictionary") = value
        End Set
    End Property

    ''' <summary>
    ''' Naming of the template in the child GridTableViews that holds the checkbox
    ''' </summary>
    Private ReadOnly CheckBoxTemplateColumnUniqueName As String = "CheckBoxTemplate"

    Protected Sub Page_Init(sender As Object, e As EventArgs) Handles MyBase.Init
        If TableViews.Count = 0 Then
            'On initial load create items in the dictionary that correspond to the GridTableViewNames
            Dim dict As New Dictionary(Of String, HashSet(Of String))()
            Dim tableView As GridTableView = RadGrid1.MasterTableView
            While tableView.DetailTables.Count <> 0
                dict.Add(tableView.Name, New HashSet(Of String)())
                If tableView.DetailTables.Count > 0 Then
                    tableView = tableView.DetailTables(0)
                End If
            End While
            dict.Add(tableView.Name, New HashSet(Of String)())
            TableViews = dict
        End If

    End Sub

    Protected Sub MasterCheckbox_CheckedChanged(sender As Object, e As EventArgs)
        Dim box As CheckBox = DirectCast(sender, CheckBox)
        Dim dataItem As GridDataItem = DirectCast(box.NamingContainer, GridDataItem)
        'Extracts the masterKeyName and adds it or removes it from the collection in the dictionary
        Dim masterKeyName As String = GenerateUniqueIdentifier(dataItem)
        Me.SetCollectionValue(TableViews(dataItem.OwnerTableView.Name), masterKeyName, Not TableViews(dataItem.OwnerTableView.Name).Contains(masterKeyName))

        'Saves the expanded state and if the item is not expanded expands it in order to traverse the records
        Dim expanded As Boolean = dataItem.Expanded
        dataItem.Expanded = True
        dataItem.Selected = box.Checked

        Dim nestedTableView As GridTableView = dataItem.ChildItem.NestedTableViews(0)
        'Selects or deselects all the child items
        CheckItemsInTableView(nestedTableView, box.Checked)
        'Returns the previous state
        dataItem.Expanded = expanded
    End Sub

    ''' <summary>
    ''' According to the ckeck state of the master checkbox selects or deselects the items down in the hierarchy
    ''' </summary>
    ''' <param name="tableView"></param>
    ''' <param name="shouldCheck"></param>
    Protected Sub CheckItemsInTableView(tableView As GridTableView, shouldCheck As Boolean)
        Dim currentPageSize As Integer = tableView.PageSize
        Dim currentPageIndex As Integer = tableView.CurrentPageIndex
        'Resizing the table view in order to increase the performance
        tableView.PageSize = Integer.MaxValue
        tableView.Rebind()
        For Each detailItem As GridDataItem In tableView.Items
            detailItem.Selected = shouldCheck
            TryCast(detailItem(CheckBoxTemplateColumnUniqueName).FindControl(CheckBoxId), CheckBox).Checked = shouldCheck
            Dim ownerTableView As GridTableView = detailItem.OwnerTableView
            'Generates a unique identifier for the data item. This is done in order to distinguish every data item in the grid
            Dim dataKeyValue As String = GenerateUniqueIdentifier(detailItem)
            'Select or deselect the items in the current TableView
            Me.SetCollectionValue(TableViews(ownerTableView.Name), dataKeyValue, shouldCheck)

            detailItem.Expanded = True
            'If there is next level of hierarchy exist select or deselectes the items in it
            If detailItem.ChildItem IsNot Nothing Then
                CheckItemsInTableView(detailItem.ChildItem.NestedTableViews(0), shouldCheck)
            End If
        Next
        tableView.PageSize = currentPageSize
        tableView.CurrentPageIndex = currentPageIndex
        tableView.Rebind()
    End Sub

    ''' <summary>
    ''' Checking if all the items in the GridTableView are checked in order to determine whether to check the master item
    ''' </summary>
    ''' <param name="nestedTableView"></param>
    ''' <returns></returns>
    Protected Function ShouldCheckMasterItem(nestedTableView As GridTableView) As Boolean
        Dim isChecked As Boolean = True
        Dim currentPageSize As Integer = nestedTableView.PageSize
        Dim currentPageIndex As Integer = nestedTableView.CurrentPageIndex
        'Resizing the table view in order to increase the performance
        nestedTableView.PageSize = Integer.MaxValue
        nestedTableView.Rebind()
        For Each detailItem As GridDataItem In nestedTableView.Items
            Dim currentDataItem As String = GenerateUniqueIdentifier(detailItem)
            If Not TableViews(nestedTableView.Name).Contains(currentDataItem) Then
                isChecked = False
                Exit For
            End If
        Next
        nestedTableView.PageSize = currentPageSize
        nestedTableView.CurrentPageIndex = currentPageIndex
        nestedTableView.Rebind()
        Return isChecked
    End Function

    ''' <summary>
    ''' Handles the check of the an item
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    Protected Sub DetailCheckbox_CheckedChanged(sender As Object, e As EventArgs)
        'Check or uncheck the item
        Dim box As CheckBox = DirectCast(sender, CheckBox)
        Dim dataItem As GridDataItem = DirectCast(box.NamingContainer, GridDataItem)
        dataItem.Selected = box.Checked

        Dim shouldCheckOwner As Boolean = True

        'Gets a unique value for the grid item
        Dim uniqueIdentifier As String = GenerateUniqueIdentifier(dataItem)

        Me.SetCollectionValue(TableViews(dataItem.OwnerTableView.Name), uniqueIdentifier, box.Checked)
        'If the current data items has child items check or unchecks all child items
        If dataItem.HasChildItems Then
            Dim dataItemExpandedState As Boolean = dataItem.Expanded
            dataItem.Expanded = True
            CheckItemsInTableView(dataItem.ChildItem.NestedTableViews(0), box.Checked)
            dataItem.Expanded = dataItemExpandedState
        End If
        'Moving up in the hierarchy and determining whether to check the master items
        While dataItem.OwnerTableView.ParentItem IsNot Nothing
            Dim ownerTableView As GridTableView = dataItem.OwnerTableView
            'Checking if the owner should be selected 
            shouldCheckOwner = ShouldCheckMasterItem(ownerTableView)

            Dim parentItem As GridDataItem = ownerTableView.ParentItem
            Dim ownerTableName As String = parentItem.OwnerTableView.Name

            'Extracting the unique signature of the parent item
            Dim currentOwner As String = GenerateUniqueIdentifier(ownerTableView.ParentItem)

            'Selecteing or deselecting the owner
            Me.SetCollectionValue(TableViews(ownerTableName), currentOwner, shouldCheckOwner)
            TryCast(parentItem(CheckBoxTemplateColumnUniqueName).FindControl(CheckBoxId), CheckBox).Checked = shouldCheckOwner
            parentItem.Selected = shouldCheckOwner

            'Getting a reference to a data item in an upper level of the grid
            dataItem = parentItem
        End While
    End Sub

    Protected Function GenerateUniqueIdentifier(item As GridDataItem) As String
        Dim uniqueIdentifier As New StringBuilder()
        Dim currentItem As GridDataItem = item
        'Traversing the parent items up in the hierarchy to generate a unique key
        While True
            uniqueIdentifier.Append(currentItem.GetDataKeyValue(currentItem.OwnerTableView.DataKeyNames(0)).ToString())
            currentItem = currentItem.OwnerTableView.ParentItem
            If currentItem Is Nothing Then
                Exit While
            End If
        End While
        Return uniqueIdentifier.ToString()
    End Function
    'Selects the items down in the hierarchy
    Private Sub SelectChildTableItems(dataItem As GridDataItem)
        dataItem.Expanded = ExpandedRows.Contains(dataItem.GetDataKeyValue(dataItem.OwnerTableView.DataKeyNames(0)).ToString())
        'If the item is expanded select the child items if it is not expanded the items should not be selected
        If dataItem.Expanded Then
            Dim nestedTableView As GridTableView = dataItem.ChildItem.NestedTableViews(0)
            Me.SelectItems(TableViews(nestedTableView.Name), nestedTableView.Items, Nothing)
        End If
    End Sub

    Protected Sub RadGrid1_PreRender(sender As Object, e As EventArgs)
        Me.SelectItems(TableViews(RadGrid1.MasterTableView.Name), RadGrid1.MasterTableView.Items, AddressOf Me.SelectChildTableItems)
    End Sub

    ''' <summary>
    ''' Selects the items which have been previously selected
    ''' </summary>
    ''' <param name="collection"></param>
    ''' <param name="items"></param>
    ''' <param name="callback"></param>
    Private Sub SelectItems(collection As HashSet(Of String), items As GridDataItemCollection, callback As Action(Of GridDataItem))
        Dim currentDataItem As GridDataItem
        For i As Integer = 0 To items.Count - 1
            currentDataItem = items(i)
            'Generates the unique identifier for the item
            Dim uniqueIdentifier As String = GenerateUniqueIdentifier(currentDataItem)

            'Checks if the item was previously selected
            If collection.Contains(uniqueIdentifier) Then
                TryCast(currentDataItem.FindControl(CheckBoxId), CheckBox).Checked = True
                currentDataItem.Selected = True
            End If
            If callback IsNot Nothing Then
                callback.Invoke(currentDataItem)
            End If
            If currentDataItem.ChildItem IsNot Nothing Then
                'If the item has a nested table view selects the child items
                Dim expanded As Boolean = currentDataItem.Expanded
                currentDataItem.Expanded = True
                Dim ownerTableView As GridTableView = currentDataItem.ChildItem.NestedTableViews(0)
                Dim ownerTableViewDataKeyName As String = ownerTableView.DataKeyNames(0)
                Me.SelectItems(TableViews(ownerTableView.Name), ownerTableView.Items, callback)
                'Returns the previous expanded state
                currentDataItem.Expanded = expanded
            End If
        Next
    End Sub

    Private Sub SetCollectionValue(collection As HashSet(Of String), value As String, selected As Boolean)
        If selected Then
            collection.Add(value)
        Else
            collection.Remove(value)
        End If
    End Sub

    Protected Sub RadGrid1_ItemCommand(sender As Object, e As GridCommandEventArgs)
        If e.CommandName = "ExpandCollapse" Then
            'Saves the item unique valiue in the expanded rows collecting in order to persist the expanding
            Dim item As GridDataItem = TryCast(e.Item, GridDataItem)
            Dim masterKeyName As String = item.GetDataKeyValue(item.OwnerTableView.DataKeyNames(0)).ToString()
            Me.SetCollectionValue(ExpandedRows, masterKeyName, Not e.Item.Expanded)
        End If
    End Sub
End Class
