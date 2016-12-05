using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;

namespace PIM2
{
    public partial class Type_Value : System.Web.UI.Page
    {
        private string sStatus = "";
        private string sException = "";
        protected TextBox tbNewValue;
        private int iOrderByColumn = 1;
        private string sTypeID = "0";
        
        /*******************************************************************
         * Events
         * 
         * *****************************************************************
         * */

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                sTypeID = Request.QueryString.Get("TypeID");
                string sType = Request.QueryString.Get("Type");            
                sdsTypeValues.SelectParameters["iTypeID"].DefaultValue = sTypeID;
                lblPageTitle.Text = sType;

                if (gvValues.Rows.Count > 0)
                {
                    tbNewValue = (TextBox)gvValues.FooterRow.FindControl("tbNewValue");
                }
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
                sdsTypeValues.InsertParameters["sValue"].DefaultValue = tbNewValue.Text;
                sdsTypeValues.InsertParameters["iTypeID"].DefaultValue = sTypeID;
                sdsTypeValues.Insert();

                ClearInsertControls();

                gvValues.DataSourceID = sdsTypeValues.ID;
                gvValues.DataBind();
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
                gvValues.Columns[iOrderByColumn].Visible = true;
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
                TextBox tbValue = (TextBox)gvValues.Rows[gvValues.EditIndex].FindControl("tbValue");
                TextBox tbOrderBy = (TextBox)gvValues.Rows[gvValues.EditIndex].FindControl("tbOrderBy");

                sdsTypeValues.UpdateParameters["iValueID"].DefaultValue = gvValues.DataKeys[gvValues.EditIndex].Value.ToString();
                sdsTypeValues.UpdateParameters["sValue"].DefaultValue = tbValue.Text;
                sdsTypeValues.UpdateParameters["iOrderBy"].DefaultValue = tbOrderBy.Text;
                sdsTypeValues.Update();

                ClearInsertControls();
            }
            catch (Exception ex)
            {
                DisplayException("lbUpdate_Click", ex.Message);
            }
        }

        protected void gvValues_Load(object sender, EventArgs e)
        {
            try
            {
                if (gvValues.Rows.Count == 0)
                {
                    tblEmptyDataValue.Visible = true;
                }
            }
            catch (Exception ex)
            {
                DisplayException("gvValues_Load", ex.Message);
            }
        }

        protected void lbEmptyDataInsert_Click(object sender, EventArgs e)
        {
            try
            {
                TextBox tbEmptyDataValue = (TextBox)tblEmptyDataValue.FindControl("tbEmptyDataValue");

                sdsTypeValues.InsertParameters["sValue"].DefaultValue = tbEmptyDataValue.Text;
                sdsTypeValues.InsertParameters["iTypeID"].DefaultValue = sTypeID;
                sdsTypeValues.Insert();

                gvValues.DataSourceID = sdsTypeValues.ID;
                gvValues.DataBind();

                tblEmptyDataValue.Visible = false;
            }
            catch (Exception ex)
            {
                DisplayException("lbEmptyDataInsert_Click", ex.Message);
            }
        }

        protected void gvValues_Deleted(object sender, GridViewDeletedEventArgs e)
        {
            try
            {
                if (gvValues.Rows.Count <= 1)
                {
                    tblEmptyDataValue.Visible = true;
                }
            }
            catch (Exception ex)
            {
                DisplayException("gvValues_Deleted", ex.Message);
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
                tbNewValue.Text = "";
                gvValues.EditIndex = -1;
            }
            catch (Exception ex)
            {
                DisplayException("ClearInsertControls", ex.Message);
            }
        }
    }
}