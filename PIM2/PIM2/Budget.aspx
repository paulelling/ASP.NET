<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Budget.aspx.cs" Inherits="PIM2.Budget" %>
<asp:Content ID="cntBudgetHead" ContentPlaceHolderID="cphPIM2Head" runat="server">
</asp:Content>
<asp:Content ID="cntBudget" ContentPlaceHolderID="cphPIM2Content" runat="server">
    <asp:ScriptManager ID="smBudget" runat="server" />
    <asp:UpdatePanel ID="upBudget" runat="server" UpdateMode="Conditional">
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="gvBudget" />
        </Triggers>
            
        <ContentTemplate>
            <script type="text/javascript">
                function ValidateAmount(oSrc, args) {
                    args.IsValid = (isNumeric(args.Value));
                }
            </script>                 
            <p><asp:Label ID="lblPageTitle" runat="server" Text="Budget" CssClass="pageTitle"></asp:Label></p>
            <p>
            <asp:Label ID="lblStatus" runat="server" Visible="true" CssClass="status"></asp:Label>
            <asp:ValidationSummary ID="vsBudget" runat="server" CssClass="error" />    
                <p>
                    <asp:GridView ID="gvBudget" runat="server" 
                        AutoGenerateColumns="False" CssClass="grid" 
                        DataSourceID="sdsBudget" EnableViewState="False" PageSize="50" 
                        ShowFooter="True" onselectedindexchanged="gvBudget_SelectedIndexChanged"
                        AllowSorting="false">
                        <HeaderStyle CssClass="gridHeader" />
                        <AlternatingRowStyle CssClass="gridAlternatingRow" />                        
                        <Columns>
                            <asp:TemplateField>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlBudgetItem" runat="server" DataSourceID="sdsBudgetItems" 
                                        DataTextField="sBudgetItem" DataValueField="iItemID" 
                                        SelectedValue='<%# Bind("iItemID") %>'>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:DropDownList ID="ddlNewBudgetItem" runat="server" DataSourceID="sdsBudgetItems" 
                                        DataTextField="sBudgetItem" DataValueField="iItemID">
                                    </asp:DropDownList>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblBudgetItem" runat="server" Text='<%# Bind("sBudgetItem") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle ForeColor="White" />
                                <ItemStyle Width="200px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Period 1">
                                <EditItemTemplate>
                                    <asp:TextBox ID="tbPayPeriod1" runat="server" Text='<%# Bind("Pay_Period_1") %>'></asp:TextBox>
                                    <asp:CustomValidator ID="cvPayPeriod1" runat="server" 
                                        ClientValidationFunction="ValidateAmount" ControlToValidate="tbPayPeriod1" 
                                        CssClass="error" ErrorMessage="Pay Period 1 amount is not numeric" Text="*"></asp:CustomValidator>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="tbNewPayPeriod1" runat="server"></asp:TextBox>
                                    <asp:CustomValidator ID="cvNewPayPeriod1" runat="server" 
                                        ClientValidationFunction="ValidateAmount" ControlToValidate="tbNewPayPeriod1" 
                                        CssClass="error" ErrorMessage="New Pay Period 1 amount is not numeric" Text="*"></asp:CustomValidator>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblPayPeriod1" runat="server" Text='<%# Bind("Pay_Period_1") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle ForeColor="White" />
                                <ItemStyle HorizontalAlign="Right" Width="75px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Period 2">
                                <EditItemTemplate>
                                    <asp:TextBox ID="tbPayPeriod2" runat="server" Text='<%# Bind("Pay_Period_2") %>'></asp:TextBox>
                                    <asp:CustomValidator ID="cvPayPeriod2" runat="server" 
                                        ClientValidationFunction="ValidateAmount" ControlToValidate="tbPayPeriod2" 
                                        CssClass="error" ErrorMessage="Pay Period 2 amount is not numeric" Text="*"></asp:CustomValidator>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="tbNewPayPeriod2" runat="server"></asp:TextBox>
                                    <asp:CustomValidator ID="cvNewPayPeriod2" runat="server" 
                                        ClientValidationFunction="ValidateAmount" ControlToValidate="tbNewPayPeriod2" 
                                        CssClass="error" ErrorMessage="New Pay Period 2 amount is not numeric" Text="*"></asp:CustomValidator>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblPayPeriod2" runat="server" Text='<%# Bind("Pay_Period_2") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle ForeColor="White" />
                                <ItemStyle HorizontalAlign="Right" Width="75px" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="Monthly_Total" HeaderText="Month" 
                                HeaderStyle-ForeColor="White" 
                                ItemStyle-HorizontalAlign="Right" ItemStyle-Width="75px"
                                ReadOnly="true" >
                            <HeaderStyle ForeColor="White" />
                            <ItemStyle HorizontalAlign="Right" Width="75px" />
                            </asp:BoundField>
                            <asp:TemplateField FooterStyle-VerticalAlign="Top" ShowHeader="False">
                                <EditItemTemplate>
                                    <asp:LinkButton ID="lbUpdate" runat="server" CausesValidation="True" 
                                        OnClick="lbUpdate_Click" Text="Update"></asp:LinkButton>
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
                                        CommandName="Select" Text="Delete"></asp:LinkButton>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:LinkButton ID="lbCancelInsert" runat="server" CausesValidation="False" 
                                        CommandName="Cancel" OnClick="lbCancelInsert_Click" Text="Cancel"></asp:LinkButton>
                                </FooterTemplate>
                                <FooterStyle VerticalAlign="Top" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsBudget" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:PIM2ConnectionString %>" 
                        ProviderName="System.Data.SqlClient" 
                        SelectCommand="usp_Budget" SelectCommandType="StoredProcedure"
                        DeleteCommand="usp_Budget" DeleteCommandType="StoredProcedure" 
                        InsertCommand="usp_Budget" InsertCommandType="StoredProcedure" 
                        UpdateCommand="usp_Budget" UpdateCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:Parameter Name="sCommand" Type="String" DefaultValue="Select" />
                        </SelectParameters>
                        <DeleteParameters>
                            <asp:Parameter Name="sCommand" Type="String" DefaultValue="Delete" />
                            <asp:Parameter Name="iItemID" Type="Int32" />
                            <asp:Parameter Name="sBudgetItem" Type="String" />
                            <asp:Parameter Name="sPayPeriod" Type="String" />
                            <asp:Parameter Name="dAmount" Type="Decimal" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="sCommand" Type="String" DefaultValue="Insert" />
                            <asp:Parameter Name="iItemID" Type="Int32" />
                            <asp:Parameter Name="sBudgetItem" Type="String" DefaultValue="" />
                            <asp:Parameter Name="sPayPeriod" Type="String" />
                            <asp:Parameter Name="dAmount" Type="Decimal" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="sCommand" Type="String" DefaultValue="Update" />
                            <asp:Parameter Name="iItemID" Type="Int32" />
                            <asp:Parameter Name="sBudgetItem" Type="String" DefaultValue="" />
                            <asp:Parameter Name="sPayPeriod" Type="String" />
                            <asp:Parameter Name="dAmount" Type="Decimal" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="sdsBudgetItems" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:PIM2ConnectionString %>" 
                        ProviderName="System.Data.SqlClient" 
                        SelectCommand="SELECT [Value_ID] AS iItemID, [Value] AS sBudgetItem
                                  FROM [dbo].[uv_Budget_Items]
                                    ORDER BY [Value] ASC"></asp:SqlDataSource>
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