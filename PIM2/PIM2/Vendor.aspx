<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Vendor.aspx.cs" Inherits="PIM2.Vendor" %>
<asp:Content ID="cntVendorHead" ContentPlaceHolderID="cphPIM2Head" runat="server">
</asp:Content>
<asp:Content ID="cntVendor" ContentPlaceHolderID="cphPIM2Content" runat="server">
    <asp:ScriptManager ID="smVendor" runat="server" />
    <asp:UpdatePanel ID="upVendor" runat="server" UpdateMode="Conditional">
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="gvVendors" />
        </Triggers>
            
        <ContentTemplate> 
            <script type="text/javascript">
                function ValidateName(oSrc, args) {
                    args.IsValid = (hasNoExtraneousChars(args.Value));
                }
            </script>
            <p><asp:Label ID="lblPageTitle" runat="server" Text="Vendors" CssClass="pageTitle"></asp:Label></p>
            <p>
            <asp:Label ID="lblStatus" runat="server" Visible="true" CssClass="status"></asp:Label>
            <asp:ValidationSummary ID="vsVendor" runat="server" CssClass="error" />
                <p>
                    <asp:GridView ID="gvVendors" runat="server" AllowPaging="True" 
                        AllowSorting="True" AutoGenerateColumns="False" CssClass="grid" 
                        DataKeyNames="iVendorID" DataSourceID="sdsVendors" EnableViewState="False" 
                        ShowFooter="True" PageSize="25">
                        <HeaderStyle CssClass="gridHeader" />
                        <AlternatingRowStyle CssClass="gridAlternatingRow" />
                        <Columns>
                            <asp:TemplateField HeaderText="Name" SortExpression="sVendor">
                                <EditItemTemplate>
                                    <asp:TextBox ID="tbName" runat="server" MaxLength="50" 
                                        Text='<%# Bind("sVendor") %>'></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvName" runat="server" 
                                        ControlToValidate="tbName" ErrorMessage="Vendor name is required" Text="*"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="cvName" runat="server" 
                                        ClientValidationFunction="ValidateName" ControlToValidate="tbName" 
                                        CssClass="error" ErrorMessage="Vendor name is invalid" Text="*"></asp:CustomValidator>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="tbNewName" runat="server" MaxLength="50"></asp:TextBox>
                                    <asp:CustomValidator ID="cvNewName" runat="server" 
                                        ClientValidationFunction="ValidateName" ControlToValidate="tbNewName" 
                                        CssClass="error" ErrorMessage="Vendor name is invalid" Text="*"></asp:CustomValidator>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblName" runat="server" Text='<%# Bind("sVendor") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle ForeColor="White" />
                            </asp:TemplateField>
                            <asp:TemplateField FooterStyle-VerticalAlign="Top" HeaderText="Vendor Type" 
                                SortExpression="sVendorType">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlVendorType" runat="server" 
                                        DataSourceID="sdsVendorType" DataTextField="Value" DataValueField="Value_ID" 
                                        SelectedValue='<%# Bind("iVendorTypeID") %>'>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:DropDownList ID="ddlNewVendorType" runat="server" 
                                        DataSourceID="sdsVendorType" DataTextField="Value" DataValueField="Value_ID">
                                    </asp:DropDownList>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblVendorType" runat="server" Text='<%# Bind("sVendorType") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterStyle VerticalAlign="Top" />
                                <HeaderStyle ForeColor="White" />
                            </asp:TemplateField>
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
                    <asp:SqlDataSource ID="sdsVendors" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:PIM2ConnectionString %>" 
                        DeleteCommand="usp_Vendor" DeleteCommandType="StoredProcedure" 
                        InsertCommand="usp_Vendor" InsertCommandType="StoredProcedure" 
                        ProviderName="System.Data.SqlClient" 
                        SelectCommand="SELECT [Vendor_ID] AS iVendorID, [Name] AS sVendor, [Vendor_Type_ID] AS iVendorTypeID, [Vendor_Type] AS sVendorType FROM [dbo].[uv_Vendors] ORDER BY sVendor ASC, sVendorType ASC" 
                        UpdateCommand="usp_Vendor" UpdateCommandType="StoredProcedure">
                        <DeleteParameters>
                            <asp:Parameter DefaultValue="Delete" Name="sCommand" Type="String" />
                            <asp:Parameter Name="iVendorID" Type="Int32" />
                            <asp:Parameter Name="sVendor" Type="String" />
                            <asp:Parameter Name="iVendorTypeID" Type="Int32" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter DefaultValue="Insert" Name="sCommand" Type="String" />
                            <asp:Parameter DefaultValue="0" Name="iVendorID" Type="Int32" />
                            <asp:Parameter Name="sVendor" Type="String" />
                            <asp:Parameter Name="iVendorTypeID" Type="Int32" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter DefaultValue="Update" Name="sCommand" Type="String" />
                            <asp:Parameter Name="iVendorID" Type="Int32" />
                            <asp:Parameter Name="sVendor" Type="String" />
                            <asp:Parameter Name="iVendorTypeID" Type="Int32" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="sdsVendorType" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:PIM2ConnectionString %>" 
                        ProviderName="System.Data.SqlClient" 
                        SelectCommand="SELECT [Value_ID], [Value] FROM [dbo].[uv_Types] WHERE [Type] = 'Vendor Type' ORDER BY [Order_By]">
                    </asp:SqlDataSource>
                </p>
                <p>
                </p>
                <p>
                </p>
            </p>

        </ContentTemplate>            
    </asp:UpdatePanel>
              
</asp:Content>

