using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;

namespace PIM2
{
    public partial class Vendor : System.Web.UI.Page
    {
        private string sStatus = "";
        private string sException = "";
        protected TextBox tbNewName;
        protected DropDownList ddlNewVendorType;
        
        /*******************************************************************
         * Events
         * 
         * *****************************************************************
         * */

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                tbNewName = (TextBox)gvVendors.FooterRow.FindControl("tbNewName");
                ddlNewVendorType = (DropDownList)gvVendors.FooterRow.FindControl("ddlNewVendorType");
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
                sdsVendors.InsertParameters["sVendor"].DefaultValue = tbNewName.Text;
                sdsVendors.InsertParameters["iVendorTypeID"].DefaultValue = ddlNewVendorType.SelectedValue;
                sdsVendors.Insert();

                ClearInsertControls();

                gvVendors.DataSourceID = sdsVendors.ID;
                gvVendors.DataBind();
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
            ClearInsertControls();
        }

        protected void lbUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                TextBox tbName = (TextBox)gvVendors.Rows[gvVendors.EditIndex].FindControl("tbName");
                DropDownList ddlVendorType = (DropDownList)gvVendors.Rows[gvVendors.EditIndex].FindControl("ddlVendorType");

                sdsVendors.UpdateParameters["iVendorID"].DefaultValue = gvVendors.DataKeys[gvVendors.EditIndex].Value.ToString();
                sdsVendors.UpdateParameters["sVendor"].DefaultValue = tbName.Text;
                sdsVendors.UpdateParameters["iVendorTypeID"].DefaultValue = ddlVendorType.SelectedValue;
                sdsVendors.Update();

                ClearInsertControls();
            }
            catch (Exception ex)
            {
                DisplayException("lbUpdate_Click", ex.Message);
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
                tbNewName.Text = "";
                ddlNewVendorType.DataSourceID = sdsVendorType.ID;
                ddlNewVendorType.DataBind();
                gvVendors.EditIndex = -1;
            }
            catch (Exception ex)
            {
                DisplayException("ClearInsertControls", ex.Message);
            }
        }

    }
}