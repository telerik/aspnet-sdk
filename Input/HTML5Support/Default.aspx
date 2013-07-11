<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="Styles.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <telerik:RadScriptManager runat="server" ID="radScriptManager1">
    </telerik:RadScriptManager>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            //<![CDATA[
            function validateFunction(sender, eventArgs) {
                eventArgs.IsValid = true;
                var firstPicker = $find("<%= RadTextBox3.ClientID %>");
                var secondPicker = $find("<%= RadTextBox4.ClientID %>");
                if (secondPicker.get_value() <= firstPicker.get_value()) {
                    eventArgs.IsValid = false;
                }
            }
            function PreviewButtonClick() {
                if (Page_ClientValidate()) {
                    var resultsDiv = $get("<%= divPreviewResults.ClientID %>");
                    resultsDiv.innerHTML = "<h4>You entered the following values:</h4>";
                    resultsDiv.innerHTML += "Your Name: <b>" + $find("<%= RadTextBox1.ClientID %>").get_value() + "</b><br />";
                    resultsDiv.innerHTML += "Number of Rooms: <b>" + $find("<%= RadTextBox2.ClientID %>").get_value() + "</b><br />";
                    resultsDiv.innerHTML += "Check-in Date: <b>" + $find("<%= RadTextBox3.ClientID %>").get_value() + "</b><br />";
                    resultsDiv.innerHTML += "Check-out Time: <b>" + $find("<%= RadTextBox4.ClientID %>").get_value() + "</b><br />";
                    resultsDiv.innerHTML += "E-mail: <b>" + $find("<%= RadTextBox5.ClientID %>").get_value() + "</b><br />";
                    resultsDiv.innerHTML += "Phone number: <b>" + $find("<%= RadTextBox4.ClientID %>").get_value() + "</b><br />";
                }
                else {
                    alert("Please fill in the form with valid data!");
                }
            }
            //]]>
        </script>
    </telerik:RadCodeBlock>
    <div>
        <br />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="divLeft">
                    <h4>
                        Rooms Reservation Form</h4>
                    <telerik:RadTextBox ID="RadTextBox1" runat="server" InputType="Text" Label="Your Name: "
                        Width="280px" LabelWidth="50%" EnableSingleInputRendering="true">
                    </telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Name Required!"
                        ControlToValidate="RadTextBox1" Display="Dynamic">
                    </asp:RequiredFieldValidator>
                    <br />
                    <telerik:RadTextBox ID="RadTextBox2" runat="server" InputType="Number" Label="Number of Rooms: "
                        Width="280px" LabelWidth="50%">
                    </telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="* Number of Rooms Required!"
                        ControlToValidate="RadTextBox2" Display="Dynamic">
                    </asp:RequiredFieldValidator>
                    <br />
                    <telerik:RadTextBox ID="RadTextBox3" runat="server" InputType="Date" Label="Check-in Date: "
                        Width="280px" LabelWidth="50%">
                    </telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="* Check-in Date Required!"
                        ControlToValidate="RadTextBox3" Display="Dynamic">
                    </asp:RequiredFieldValidator>
                    <br />
                    <telerik:RadTextBox ID="RadTextBox4" runat="server" InputType="Time" Label="Check-out Time: "
                        Width="280px" LabelWidth="50%">
                    </telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="* Check-out Time Required!"
                        ControlToValidate="RadTextBox4" Display="Dynamic">
                    </asp:RequiredFieldValidator>
                    <br />
                    <telerik:RadTextBox ID="RadTextBox5" runat="server" InputType="Email" Label="E-mail: "
                        Width="280px" LabelWidth="50%">
                    </telerik:RadTextBox>
                    <br />
                    <telerik:RadTextBox ID="RadTextBox6" runat="server" InputType="Tel" Label="Phone Number: "
                        Width="280px" LabelWidth="50%">
                    </telerik:RadTextBox>
                    <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="* Check-out Time should be later than Check-in Date!"
                        Display="Dynamic" ControlToValidate="RadTextBox4" ClientValidationFunction="validateFunction"></asp:CustomValidator>
                </div>
                <asp:Panel CssClass="divRight" ID="divPreviewResults" runat="server">
                </asp:Panel>
                <div style="clear: both">
                </div>
                <br />
                <br />
                <div class="divBottom">
                    <asp:Button ID="Button1" runat="server" Text="Preview" OnClientClick="PreviewButtonClick(); return false;">
                    </asp:Button>
                    <asp:Button ID="Button2" runat="server" Text="Submit" OnClick="Button2_Click"></asp:Button>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="Button2"></asp:PostBackTrigger>
            </Triggers>
        </asp:UpdatePanel>
    </div>
    </form>
</body>
</html>
