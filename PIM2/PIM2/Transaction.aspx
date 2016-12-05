<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Transaction.aspx.cs" Inherits="PIM2.Transaction" %>
<asp:Content ID="cntTransactionHead" ContentPlaceHolderID="cphPIM2Head" runat="server">
</asp:Content>
<asp:Content ID="cntTransaction" ContentPlaceHolderID="cphPIM2Content" runat="server">
    <asp:ScriptManager ID="smTransaction" runat="server" />
    <asp:UpdatePanel ID="upTransaction" runat="server" UpdateMode="Conditional">
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="gvTransactions" />
        </Triggers>
            
        <ContentTemplate> 

            <script type="text/javascript">
                function ValidateAmount(oSrc, args) {
                    args.IsValid = (isNumeric(args.Value));
                }
            </script>             
            <p><asp:Label ID="lblPageTitle" runat="server" Text="Transactions" CssClass="pageTitle"></asp:Label></p>
            <p>
            <asp:Label ID="lblStatus" runat="server" Visible="true" CssClass="status"></asp:Label>
            <asp:ValidationSummary ID="vsTransaction" runat="server" CssClass="error" />    
            <p>
                <asp:DropDownList ID="ddlAccounts" runat="server" 
                    DataSourceID="sdsAccounts" DataTextField="sAccount" DataValueField="iAccountID">                    
                </asp:DropDownList>                
            </p>     
            <p>
                <asp:Label ID="lblBeginTransactionDate" runat="server" Text="Begin Date:" CssClass="status"></asp:Label>
                <asp:TextBox ID="tbBeginTransactionDate" runat="server" ReadOnly="false" MaxLength="10"></asp:TextBox>
                <asp:ImageButton ID="ibBeginTransactionDate" runat="server" Height="15px" Width="15px"
                    ImageUrl="~/Images/calendar.gif" OnClick="ibBeginTransactionDate_Click" />
                <p><asp:Calendar ID="calBeginTransactionDate" runat="server" OnSelectionChanged="calBeginTransactionDate_SelectionChanged"
                    Visible="false" CssClass="grid" TitleStyle-CssClass="gridAlternatingRow">                    
                    </asp:Calendar></p>                                                                    
            </p>
            <p>
                <asp:Label ID="lblEndTransactionDate" runat="server" Text="End Date:" CssClass="status"></asp:Label>
                <asp:TextBox ID="tbEndTransactionDate" runat="server" ReadOnly="false" MaxLength="10"></asp:TextBox>
                <asp:ImageButton ID="ibEndTransactionDate" runat="server" Height="15px" Width="15px"
                    ImageUrl="~/Images/calendar.gif" OnClick="ibEndTransactionDate_Click" />
                <p><asp:Calendar ID="calEndTransactionDate" runat="server" OnSelectionChanged="calEndTransactionDate_SelectionChanged"
                    Visible="false" CssClass="grid" TitleStyle-CssClass="gridAlternatingRow"></asp:Calendar></p>                                                   
            </p>
            <p>
                <asp:Button ID="btnTransactions" runat="server" Text="Find Transactions" 
                    onclick="btnTransactions_Click" />
            </p>       
                <p>
                    <asp:Table ID="tblEmptyDataValue" runat="server" Visible="false">
                        <asp:TableHeaderRow CssClass="gridHeader">
                            <asp:TableHeaderCell>Date</asp:TableHeaderCell>
                            <asp:TableHeaderCell>Transaction</asp:TableHeaderCell>
                            <asp:TableHeaderCell>Debit</asp:TableHeaderCell>
                            <asp:TableHeaderCell>Credit</asp:TableHeaderCell>
                            <asp:TableHeaderCell>&nbsp;</asp:TableHeaderCell>
                            <asp:TableHeaderCell>&nbsp;</asp:TableHeaderCell>
                        </asp:TableHeaderRow>
                        <asp:TableRow CssClass="grid">
                            <asp:TableCell>
                                <asp:TextBox ID="tbEmptyDataTransactionDate" runat="server" MaxLength="10"></asp:TextBox>
                                <asp:ImageButton ID="ibEmptyDataTransactionDate" runat="server" Height="15px" Width="15px"
                                    ImageUrl="~/Images/calendar.gif" OnClick="ibEmptyDataTransactionDate_Click" />
                                <p><asp:Calendar ID="calEmptyDataTransactionDate" runat="server" OnSelectionChanged="calEmptyDataTransactionDate_SelectionChanged"
                                    Visible="false" CssClass="grid" TitleStyle-CssClass="gridAlternatingRow"></asp:Calendar></p>                                                 
                            </asp:TableCell>
                            <asp:TableCell VerticalAlign="Top">
                                <asp:DropDownList ID="ddlEmptyDataTransactionDefinition" runat="server" 
                                    DataSourceID="sdsTransactionDefinitions" DataTextField="sTransactionDefinition" DataValueField="iTransactionDefinitionID">
                                </asp:DropDownList>
                            </asp:TableCell>
                            <asp:TableCell VerticalAlign="Top">
                                <asp:TextBox ID="tbEmptyDataDebit" runat="server" MaxLength="10"></asp:TextBox>
                                <asp:CustomValidator ID="cvEmptyDataDebit" runat="server" 
                                    ClientValidationFunction="ValidateAmount" ControlToValidate="tbEmptyDataDebit" 
                                    CssClass="error" ErrorMessage="Debit amount is not numeric" Text="*"></asp:CustomValidator>    
                            </asp:TableCell>
                            <asp:TableCell VerticalAlign="Top">
                                <asp:TextBox ID="tbEmptyDataCredit" runat="server" MaxLength="10"></asp:TextBox>
                                <asp:CustomValidator ID="cvEmptyDataCredit" runat="server" 
                                    ClientValidationFunction="ValidateAmount" ControlToValidate="tbEmptyDataCredit" 
                                    CssClass="error" ErrorMessage="Credit amount is not numeric" Text="*"></asp:CustomValidator>       
                            </asp:TableCell>
                            <asp:TableCell VerticalAlign="Top">
                                <asp:LinkButton ID="lbEmptyDataInsert" runat="server" CausesValidation="True" 
                                CommandName="Insert" onclick="lbEmptyDataInsert_Click" Text="Insert"></asp:LinkButton>
                            </asp:TableCell>
                            <asp:TableCell VerticalAlign="Top">
                                <asp:LinkButton ID="lbEmptyDataCancelInsert" runat="server" CausesValidation="False" 
                                CommandName="Cancel" Text="Cancel"></asp:LinkButton>                                        
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                    <asp:GridView ID="gvTransactions" runat="server" AllowPaging="True" 
                        AllowSorting="True" AutoGenerateColumns="False" CssClass="grid" 
                        DataKeyNames="iTransactionID" DataSourceID="sdsTransactions" EnableViewState="False" 
                        ShowFooter="True" PageSize="20" OnRowDeleted="gvTransactions_Deleted">
                        <HeaderStyle CssClass="gridHeader" />
                        <AlternatingRowStyle CssClass="gridAlternatingRow" />
                        <Columns>
                            <asp:TemplateField HeaderText="Date" SortExpression="dtTransactionDate">
                                <EditItemTemplate>
                                    <asp:TextBox ID="tbTransactionDate" runat="server" Text='<%# Bind("dtTransactionDate") %>' MaxLength="10" ReadOnly="false"></asp:TextBox>
                                    <asp:ImageButton ID="ibTransactionDate" runat="server" Height="15px" Width="15px"
                                        ImageUrl="~/Images/calendar.gif" OnClick="ibTransactionDate_Click" />
                                    <p><asp:Calendar ID="calTransactionDate" runat="server" OnSelectionChanged="calTransactionDate_SelectionChanged"
                                        Visible="false" CssClass="grid" TitleStyle-CssClass="gridAlternatingRow"></asp:Calendar></p>                                                                    
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblTransactionDate" runat="server" Text='<%# Bind("dtTransactionDate") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="tbNewTransactionDate" runat="server" MaxLength="10" ReadOnly="false"></asp:TextBox>
                                    <asp:ImageButton ID="ibNewTransactionDate" runat="server" Height="15px" Width="15px"
                                        ImageUrl="~/Images/calendar.gif" OnClick="ibNewTransactionDate_Click" />
                                    <p><asp:Calendar ID="calNewTransactionDate" runat="server" OnSelectionChanged="calNewTransactionDate_SelectionChanged"
                                        Visible="false" CssClass="grid" TitleStyle-CssClass="gridAlternatingRow"></asp:Calendar></p>                                                                    
                                </FooterTemplate>
                                <HeaderStyle ForeColor="White" />                                
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Transaction" SortExpression="sTransactionDescription" ItemStyle-VerticalAlign="Top">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlTransactionDefinition" runat="server" 
                                        DataSourceID="sdsTransactionDefinitions" DataTextField="sTransactionDefinition" DataValueField="iTransactionDefinitionID" 
                                        SelectedValue='<%# Bind("iTransactionDefinitionID") %>'>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblTransactionDescription" runat="server" Text='<%# Bind("sTransactionDescription") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:DropDownList ID="ddlNewTransactionDefinition" runat="server" 
                                        DataSourceID="sdsTransactionDefinitions" DataTextField="sTransactionDefinition" DataValueField="iTransactionDefinitionID">
                                    </asp:DropDownList>
                                </FooterTemplate>
                                <HeaderStyle ForeColor="White" />
                                <FooterStyle VerticalAlign="Top" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Debit" SortExpression="dDebit" ItemStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Right">
                                <EditItemTemplate>
                                    <asp:TextBox ID="tbDebit" runat="server" Text='<%# Bind("dDebit") %>' MaxLength="10"></asp:TextBox>
                                    <asp:CustomValidator ID="cvDebit" runat="server" 
                                        ClientValidationFunction="ValidateAmount" ControlToValidate="tbDebit" 
                                        CssClass="error" ErrorMessage="Debit amount is not numeric" Text="*"></asp:CustomValidator>    
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblDebit" runat="server" Text='<%# Bind("dDebit") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="tbNewDebit" runat="server" MaxLength="10"></asp:TextBox>
                                    <asp:CustomValidator ID="cvNewDebit" runat="server" 
                                        ClientValidationFunction="ValidateAmount" ControlToValidate="tbNewDebit" 
                                        CssClass="error" ErrorMessage="New debit amount is not numeric" Text="*"></asp:CustomValidator>                                                                 
                                </FooterTemplate>
                                <HeaderStyle ForeColor="White" />
                                <FooterStyle VerticalAlign="Top" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Credit" SortExpression="dCredit" ItemStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Right">
                                <EditItemTemplate>
                                    <asp:TextBox ID="tbCredit" runat="server" Text='<%# Bind("dCredit") %>' MaxLength="10"></asp:TextBox>
                                    <asp:CustomValidator ID="cvCredit" runat="server" 
                                        ClientValidationFunction="ValidateAmount" ControlToValidate="tbCredit" 
                                        CssClass="error" ErrorMessage="Credit amount is not numeric" Text="*"></asp:CustomValidator>       
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblCredit" runat="server" Text='<%# Bind("dCredit") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="tbNewCredit" runat="server" MaxLength="10"></asp:TextBox>
                                    <asp:CustomValidator ID="cvNewCredit" runat="server" 
                                        ClientValidationFunction="ValidateAmount" ControlToValidate="tbNewCredit" 
                                        CssClass="error" ErrorMessage="New credit amount is not numeric" Text="*"></asp:CustomValidator>       
                                </FooterTemplate>
                                <HeaderStyle ForeColor="White" />
                                <FooterStyle VerticalAlign="Top" />
                            </asp:TemplateField>
                            <asp:TemplateField FooterStyle-VerticalAlign="Top" ShowHeader="False" ItemStyle-VerticalAlign="Top">
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
                            <asp:TemplateField FooterStyle-VerticalAlign="Top" ShowHeader="False" ItemStyle-VerticalAlign="Top">
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
                    <asp:SqlDataSource ID="sdsTransactions" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:PIM2ConnectionString %>" 
                        ProviderName="System.Data.SqlClient" 
                        SelectCommand="SELECT [Transaction_ID] AS iTransactionID, CONVERT(varchar(10),[Transaction_Date],101) AS dtTransactionDate, [Transaction_Definition_ID] AS iTransactionDefinitionID, [Transaction_Description_ID] AS iTransactionDescriptionID, [Transaction_Description] AS sTransactionDescription, CASE [Transaction_Type] WHEN 'Debit' THEN [Transaction_Amount] ELSE NULL END AS dDebit, CASE [Transaction_Type] WHEN 'Credit' THEN [Transaction_Amount] ELSE NULL END AS dCredit FROM [uv_Transactions] WHERE [Account_ID] = @iAccountID AND [Transaction_Date] BETWEEN @dtBeginTransactionDate AND @dtEndTransactionDate ORDER BY [Transaction_Date] desc"
                        InsertCommand="usp_Transaction" InsertCommandType="StoredProcedure"
                        DeleteCommand="usp_Transaction" DeleteCommandType="StoredProcedure"
                        UpdateCommand="usp_Transaction" UpdateCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:Parameter Name="iAccountID" Type="Int32" />
                            <asp:Parameter Name="dtBeginTransactionDate" Type="DateTime" />
                            <asp:Parameter Name="dtEndTransactionDate" Type="DateTime" />
                        </SelectParameters>
                        <InsertParameters>
                            <asp:Parameter DefaultValue="Insert" Name="sCommand" Type="String" />
                            <asp:Parameter Name="iTransactionID" Type="Int32" DefaultValue="0" />
                            <asp:Parameter Name="iAccountID" Type="Int32" />
                            <asp:Parameter Name="dtTransactionDate" Type="DateTime" />
                            <asp:Parameter Name="iTransactionDefinitionID" Type="Int32" />
                            <asp:Parameter Name="dTransactionAmount" Type="Decimal" />
                            <asp:Parameter Name="sTransactionType" Type="String" />
                        </InsertParameters>
                        <DeleteParameters>
                            <asp:Parameter DefaultValue="Delete" Name="sCommand" Type="String" />
                            <asp:Parameter Name="iTransactionID" Type="Int32" />
                            <asp:Parameter Name="iAccountID" Type="Int32" />
                            <asp:Parameter Name="dtTransactionDate" Type="DateTime" />
                            <asp:Parameter Name="iTransactionDefinitionID" Type="Int32" />
                            <asp:Parameter Name="dTransactionAmount" Type="Decimal" />
                            <asp:Parameter Name="sTransactionType" Type="String" />                        
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:Parameter DefaultValue="Update" Name="sCommand" Type="String" /> 
                            <asp:Parameter Name="iTransactionID" Type="Int32" />
                            <asp:Parameter Name="iAccountID" Type="Int32" />
                            <asp:Parameter Name="dtTransactionDate" Type="DateTime" />
                            <asp:Parameter Name="iTransactionDefinitionID" Type="Int32" />
                            <asp:Parameter Name="dTransactionAmount" Type="Decimal" />
                            <asp:Parameter Name="sTransactionType" Type="String" />                            
                        </UpdateParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="sdsAccounts" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:PIM2ConnectionString %>" 
                        ProviderName="System.Data.SqlClient"                         
                        SelectCommand="SELECT [Account_ID] AS iAccountID, [Vendor] + ': ' + [Account_Type] AS sAccount, [Order_By] AS iOrderBy FROM [uv_Accounts] ORDER BY [Order_By]">                        
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="sdsTransactionDescriptions" runat="server"
                        ConnectionString="<%$ ConnectionStrings:PIM2ConnectionString %>" 
                        ProviderName="System.Data.SqlClient"                         
                        SelectCommand="SELECT [Value_ID] AS iValueID, [Value] AS sValue FROM [uv_Types] WHERE [Type] = 'Transaction Description' ORDER BY [Order_By]"></asp:SqlDataSource>
                    <asp:SqlDataSource ID="sdsTransactionDefinitions" runat="server"
                        ConnectionString="<%$ ConnectionStrings:PIM2ConnectionString %>" 
                        ProviderName="System.Data.SqlClient"                         
                        SelectCommand="SELECT [Transaction_Definition_ID] AS iTransactionDefinitionID, [Transaction_Description] + ': ' + [Transaction_Description_Type] + ' (' + [Transaction_Category] + ')' AS sTransactionDefinition FROM [uv_Transaction_Definitions] ORDER BY [Transaction_Description], [Transaction_Description_Type], [Transaction_Category]"></asp:SqlDataSource>
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