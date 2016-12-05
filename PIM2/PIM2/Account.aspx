<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Account.aspx.cs" Inherits="PIM2.Account" %>
<asp:Content ID="cntAccountHead" ContentPlaceHolderID="cphPIM2Head" runat="server">
</asp:Content>
<asp:Content ID="cntAccount" ContentPlaceHolderID="cphPIM2Content" runat="server">
    <asp:ScriptManager ID="smAccount" runat="server" />
    <asp:UpdatePanel ID="upAccount" runat="server" UpdateMode="Conditional">
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="gvAccounts" />
        </Triggers>
            
        <ContentTemplate> 
            <script type="text/javascript">
                
            </script>
            <p><asp:Label ID="lblPageTitle" runat="server" Text="Accounts" CssClass="pageTitle"></asp:Label></p>
            <p>
            <asp:Label ID="lblStatus" runat="server" Visible="true" CssClass="status"></asp:Label>
            <asp:ValidationSummary ID="vsAccount" runat="server" CssClass="error" />
                <p>
                    <asp:GridView ID="gvAccounts" runat="server" AllowPaging="True" 
                        AllowSorting="True" AutoGenerateColumns="False" CssClass="grid" 
                        DataKeyNames="iAccountID" DataSourceID="sdsAccounts" EnableViewState="False" 
                        ShowFooter="True" PageSize="25">
                        <HeaderStyle CssClass="gridHeader" />
                        <AlternatingRowStyle CssClass="gridAlternatingRow" />
                        <Columns>
                            <asp:TemplateField HeaderText="Vendor" SortExpression="sVendor">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlVendor" runat="server" DataSourceID="sdsVendors" 
                                        DataTextField="Name" DataValueField="Vendor_ID" 
                                        SelectedValue='<%# Bind("iVendorID") %>'>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:DropDownList ID="ddlNewVendor" runat="server" DataSourceID="sdsVendors" 
                                        DataTextField="Name" DataValueField="Vendor_ID">
                                    </asp:DropDownList>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblVendor" runat="server" Text='<%# Bind("sVendor") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle ForeColor="White" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Account_Type" SortExpression="sAccountType">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlAccountType" runat="server" 
                                        DataSourceID="sdsAccountTypes" DataTextField="Value" 
                                        DataValueField="Value_ID" SelectedValue='<%# Bind("iAccountTypeID") %>'>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:DropDownList ID="ddlNewAccountType" runat="server" 
                                        DataSourceID="sdsAccountTypes" DataTextField="Value" DataValueField="Value_ID">
                                    </asp:DropDownList>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblAccountType" runat="server" Text='<%# Bind("sAccountType") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle ForeColor="White" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Order_By" SortExpression="Order_By" Visible="false">
                                <EditItemTemplate>
                                    <asp:TextBox ID="tbOrderBy" runat="server" Text='<%# Bind("iOrderBy") %>' 
                                        Width="50px"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblOrderBy" runat="server" Text='<%# Bind("iOrderBy") %>'></asp:Label>
                                </ItemTemplate>
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
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbSecurity" runat="server" CausesValidation="False" 
                                        CommandName="Select" Text="Security" 
                                        CommandArgument='<%# Bind("iAccountID") %>' oncommand="lbSecurity_Command" ></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsAccounts" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:PIM2ConnectionString %>" 
                        ProviderName="System.Data.SqlClient"                         
                        SelectCommand="SELECT [Account_ID] AS iAccountID, [Vendor_ID] AS iVendorID, [Vendor] AS sVendor, [Account_Type_ID] AS iAccountTypeID, [Account_Type] AS sAccountType, [Order_By] AS iOrderBy FROM [uv_Accounts] ORDER BY [Order_By]" 
                        DeleteCommand="usp_Account" DeleteCommandType="StoredProcedure" 
                        InsertCommand="usp_Account" InsertCommandType="StoredProcedure" 
                        UpdateCommand="usp_Account" UpdateCommandType="StoredProcedure">
                        <DeleteParameters>
                            <asp:Parameter Name="sCommand" Type="String" DefaultValue="Delete" />
                            <asp:Parameter Name="iAccountID" Type="Int32" />
                            <asp:Parameter Name="iVendorID" Type="Int32" />
                            <asp:Parameter Name="iAccountTypeID" Type="Int32" />
                            <asp:Parameter Name="iOrderBy" Type="Int32" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="sCommand" Type="String" DefaultValue="Insert" />
                            <asp:Parameter Name="iAccountID" Type="Int32" DefaultValue="0" />
                            <asp:Parameter Name="iVendorID" Type="Int32" />
                            <asp:Parameter Name="iAccountTypeID" Type="Int32" />
                            <asp:Parameter Name="iOrderBy" Type="Int32" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="sCommand" Type="String" DefaultValue="Update" />
                            <asp:Parameter Name="iAccountID" Type="Int32" />
                            <asp:Parameter Name="iVendorID" Type="Int32" />
                            <asp:Parameter Name="iAccountTypeID" Type="Int32" />
                            <asp:Parameter Name="iOrderBy" Type="Int32" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="sdsVendors" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:PIM2ConnectionString %>" 
                        ProviderName="System.Data.SqlClient" 
                        SelectCommand="SELECT [Vendor_ID], [Name] FROM [dbo].[uv_Vendors] ORDER BY [Name]"></asp:SqlDataSource>
                    <asp:SqlDataSource ID="sdsAccountTypes" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:PIM2ConnectionString %>" 
                        ProviderName="System.Data.SqlClient" 
                        SelectCommand="SELECT [Value_ID], [Value] FROM [dbo].[uv_Types] WHERE [Type] = 'Account Type' ORDER BY [Order_By]">
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
            </p>

        </ContentTemplate>            
    </asp:UpdatePanel>
              
</asp:Content>
