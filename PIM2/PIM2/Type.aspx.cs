using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;

namespace PIM2
{
    public partial class Type : System.Web.UI.Page
    {
        private string sStatus = "";
        private string sException = "";
        protected TextBox tbNewType;
        private int iOrderByColumn = 1;

        /*******************************************************************
         * Events
         * 
         * *****************************************************************
         * */

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                tbNewType = (TextBox)gvTypes.FooterRow.FindControl("tbNewType");
            }
            catch (Exception ex)
            {
                DisplayException("Page_Load", ex.Message);
            }
        }

        protected void gvTypes_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                ClearInsertControls();
                Label lblType = (Label)gvTypes.Rows[gvTypes.SelectedIndex].FindControl("lblType");
                Response.Redirect("~/Type_Value.aspx?TypeID=" + gvTypes.DataKeys[gvTypes.SelectedIndex].Value.ToString() + "&Type=" + lblType.Text);
            }
            catch (Exception ex)
            {
                DisplayException("gvTypes_SelectedIndexChanged", ex.Message);
            }
        }

        protected void lbInsert_Click(object sender, EventArgs e)
        {
            try
            {
                sdsTypes.InsertParameters["sType"].DefaultValue = tbNewType.Text;
                sdsTypes.Insert();

                ClearInsertControls();

                gvTypes.DataSourceID = sdsTypes.ID;
                gvTypes.DataBind();
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
                gvTypes.Columns[iOrderByColumn].Visible = true;
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
                TextBox tbType = (TextBox)gvTypes.Rows[gvTypes.EditIndex].FindControl("tbType");
                TextBox tbOrderBy = (TextBox)gvTypes.Rows[gvTypes.EditIndex].FindControl("tbOrderBy");

                sdsTypes.UpdateParameters["iTypeID"].DefaultValue = gvTypes.DataKeys[gvTypes.EditIndex].Value.ToString();
                sdsTypes.UpdateParameters["sType"].DefaultValue = tbType.Text;
                sdsTypes.UpdateParameters["iOrderBy"].DefaultValue = tbOrderBy.Text;
                sdsTypes.Update();

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
                tbNewType.Text = "";
                gvTypes.EditIndex = -1;
            }
            catch (Exception ex)
            {
                DisplayException("ClearInsertControls", ex.Message);
            }
        }
    }
}