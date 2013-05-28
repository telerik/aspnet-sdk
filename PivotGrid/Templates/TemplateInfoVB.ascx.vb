Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports Telerik.Web.UI

Partial Class PivotGrid_Examples_Templates_TemplateInfoVB
    Inherits System.Web.UI.UserControl

    Shared ReadOnly MinimumQuantity As Integer = 40
    Private m_container As PivotGridCell
    Private m_fieldName As String

    Public Property TemplateName() As String
        Get
            Return m_TemplateName
        End Get
        Set(value As String)
            m_TemplateName = value
        End Set
    End Property
    Private m_TemplateName As String

    Public ReadOnly Property Container() As PivotGridCell
        Get
            If m_container Is Nothing Then
                m_container = TryCast(Parent, PivotGridCell)
            End If
            Return m_container
        End Get
    End Property

    Public ReadOnly Property FieldName() As String
        Get
            If m_fieldName Is Nothing Then
                m_fieldName = If(Container.Field IsNot Nothing, Container.Field.UniqueName, "n/a")
            End If
            Return m_fieldName
        End Get
    End Property

    Protected Function GetCellText() As String
        Dim dataItemValue As Object = Container.DataItem
        Dim dataItemText As String

        'set custom format string and horizontal alignment for decimal types
        If TypeOf dataItemValue Is Decimal Then
            dataItemText = CDec(dataItemValue).ToString("F2")
            Container.HorizontalAlign = HorizontalAlign.Right
        Else
            dataItemText = (If(dataItemValue, "")).ToString()
        End If

        If FieldName = "Quantity" AndAlso TypeOf dataItemValue Is Long AndAlso CLng(dataItemValue) < MinimumQuantity Then
            'change the back & fore colors of the cell when Quantity is less than 40
            Container.BackColor = System.Drawing.Color.FromArgb(255, 220, 255)
            Container.ForeColor = System.Drawing.Color.Black

            'display exclamation mark when Quantity is less than 40 
            dataItemText += " (!)"
        End If

        Return dataItemText
    End Function

    Protected Function GetToolTipContent() As String
        Dim fieldType As String = [String].Empty

        Select Case Container.[GetType]().Name
            Case "PivotGridDataCell"
                fieldType = "Aggregate"
                Exit Select
            Case "PivotGridRowHeaderCell"
                fieldType = "Row"
                Exit Select
            Case "PivotGridColumnHeaderCell"
                fieldType = "Column"
                Exit Select
        End Select

        Return [String].Format("<b>Template:</b> {0}<br/><b>FieldName:</b> {1}<br/><b>Value:</b> {2}<br/><b>FieldType:</b> {3}", TemplateName, FieldName, m_container.DataItem, fieldType)
    End Function
End Class
