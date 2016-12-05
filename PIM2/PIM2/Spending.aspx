<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Spending.aspx.cs" Inherits="PIM2.Spending" %>
<asp:Content ID="cntSpendingHead" ContentPlaceHolderID="cphPIM2Head" runat="server">
</asp:Content>
<asp:Content ID="cntSpending" ContentPlaceHolderID="cphPIM2Content" runat="server">
    <asp:ScriptManager ID="smSpending" runat="server" />
    <asp:UpdatePanel ID="upSpending" runat="server" UpdateMode="Conditional">
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="gvSpending" />
        </Triggers>
            
        <ContentTemplate> 
            <p><asp:Label ID="lblPageTitle" runat="server" Text="Spending" CssClass="pageTitle"></asp:Label></p>
            <p>
            <asp:Label ID="lblStatus" runat="server" Visible="true" CssClass="status"></asp:Label>
            <asp:ValidationSummary ID="vsSpending" runat="server" CssClass="error" /> 
                <p>
                    <asp:DropDownList ID="ddlSpendingYears" runat="server" DataSourceID="sdsSpendingYears"
                         DataTextField="iYear" DataValueField="iYear">
                    </asp:DropDownList>
                </p>   
                <p>
                    <asp:Button ID="btnSpending" runat="server" Text="View Spending" 
                        onclick="btnSpending_Click" />
                </p>       
                <p>
                    <asp:GridView ID="gvSpending" runat="server" AllowPaging="True" 
                        AllowSorting="false" AutoGenerateColumns="False" CssClass="grid" 
                        DataSourceID="sdsSpending" EnableViewState="False" 
                        ShowFooter="False" PageSize="50">
                        <HeaderStyle CssClass="gridHeader" />
                        <AlternatingRowStyle CssClass="gridAlternatingRow" />                        
                        <Columns>
                            <asp:BoundField DataField="Expense" HeaderText="Expense" 
                                HeaderStyle-ForeColor="White" ItemStyle-Width="200px" />
                            <asp:BoundField DataField="January" HeaderText="January" 
                                HeaderStyle-ForeColor="White" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="75px" />
                            <asp:BoundField DataField="February" HeaderText="February" 
                                HeaderStyle-ForeColor="White" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="75px" />
                            <asp:BoundField DataField="March" HeaderText="March" HeaderStyle-ForeColor="White" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="75px" />
                            <asp:BoundField DataField="April" HeaderText="April" HeaderStyle-ForeColor="White" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="75px" />
                            <asp:BoundField DataField="May" HeaderText="May" HeaderStyle-ForeColor="White" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="75px" />
                            <asp:BoundField DataField="June" HeaderText="June" HeaderStyle-ForeColor="White" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="75px" />
                            <asp:BoundField DataField="July" HeaderText="July" HeaderStyle-ForeColor="White" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="75px" />
                            <asp:BoundField DataField="August" HeaderText="August" HeaderStyle-ForeColor="White"
                                ItemStyle-HorizontalAlign="Right" ItemStyle-Width="75px" />
                            <asp:BoundField DataField="September" HeaderText="September" HeaderStyle-ForeColor="White" 
                                ItemStyle-HorizontalAlign="Right" ItemStyle-Width="75px" />
                            <asp:BoundField DataField="October" HeaderText="October" HeaderStyle-ForeColor="White" 
                                ItemStyle-HorizontalAlign="Right" ItemStyle-Width="75px" />
                            <asp:BoundField DataField="November" HeaderText="November" HeaderStyle-ForeColor="White" 
                                ItemStyle-HorizontalAlign="Right" ItemStyle-Width="75px" />
                            <asp:BoundField DataField="December" HeaderText="December" HeaderStyle-ForeColor="White" 
                                ItemStyle-HorizontalAlign="Right" ItemStyle-Width="75px" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsSpending" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:PIM2ConnectionString %>" 
                        ProviderName="System.Data.SqlClient" 
                        SelectCommand="SELECT [Expense]
      ,[January]
      ,[February]
      ,[March]
      ,[April]
      ,[May]
      ,[June]
      ,[July]
      ,[August]
      ,[September]
      ,[October]
      ,[November]
      ,[December]
      ,[Order]
  FROM [dbo].[uv_Spending_Totals]
  WHERE [Year] = @iYear
  ORDER BY [Order]">
                    <SelectParameters>
                        <asp:Parameter Name="iYear" Type="Int32" />
                    </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="sdsSpendingYears" runat="server"
                        ConnectionString="<%$ ConnectionStrings:PIM2ConnectionString %>" ProviderName="System.Data.SqlClient"
                        SelectCommand="SELECT DISTINCT [Year] AS iYear FROM [dbo].[uv_Spending_Totals] ORDER BY [Year] DESC"></asp:SqlDataSource>
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