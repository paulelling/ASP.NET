<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Type_Value.aspx.cs" Inherits="PIM2.Type_Value" %>
<asp:Content ID="cntTypeValueHead" ContentPlaceHolderID="cphPIM2Head" runat="server">
</asp:Content>
<asp:Content ID="cntTypeValue" ContentPlaceHolderID="cphPIM2Content" runat="server">
    <asp:ScriptManager ID="smTypeValue" runat="server" />
    <asp:UpdatePanel ID="upTypeValue" runat="server" UpdateMode="Conditional">
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="gvValues" />
        </Triggers>
            
        <ContentTemplate> 
            <script type="text/javascript">
                function ValidateValue(oSrc, args) {
                    args.IsValid = (hasNoExtraneousChars(args.Value));
                }
            </script>
            <p><asp:Label ID="lblPageTitle" runat="server" Text="" CssClass="pageTitle"></asp:Label></p>
            <p>
            <asp:Label ID="lblStatus" runat="server" Visible="true" CssClass="status"></asp:Label>
            <asp:ValidationSummary ID="vsTypeValue" runat="server" CssClass="error" />
                <p>
                    <asp:Table ID="tblEmptyDataValue" runat="server" Visible="false">
                        <asp:TableHeaderRow CssClass="gridHeader">
                            <asp:TableHeaderCell>Value</asp:TableHeaderCell>
                            <asp:TableHeaderCell>&nbsp;</asp:TableHeaderCell>
                            <asp:TableHeaderCell>&nbsp;</asp:TableHeaderCell>
                        </asp:TableHeaderRow>
                        <asp:TableRow CssClass="grid">
                            <asp:TableCell>
                                <asp:TextBox ID="tbEmptyDataValue" runat="server" MaxLength="50"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEmptyDataValue" runat="server" 
                                    ControlToValidate="tbEmptyDataValue" ErrorMessage="Value is required" Text="*"></asp:RequiredFieldValidator>
                                <asp:CustomValidator ID="cvEmptyDataValue" runat="server" 
                                    ClientValidationFunction="ValidateValue" ControlToValidate="tbEmptyDataValue" 
                                    CssClass="error" ErrorMessage="Value is invalid" Text="*"></asp:CustomValidator>
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:LinkButton ID="lbEmptyDataInsert" runat="server" CausesValidation="True" 
                                CommandName="Insert" onclick="lbEmptyDataInsert_Click" Text="Insert"></asp:LinkButton>
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:LinkButton ID="lbEmptyDataCancelInsert" runat="server" CausesValidation="False" 
                                CommandName="Cancel" Text="Cancel"></asp:LinkButton>                                        
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                    <asp:GridView ID="gvValues" runat="server" AllowPaging="True" 
                        AllowSorting="True" AutoGenerateColumns="False" CssClass="grid" 
                        DataKeyNames="iValueID" DataSourceID="sdsTypeValues" EnableViewState="False" 
                        ShowFooter="True" PageSize="50" onload="gvValues_Load" 
                        OnRowDeleted="gvValues_Deleted">
                        <HeaderStyle CssClass="gridHeader" />
                        <AlternatingRowStyle CssClass="gridAlternatingRow" />
                        <Columns>                            
                            <asp:TemplateField HeaderText="Value" SortExpression="sValue">
                                <EditItemTemplate>
                                    <asp:TextBox ID="tbValue" runat="server" MaxLength="50" 
                                        Text='<%# Bind("sValue") %>'></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvValue" runat="server" 
                                        ControlToValidate="tbValue" ErrorMessage="Value is required" Text="*"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="cvValue" runat="server" 
                                        ClientValidationFunction="ValidateValue" ControlToValidate="tbValue" 
                                        CssClass="error" ErrorMessage="Value is invalid" Text="*"></asp:CustomValidator>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="tbNewValue" runat="server" MaxLength="50"></asp:TextBox>
                                    <asp:CustomValidator ID="cvNewValue" runat="server" 
                                        ClientValidationFunction="ValidateValue" ControlToValidate="tbNewValue" 
                                        CssClass="error" ErrorMessage="Value is invalid" Text="*"></asp:CustomValidator>
                                </FooterTemplate>                                
                                <ItemTemplate>
                                    <asp:Label ID="lblValue" runat="server" Text='<%# Bind("sValue") %>'></asp:Label>
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
                    <asp:SqlDataSource ID="sdsTypeValues" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:PIM2ConnectionString %>" 
                        DeleteCommand="usp_Type_Value" DeleteCommandType="StoredProcedure" 
                        InsertCommand="usp_Type_Value" InsertCommandType="StoredProcedure" 
                        ProviderName="System.Data.SqlClient" 
                        SelectCommand="SELECT [Type_ID] AS iTypeID, [Type] AS sType, [Value_ID] AS iValueID, [Value] AS sValue, [Order_By] AS iOrderBy FROM [dbo].[uv_Types] WHERE [Type_ID] = @iTypeID ORDER BY iOrderBy"
                        UpdateCommand="usp_Type_Value" UpdateCommandType="StoredProcedure">
                        <DeleteParameters>
                            <asp:Parameter DefaultValue="Delete" Name="sCommand" Type="String" />
                            <asp:Parameter Name="iValueID" Type="Int32" />
                            <asp:Parameter Name="sValue" Type="String" />
                            <asp:Parameter Name="iTypeID" Type="Int32" />
                            <asp:Parameter Name="iOrderBy" Type="Int32" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter DefaultValue="Insert" Name="sCommand" Type="String" />
                            <asp:Parameter DefaultValue="0" Name="iValueID" Type="Int32" />
                            <asp:Parameter Name="sValue" Type="String" />
                            <asp:Parameter Name="iTypeID" Type="Int32" />
                            <asp:Parameter Name="iOrderBy" Type="Int32" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter DefaultValue="Update" Name="sCommand" Type="String" />
                            <asp:Parameter Name="iValueID" Type="Int32" />
                            <asp:Parameter Name="sValue" Type="String" />
                            <asp:Parameter Name="iTypeID" Type="Int32" />
                            <asp:Parameter Name="iOrderBy" Type="Int32" />
                        </UpdateParameters>
                        <SelectParameters>
                            <asp:Parameter Name="iTypeID" Type="Int32" />
                        </SelectParameters>
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
            </p>

        </ContentTemplate>            
    </asp:UpdatePanel>
              
</asp:Content>
