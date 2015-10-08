<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CRUD.aspx.cs" Inherits="WebApplication2.CRUD" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title></title>
    <link href="Script/bootstrap.min.css" rel="stylesheet" />
    <script src="Script/jquery-1.3.2.min.js"></script>
    <script src="Script/jquery.blockUI.js"></script>
    <link href="StyleSheet1.css" rel="stylesheet" />
    <script type="text/javascript">
        function BlockUI(elementID) {
            var prm = Sys.WebForms.PageRequestManager.getInstance();
            prm.add_beginRequest(function () {
                $("#" + elementID).block({
                    message: '<table align = "center"><tr><td>' +
             '<img src="loading.gif"/></td></tr></table>',
                    css: {},
                    overlayCSS: {
                        backgroundColor: '#000000', opacity: 0.6
                    }
                });
            });
            prm.add_endRequest(function () {
                $("#" + elementID).unblock();
            });
        }
        $(document).ready(function () {

            BlockUI("<%=pnlAddEdit.ClientID %>");
        $.blockUI.defaults.css = {};
    });
        function Hidepopup() {
            $find("popup").hide();
            return false;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="GridView1" runat="server" Width="700px"
                        AutoGenerateColumns="false" PageSize="5" HeaderStyle-BackColor="#6699ff" HeaderStyle-ForeColor="WhiteSmoke" AllowPaging="False">
                        <Columns>
                            <asp:BoundField DataField="empName" HeaderText="Employee Name" HtmlEncode="true" />
                            <asp:BoundField DataField="empId" HeaderText="Employee ID" HtmlEncode="true" />
                            <asp:BoundField DataField="salary" HeaderText="Employee Salary" HtmlEncode="true" />
                            <asp:BoundField DataField="address" HeaderText="Employee Address" HtmlEncode="true" />
                             <asp:BoundField DataField="phone" HeaderText="Phone Number" HtmlEncode="true" />
                            <asp:TemplateField ItemStyle-Width="80px" HeaderText="Edit">
                                <ItemTemplate>
                                     <asp:LinkButton ID="lnkbtn" runat="server"  OnClick="Edit" CommandArgument='<%# Eval("_id") %>'>Edit</asp:LinkButton>&nbsp;&nbsp;
                                     <asp:LinkButton ID="lnkDel" runat="server"   OnClick="delete" CommandArgument='<%# Eval("_id") %>'>Delete</asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                     <asp:HiddenField ID="hdn" runat="server" />
                    <asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="Add" CssClass="btn-success" Width="100px" />
                    <asp:Panel ID="pnlAddEdit" runat="server" CssClass="modalPopup" Style="display: none">
                        <asp:Label Font-Bold="true" ID="Label4" CssClass="lbl" runat="server" Text="Employee Details"></asp:Label>
                        <br />
                        <table align="center" class="table">
                            <tr>
                                <td>
                                    <asp:Label ID="Label1" runat="server" Text="Employee Name"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtEmployeeName" CssClass="control-group info" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label2" runat="server" Text="Employee ID" ></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtID" runat="server" CssClass="control-group info"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label3" runat="server" Text="Employee Salary"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtSal" runat="server" CssClass="control-group info"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label5" runat="server" Text="Employee Address"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtAddress" runat="server" CssClass="control-group info"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label6" runat="server" Text="Phone Number"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtPhn" runat="server" CssClass="control-group info"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn-primary"  OnClick="Save" />
                                </td>
                                <td>
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn-primary" OnClientClick="return Hidepopup()" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <asp:LinkButton ID="lnkFake" runat="server"></asp:LinkButton>
                    <asp:ModalPopupExtender ID="popup" runat="server" DropShadow="false"
                        PopupControlID="pnlAddEdit" TargetControlID="lnkFake"
                        BackgroundCssClass="modalBackground">
                    </asp:ModalPopupExtender>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="GridView1" />
                    <asp:AsyncPostBackTrigger ControlID="btnSave" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>