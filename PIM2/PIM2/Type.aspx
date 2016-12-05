<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Type.aspx.cs" Inherits="PIM2.Type" %>
<asp:Content ID="cntTypeHead" ContentPlaceHolderID="cphPIM2Head" runat="server">
</asp:Content>
<asp:Content ID="cntType" ContentPlaceHolderID="cphPIM2Content" runat="server">
    <asp:ScriptManager ID="smType" runat="server" />
    <asp:UpdatePanel ID="upType" runat="server" UpdateMode="Conditional">
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="gvTypes" />
        </Triggers>
            
        <ContentTemplate> 
            <script type="text/javascript">
                function ValidateType(oSrc, args) {
                    args.IsValid = (hasNoExtraneousChars(args.Value));
                }
            </script>
            <p><asp:Label ID="lblPageTitle" runat="server" Text="Types" CssClass="pageTitle"></asp:Label></p>
            <p>
            <asp:Label ID="lblStatus" runat="server" Visible="true" CssClass="status"></asp:Label>
            <asp:ValidationSummary ID="vsType" runat="server" CssClass="error" />
                <p>
                    <asp:GridView ID="gvTypes" runat="server" AllowPaging="True" 
                        AllowSorting="True" AutoGenerateColumns="False" CssClass="grid" 
                        DataKeyNames="iTypeID" DataSourceID="sdsTypes" EnableViewState="False" 
                        ShowFooter="True" onselectedindexchanged="gvTypes_SelectedIndexChanged" 
                        PageSize="50">
                        <HeaderStyle CssClass="gridHeader" />
                        <AlternatingRowStyle CssClass="gridAlternatingRow" />
                        <Columns>
                            <asp:TemplateField HeaderText="Type" SortExpression="sType">
                                <EditItemTemplate>
                                    <asp:TextBox ID="tbType" runat="server" MaxLength="50" 
                                        Text='<%# Bind("sType") %>'></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvType" runat="server" 
                                        ControlToValidate="tbType" ErrorMessage="Type is required" Text="*"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="cvType" runat="server" 
                                        ClientValidationFunction="ValidateType" ControlToValidate="tbType" 
                                        CssClass="error" ErrorMessage="Type is invalid" Text="*"></asp:CustomValidator>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="tbNewType" runat="server" MaxLength="50"></asp:TextBox>
                                    <asp:CustomValidator ID="cvNewType" runat="server" 
                                        ClientValidationFunction="ValidateType" ControlToValidate="tbNewType" 
                                        CssClass="error" ErrorMessage="Type is invalid" Text="*"></asp:CustomValidator>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblType" runat="server" Text='<%# Bind("sType") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle ForeColor="White" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Order_By" SortExpression="iOrderBy" Visible="false">
                                <EditItemTemplate>
                                    <asp:TextBox ID="tbOrderBy" runat="server" Text='<%# Bind("iOrderBy") %>' 
                                        Width="50px"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblOrderBy" runat="server" Text='<%# Bind("iOrderBy") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle ForeColor="White" />
                            </asp:TemplateField>
                            <asp:CommandField ShowSelectButton="True" SelectText="Values" />
                            <asp:TemplateField FooterStyle-VerticalAlign="Top" ShowHeader="False">
                                <EditItemTemplate>
                                    <asp:LinkButton ID="lbUpdate" runat="server" CausesValidation="True" 
                                        CommandName="Update" OnClick="lbUpdate_Click" Text="Update"></asp:LinkButton>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:LinkButton ID="lbInsert" runat="server" CausesValidation="True" 
                                        CommandName="Insert" onclick="lbInsert_Click" Text="Insert"></asp:LinkButton>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbEdit" runat="server" CausesValidation="False" 
                                        CommandName="Edit" OnClick="lbEdit_Click" Text="Edit" Visible="true"></asp:LinkButton>
                                </ItemTemplate>
                                <FooterStyle VerticalAlign="Top" />
                            </asp:TemplateField>
                            <asp:TemplateField FooterStyle-VerticalAlign="Top" ShowHeader="False">
                                <EditItemTemplate>
                                    <asp:LinkButton ID="lbCancelUpdate" runat="server" CausesValidation="False" 
                                        CommandName="Cancel" OnClick="lbCancelUpdate_Click" Text="Cancel"></asp:LinkButton>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbDelete" runat="server" CausesValidation="False" 
                                        CommandName="Delete" Text="Delete"></asp:LinkButton>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:LinkButton ID="lbCancelInsert" runat="server" CausesValidation="False" 
                                        CommandName="Cancel" OnClick="lbCancelInsert_Click" Text="Cancel"></asp:LinkButton>
                                </FooterTemplate>
                                <FooterStyle VerticalAlign="Top" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsTypes" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:PIM2ConnectionString %>" 
                        DeleteCommand="usp_Type" DeleteCommandType="StoredProcedure" 
                        InsertCommand="usp_Type" InsertCommandType="StoredProcedure" 
                        ProviderName="System.Data.SqlClient" 
                        SelectCommand="SELECT [Type_ID] AS iTypeID, [Type] AS sType, [Order_By] AS iOrderBy FROM [dbo].[Type] ORDER BY iOrderBy"
                        UpdateCommand="usp_Type" UpdateCommandType="StoredProcedure">
                        <DeleteParameters>
                            <asp:Parameter DefaultValue="Delete" Name="sCommand" Type="String" />
                            <asp:Parameter Name="iTypeID" Type="Int32" />
                            <asp:Parameter Name="sType" Type="String" />
                            <asp:Parameter Name="iOrderBy" Type="Int32" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter DefaultValue="Insert" Name="sCommand" Type="String" />
                            <asp:Parameter DefaultValue="0" Name="iTypeID" Type="Int32" />
                            <asp:Parameter Name="sType" Type="String" />
                            <asp:Parameter Name="iOrderBy" Type="Int32" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter DefaultValue="Update" Name="sCommand" Type="String" />
                            <asp:Parameter Name="iTypeID" Type="Int32" />
                            <asp:Parameter Name="sType" Type="String" />
                            <asp:Parameter Name="iOrderBy" Type="Int32" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </p>
                <p>
                </p>
                <p>
                </p>
                <p>
                </p>
                <p>
                </p>
                <p>
                </p>
                <p>
                </p>
                <p>
                </p>
                <p>
                </p>
            </p>

        </ContentTemplate>            
    </asp:UpdatePanel>
              
</asp:Content>