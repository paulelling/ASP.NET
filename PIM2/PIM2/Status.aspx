<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Status.aspx.cs" Inherits="PIM2.Status" %>
<asp:Content ID="cntStatusHead" ContentPlaceHolderID="cphPIM2Head" runat="server">
</asp:Content>
<asp:Content ID="cntStatus" ContentPlaceHolderID="cphPIM2Content" runat="server">
    <asp:ScriptManager ID="smStatus" runat="server" />
    <asp:UpdatePanel ID="upStatus" runat="server" UpdateMode="Conditional">
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="gvStatus" />
        </Triggers>
            
        <ContentTemplate> 
            <p><asp:Label ID="lblPageTitle" runat="server" Text="Status" CssClass="pageTitle"></asp:Label></p>
            <p>
            <asp:Label ID="lblStatus" runat="server" Visible="true" CssClass="status"></asp:Label>
            <asp:ValidationSummary ID="vsStatus" runat="server" CssClass="error" />   
                <p>
                    <asp:DropDownList ID="ddlStatusYears" runat="server" DataSourceID="sdsStatusYears"
                         DataTextField="iYear" DataValueField="iYear">
                    </asp:DropDownList>
                </p>   
                <p>
                    <asp:Button ID="btnStatus" runat="server" Text="View Status" 
                        onclick="btnStatus_Click" />
                </p>                    
                <p>
                    <asp:GridView ID="gvStatus" runat="server" AllowPaging="True" 
                        AutoGenerateColumns="False" CssClass="grid" 
                        DataSourceID="sdsStatus" EnableViewState="False" PageSize="25" 
                        AllowSorting="false">
                        <HeaderStyle CssClass="gridHeader" />
                        <AlternatingRowStyle CssClass="gridAlternatingRow" />                        
                        <Columns>
                            <asp:BoundField DataField="Vendor" HeaderText="Vendor" 
                                HeaderStyle-ForeColor="White" 
                                ItemStyle-Width="250px" ReadOnly="True" />
                            <asp:BoundField DataField="Account_Type" HeaderText="Account" 
                                HeaderStyle-ForeColor="White" 
                                ItemStyle-Width="75px" ReadOnly="True" />
                            <asp:BoundField DataField="Beginning_Balance" HeaderText="Initial Balance" 
                                HeaderStyle-ForeColor="White" 
                                ItemStyle-HorizontalAlign="Right" ItemStyle-Width="75px" ReadOnly="True" />
                            <asp:BoundField DataField="January" HeaderText="January" 
                                HeaderStyle-ForeColor="White" 
                                ItemStyle-HorizontalAlign="Right" ItemStyle-Width="75px" ReadOnly="True" />
                            <asp:BoundField DataField="February" HeaderText="February" 
                                HeaderStyle-ForeColor="White" 
                                ItemStyle-HorizontalAlign="Right" ItemStyle-Width="75px" ReadOnly="True" />
                            <asp:BoundField DataField="March" HeaderText="March" 
                                HeaderStyle-ForeColor="White" ItemStyle-HorizontalAlign="Right" 
                                ItemStyle-Width="75px" ReadOnly="True" />
                            <asp:BoundField DataField="April" HeaderText="April" 
                                HeaderStyle-ForeColor="White" ItemStyle-HorizontalAlign="Right" 
                                ItemStyle-Width="75px" ReadOnly="True" />
                            <asp:BoundField DataField="May" HeaderText="May" 
                                HeaderStyle-ForeColor="White" ItemStyle-HorizontalAlign="Right" 
                                ItemStyle-Width="75px" ReadOnly="True" />
                            <asp:BoundField DataField="June" HeaderText="June" HeaderStyle-ForeColor="White"
                                ItemStyle-HorizontalAlign="Right" 
                                ItemStyle-Width="75px" ReadOnly="True" />
                            <asp:BoundField DataField="July" HeaderText="July" HeaderStyle-ForeColor="White" 
                                ItemStyle-HorizontalAlign="Right" 
                                ItemStyle-Width="75px" ReadOnly="True" />
                            <asp:BoundField DataField="August" HeaderText="August" HeaderStyle-ForeColor="White" 
                                ItemStyle-HorizontalAlign="Right" 
                                ItemStyle-Width="75px" ReadOnly="True" />
                            <asp:BoundField DataField="September" HeaderText="September" HeaderStyle-ForeColor="White" 
                                ItemStyle-HorizontalAlign="Right" 
                                ItemStyle-Width="75px" ReadOnly="True" />
                            <asp:BoundField DataField="October" HeaderText="October" HeaderStyle-ForeColor="White" 
                                ItemStyle-HorizontalAlign="Right" 
                                ItemStyle-Width="75px" ReadOnly="True" />
                            <asp:BoundField DataField="November" HeaderText="November" ReadOnly="True" 
                                ItemStyle-Width="75px" ItemStyle-HorizontalAlign="Right" />
                            <asp:BoundField DataField="December" HeaderText="December" ReadOnly="True" 
                                ItemStyle-Width="75px" ItemStyle-HorizontalAlign="Right" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsStatus" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:PIM2ConnectionString %>" 
                        ProviderName="System.Data.SqlClient" 
                        SelectCommand="usp_Status" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter Name="iYear" Type="Int32" />
                    </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="sdsStatusYears" runat="server"
                        ConnectionString="<%$ ConnectionStrings:PIM2ConnectionString %>" ProviderName="System.Data.SqlClient"
                        SelectCommand="SELECT DISTINCT Year([Transaction_Date]) AS iYear FROM [dbo].[uv_Transactions] ORDER BY Year([Transaction_Date]) DESC"></asp:SqlDataSource>
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