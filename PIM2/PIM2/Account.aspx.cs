using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;

namespace PIM2
{
    public partial class Account : System.Web.UI.Page
    {
        private string sStatus = "";
        private string sException = "";
        protected DropDownList ddlNewVendor;
        protected DropDownList ddlNewAccountType;
        private int iOrderByColumn = 2;

        /*******************************************************************
         * Events
         * 
         * *****************************************************************
         * */

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                ddlNewVendor = (DropDownList)gvAccounts.FooterRow.FindControl("ddlNewVendor");
                ddlNewAccountType = (DropDownList)gvAccounts.FooterRow.FindControl("ddlNewAccountType");
            }
            catch (Exception ex)
            {
                DisplayException("Page_Load", ex.Message);
            }
        }

        protected void lbInsert_Click(object sender, EventArgs e)
        {
            try
            {
                sdsAccounts.InsertParameters["iVendorID"].DefaultValue = ddlNewVendor.Text;
                sdsAccounts.InsertParameters["iAccountTypeID"].DefaultValue = ddlNewAccountType.SelectedValue;
                sdsAccounts.Insert();

                ClearInsertControls();

                gvAccounts.DataSourceID = sdsAccounts.ID;
                gvAccounts.DataBind();
            }
            catch (Exception ex)
            {
                DisplayException("lbInsert_Click", ex.Message);
            }
        }

        protected void lbCancelInsert_Click(object sender, EventArgs e)
        {
            ClearInsertControls();
        }

        protected void lbCancelUpdate_Click(object sender, EventArgs e)
        {
            ClearInsertControls();
        }

        protected void lbEdit_Click(object sender, EventArgs e)
        {
            try
            {
                ClearInsertControls();
                gvAccounts.Columns[iOrderByColumn].Visible = true;
            }
            catch (Exception ex)
            {
                DisplayException("lbEdit_Click", ex.Message);
            }
        }

        protected void lbUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                DropDownList ddlVendor = (DropDownList)gvAccounts.Rows[gvAccounts.EditIndex].FindControl("ddlVendor");
                DropDownList ddlAccountType = (DropDownList)gvAccounts.Rows[gvAccounts.EditIndex].FindControl("ddlAccountType");
                TextBox tbOrderBy = (TextBox)gvAccounts.Rows[gvAccounts.EditIndex].FindControl("tbOrderBy");

                sdsAccounts.UpdateParameters["iAccountID"].DefaultValue = gvAccounts.DataKeys[gvAccounts.EditIndex].Value.ToString();
                sdsAccounts.UpdateParameters["iVendorID"].DefaultValue = ddlVendor.SelectedValue;
                sdsAccounts.UpdateParameters["iAccountTypeID"].DefaultValue = ddlAccountType.SelectedValue;
                sdsAccounts.UpdateParameters["iOrderBy"].DefaultValue = tbOrderBy.Text;
                sdsAccounts.Update();

                ClearInsertControls();
            }
            catch (Exception ex)
            {
                DisplayException("lbUpdate_Click", ex.Message);
            }            
        }

        protected void lbSecurity_Command(object sender, CommandEventArgs e)
        {
            try
            {
                Response.Redirect("~/Account_Security.aspx?id=" + e.CommandArgument.ToString());
            }
            catch (Exception ex)
            {
                DisplayException("lbSecurity_Command", ex.Message);
            }
        }

        /*******************************************************************
         * General subroutines
         * 
         * *****************************************************************
         * */

        private void SetStatus(string sNewStatus, bool bException)
        {
            sStatus = sStatus + " " + sNewStatus;
            lblStatus.Text = sStatus;

            if (bException)
            {
                lblStatus.ForeColor = Color.Red;
            }
        }

        private void DisplayException(string sSubroutine, string sNewException)
        {
            sException = sException + " (" + sSubroutine + ")";
            sException = sException + " " + sNewException;
            SetStatus(sException, true);
        }

        private void ClearInsertControls()
        {
            try
            {
                ddlNewVendor.DataSourceID = sdsVendors.ID;
                ddlNewVendor.DataBind();
                ddlNewAccountType.DataSourceID = sdsAccountTypes.ID;
                ddlNewAccountType.DataBind();
                gvAccounts.EditIndex = -1;
            }
            catch (Exception ex)
            {
                DisplayException("ClearInsertControls", ex.Message);
            }          
        }
    }
}