using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;

namespace PIM2
{
    public partial class Definition : System.Web.UI.Page
    {
        private string sStatus = "";
        private string sException = "";
        protected DropDownList ddlNewTransactionDescription;
        protected DropDownList ddlNewTransactionDescriptionType;
        protected DropDownList ddlNewTransactionCategory;

        /*******************************************************************
         * Events
         * 
         * *****************************************************************
         * */

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                ddlNewTransactionDescription = (DropDownList)gvDefinitions.FooterRow.FindControl("ddlNewTransactionDescription");
                ddlNewTransactionDescriptionType = (DropDownList)gvDefinitions.FooterRow.FindControl("ddlNewTransactionDescriptionType");
                ddlNewTransactionCategory = (DropDownList)gvDefinitions.FooterRow.FindControl("ddlNewTransactionCategory");
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
                sdsDefinitions.InsertParameters["iTransactionDescriptionID"].DefaultValue = ddlNewTransactionDescription.SelectedValue;
                sdsDefinitions.InsertParameters["iTransactionDescriptionTypeID"].DefaultValue = ddlNewTransactionDescriptionType.SelectedValue;
                sdsDefinitions.InsertParameters["iTransactionCategoryID"].DefaultValue = ddlNewTransactionCategory.SelectedValue;
                sdsDefinitions.Insert();

                ClearInsertControls();

                gvDefinitions.DataSourceID = sdsDefinitions.ID;
                gvDefinitions.DataBind();
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
                DropDownList ddlTransactionDescription = (DropDownList)gvDefinitions.Rows[gvDefinitions.EditIndex].FindControl("ddlTransactionDescription");
                DropDownList ddlTransactionDescriptionType = (DropDownList)gvDefinitions.Rows[gvDefinitions.EditIndex].FindControl("ddlTransactionDescriptionType");
                DropDownList ddlTransactionCategory = (DropDownList)gvDefinitions.Rows[gvDefinitions.EditIndex].FindControl("ddlTransactionCategory");

                sdsDefinitions.UpdateParameters["iTransactionDefinitionID"].DefaultValue = gvDefinitions.DataKeys[gvDefinitions.EditIndex].Value.ToString();
                sdsDefinitions.UpdateParameters["iTransactionDescriptionID"].DefaultValue = ddlTransactionDescription.SelectedValue;
                sdsDefinitions.UpdateParameters["iTransactionDescriptionTypeID"].DefaultValue = ddlTransactionDescriptionType.SelectedValue;
                sdsDefinitions.UpdateParameters["iTransactionCategoryID"].DefaultValue = ddlTransactionCategory.SelectedValue;
                sdsDefinitions.Update();

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
                ddlNewTransactionDescription.DataSourceID = sdsTransactionDescriptions.ID;
                ddlNewTransactionDescription.DataBind();
                ddlNewTransactionDescriptionType.DataSourceID = sdsTransactionDescriptionTypes.ID;
                ddlNewTransactionDescriptionType.DataBind();
                ddlNewTransactionCategory.DataSourceID = sdsTransactionCategories.ID;
                ddlNewTransactionCategory.DataBind();
                gvDefinitions.EditIndex = -1;
            }
            catch (Exception ex)
            {
                DisplayException("ClearInsertControls", ex.Message);
            }
        }
    }
}