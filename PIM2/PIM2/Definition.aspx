<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Definition.aspx.cs" Inherits="PIM2.Definition" %>
<asp:Content ID="cntDefinitionHead" ContentPlaceHolderID="cphPIM2Head" runat="server">
</asp:Content>
<asp:Content ID="cntDefinition" ContentPlaceHolderID="cphPIM2Content" runat="server">
    <asp:ScriptManager ID="smDefinition" runat="server" />
    <asp:UpdatePanel ID="upDefinition" runat="server" UpdateMode="Conditional">
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="gvDefinitions" />
        </Triggers>
            
        <ContentTemplate> 
            <p><asp:Label ID="lblPageTitle" runat="server" Text="Transaction Definitions" CssClass="pageTitle"></asp:Label></p>
            <p>
            <asp:Label ID="lblStatus" runat="server" Visible="true" CssClass="status"></asp:Label>
            <asp:ValidationSummary ID="vsDefinition" runat="server" CssClass="error" />
                <p>
                    <asp:GridView ID="gvDefinitions" runat="server" AllowPaging="True"
                        AllowSorting="True" AutoGenerateColumns="False" CssClass="grid"
                        DataKeyNames="iTransactionDefinitionID" DataSourceID="sdsDefinitions" EnableViewState="False" 
                        ShowFooter="True" PageSize="25">
                        <HeaderStyle CssClass="gridHeader" />
                        <AlternatingRowStyle CssClass="gridAlternatingRow" />
                        <Columns>
                            <asp:TemplateField HeaderText="Description" 
                                SortExpression="sTransactionDescription">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlTransactionDescription" runat="server" 
                                        DataSourceID="sdsTransactionDescriptions" DataTextField="Value" DataValueField="Value_ID" 
                                        SelectedValue='<%# Bind("iTransactionDescriptionID") %>'>
                                    </asp:DropDownList>                                    
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:DropDownList ID="ddlNewTransactionDescription" runat="server" 
                                        DataSourceID="sdsTransactionDescriptions" DataTextField="Value" DataValueField="Value_ID">
                                    </asp:DropDownList>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblTransactionDescription" runat="server" 
                                        Text='<%# Bind("sTransactionDescription") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle ForeColor="White" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Description Type" 
                                SortExpression="sTransactionDescriptionType">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlTransactionDescriptionType" runat="server" 
                                        DataSourceID="sdsTransactionDescriptionTypes" DataTextField="Value" DataValueField="Value_ID" 
                                        SelectedValue='<%# Bind("iTransactionDescriptionTypeID") %>'>
                                    </asp:DropDownList>                                    
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:DropDownList ID="ddlNewTransactionDescriptionType" runat="server" 
                                        DataSourceID="sdsTransactionDescriptionTypes" DataTextField="Value" DataValueField="Value_ID">
                                    </asp:DropDownList>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblTransactionDescriptionType" runat="server" 
                                        Text='<%# Bind("sTransactionDescriptionType") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle ForeColor="White" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Category" 
                                SortExpression="sTransactionCategory">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlTransactionCategory" runat="server" 
                                        DataSourceID="sdsTransactionCategories" DataTextField="sTransactionCategory" DataValueField="iTransactionCategoryID" 
                                        SelectedValue='<%# Bind("iTransactionCategoryID") %>'>
                                    </asp:DropDownList>                                               
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:DropDownList ID="ddlNewTransactionCategory" runat="server" 
                                        DataSourceID="sdsTransactionCategories" DataTextField="sTransactionCategory" DataValueField="iTransactionCategoryID">
                                    </asp:DropDownList>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblTransactionCategory" runat="server" 
                                        Text='<%# Bind("sTransactionCategory") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle ForeColor="White" />
                            </asp:TemplateField>
                            <asp:TemplateField FooterStyle-VerticalAlign="Top" ShowHeader="False">
                                <EditItemTemplate>
                                    <asp:LinkButton ID="lbUpdate" runat="server" CausesValidation="False" 
                                        CommandName="Update" OnClick="lbUpdate_Click" Text="Update"></asp:LinkButton>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:LinkButton ID="lbInsert" runat="server" CausesValidation="False" 
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
                    <asp:SqlDataSource ID="sdsDefinitions" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:PIM2ConnectionString %>" 
                        DeleteCommand="usp_Transaction_Definition" DeleteCommandType="StoredProcedure" 
                        InsertCommand="usp_Transaction_Definition" InsertCommandType="StoredProcedure" 
                        ProviderName="System.Data.SqlClient" 
                        SelectCommand="SELECT [Transaction_Definition_ID] AS iTransactionDefinitionID, [Transaction_Description_ID] AS iTransactionDescriptionID, [Transaction_Description] AS sTransactionDescription, [Transaction_Description_Type_ID] AS iTransactionDescriptionTypeID, [Transaction_Description_Type] AS sTransactionDescriptionType, [Transaction_Category_ID] AS iTransactionCategoryID, [Transaction_Category] AS sTransactionCategory FROM [uv_Transaction_Definitions] ORDER BY sTransactionDescription ASC, sTransactionCategory ASC"
                        UpdateCommand="usp_Transaction_Definition" UpdateCommandType="StoredProcedure">
                        <DeleteParameters>
                            <asp:Parameter DefaultValue="Delete" Name="sCommand" Type="String" />
                            <asp:Parameter Name="iTransactionDefinitionID" Type="Int32" />
                            <asp:Parameter Name="iTransactionDescriptionID" Type="Int32" />
                            <asp:Parameter Name="iTransactionDescriptionTypeID" Type="Int32" />
                            <asp:Parameter Name="iTransactionCategoryID" Type="Int32" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter DefaultValue="Insert" Name="sCommand" Type="String" />
                            <asp:Parameter DefaultValue="0" Name="iTransactionDefinitionID" Type="Int32" />
                            <asp:Parameter Name="iTransactionDescriptionID" Type="Int32" />
                            <asp:Parameter Name="iTransactionDescriptionTypeID" Type="Int32" />
                            <asp:Parameter Name="iTransactionCategoryID" Type="Int32" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter DefaultValue="Update" Name="sCommand" Type="String" />
                            <asp:Parameter Name="iTransactionDefinitionID" Type="Int32" />
                            <asp:Parameter Name="iTransactionDescriptionID" Type="Int32" />
                            <asp:Parameter Name="iTransactionDescriptionTypeID" Type="Int32" />
                            <asp:Parameter Name="iTransactionCategoryID" Type="Int32" />
                        </UpdateParameters>                        
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="sdsTransactionDescriptions" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:PIM2ConnectionString %>" 
                        ProviderName="System.Data.SqlClient" 
                        SelectCommand="SELECT [Value_ID], [Value] FROM [uv_Types] WHERE [Type] = 'Transaction Description' ORDER BY [Value] ASC"></asp:SqlDataSource>
                    <asp:SqlDataSource ID="sdsTransactionDescriptionTypes" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:PIM2ConnectionString %>" 
                        ProviderName="System.Data.SqlClient"
                        SelectCommand="SELECT [Value_ID], [Value] FROM [uv_Types] WHERE [Type] = 'Transaction Description Type' ORDER BY [Value] ASC"></asp:SqlDataSource>
                    <asp:SqlDataSource ID="sdsTransactionCategories" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:PIM2ConnectionString %>" 
                        ProviderName="System.Data.SqlClient"
                        SelectCommand="SELECT distinct ty.[Value_ID] AS iTransactionCategoryID, ty.[Value] AS sTransactionCategory
                            FROM [uv_Types] ty WHERE ty.[Type] IN ('Expense', 'Transaction Description Type', 'Investment') ORDER BY ty.[Value] ASC"></asp:SqlDataSource>
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
