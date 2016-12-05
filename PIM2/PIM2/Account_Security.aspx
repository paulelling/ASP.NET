<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Account_Security.aspx.cs" Inherits="PIM2.Account_Security" %>
<asp:Content ID="cntAccountSecurityHead" ContentPlaceHolderID="cphPIM2Head" runat="server">
</asp:Content>
<asp:Content ID="cntAccountSecurity" ContentPlaceHolderID="cphPIM2Content" runat="server">
    <asp:ScriptManager ID="smAccountSecurity" runat="server" />
    <asp:UpdatePanel ID="upAccountSecurity" runat="server" UpdateMode="Conditional">
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="gvAccountSecurity" />
        </Triggers>
            
        <ContentTemplate> 
            <script type="text/javascript">
                
            </script>
            <p><asp:Label ID="lblPageTitle" runat="server" CssClass="pageTitle"></asp:Label></p>
            <p>
            <asp:Label ID="lblStatus" runat="server" Visible="true" CssClass="status"></asp:Label>
            <asp:ValidationSummary ID="vsAccountSecurity" runat="server" CssClass="error" />
                <p>



                    <asp:SqlDataSource ID="sdsAccountSecurity" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:PIM2ConnectionString %>" 
                        ProviderName="System.Data.SqlClient" SelectCommand="SELECT 
[Account_ID]
,[Vendor_ID]
,[Vendor]
,[Account_Type_ID]
,[Account_Type]
,[Order_By]
,[Account_Security_ID]
,[Attribute_ID]
,[Attribute]
,[Data_Type_ID]
,[Data_Type]
,[Value_Integer]
,[Value_Varchar_50]
,[Value_Datetime]
,[Value_Decimal]
,[Value_Boolean]
,[Value_Nvarchar_255]
FROM [dbo].[uv_Account_Security]"></asp:SqlDataSource>
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
