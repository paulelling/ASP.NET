using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;

namespace PIM2
{
    public partial class Budget : System.Web.UI.Page
    {
        private string sStatus = "";
        private string sException = "";
        protected DropDownList ddlNewBudgetItem;
        protected TextBox tbNewPayPeriod1;
        protected TextBox tbNewPayPeriod2;
        private string sPeriod1 = "Period 1";
        private string sPeriod2 = "Period 2";

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                ddlNewBudgetItem = (DropDownList)gvBudget.FooterRow.FindControl("ddlNewBudgetItem");
                tbNewPayPeriod1 = (TextBox)gvBudget.FooterRow.FindControl("tbNewPayPeriod1");
                tbNewPayPeriod2 = (TextBox)gvBudget.FooterRow.FindControl("tbNewPayPeriod2");
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
                string sPayPeriodAmount1 = tbNewPayPeriod1.Text;    

                if (sPayPeriodAmount1.Trim() != "")
                {
                    sdsBudget.InsertParameters["iItemID"].DefaultValue = ddlNewBudgetItem.SelectedValue;
                    sdsBudget.InsertParameters["sPayPeriod"].DefaultValue = sPeriod1;
                    sdsBudget.InsertParameters["dAmount"].DefaultValue = sPayPeriodAmount1;
                    sdsBudget.Insert();
                }

                string sPayPeriodAmount2 = tbNewPayPeriod2.Text;

                if (sPayPeriodAmount2.Trim() != "")
                {
                    sdsBudget.InsertParameters["iItemID"].DefaultValue = ddlNewBudgetItem.SelectedValue;
                    sdsBudget.InsertParameters["sPayPeriod"].DefaultValue = sPeriod2;
                    sdsBudget.InsertParameters["dAmount"].DefaultValue = sPayPeriodAmount2;
                    sdsBudget.Insert();
                }            

                ClearInsertControls();

                gvBudget.DataSourceID = sdsBudget.ID;
                gvBudget.DataBind();
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
                DropDownList ddlBudgetItem = (DropDownList)gvBudget.Rows[gvBudget.EditIndex].FindControl("ddlBudgetItem");

                TextBox tbPayPeriod1 = (TextBox)gvBudget.Rows[gvBudget.EditIndex].FindControl("tbPayPeriod1");
                string sPayPeriodAmount1 = tbPayPeriod1.Text;

                if (sPayPeriodAmount1.Trim() != "")
                {
                    sdsBudget.UpdateParameters["iItemID"].DefaultValue = ddlBudgetItem.SelectedValue;
                    sdsBudget.UpdateParameters["sPayPeriod"].DefaultValue = sPeriod1;
                    sdsBudget.UpdateParameters["dAmount"].DefaultValue = sPayPeriodAmount1;
                    sdsBudget.Update();
                }

                TextBox tbPayPeriod2 = (TextBox)gvBudget.Rows[gvBudget.EditIndex].FindControl("tbPayPeriod2");
                string sPayPeriodAmount2 = tbPayPeriod2.Text;

                if (sPayPeriodAmount2.Trim() != "")
                {
                    sdsBudget.UpdateParameters["iItemID"].DefaultValue = ddlBudgetItem.SelectedValue;
                    sdsBudget.UpdateParameters["sPayPeriod"].DefaultValue = sPeriod2;
                    sdsBudget.UpdateParameters["dAmount"].DefaultValue = sPayPeriodAmount2;
                    sdsBudget.Update();
                }

                ClearInsertControls();
            }
            catch (Exception ex)
            {
                DisplayException("lbUpdate_Click", ex.Message);
            }
        }

        protected void gvBudget_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                Label lblBudgetItem = (Label)gvBudget.SelectedRow.FindControl("lblBudgetItem");
                string sBudgetItem = lblBudgetItem.Text;

                sdsBudget.DeleteParameters["iItemID"].DefaultValue = "0";
                sdsBudget.DeleteParameters["sBudgetItem"].DefaultValue = sBudgetItem;
                sdsBudget.DeleteParameters["sPayPeriod"].DefaultValue = "";
                sdsBudget.DeleteParameters["dAmount"].DefaultValue = "0";
                sdsBudget.Delete();

                gvBudget.DataSourceID = sdsBudget.ID;
                gvBudget.DataBind();
            }
            catch (Exception ex)
            {
                DisplayException("gvBudget_SelectedIndexChanged", ex.Message);
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
                ddlNewBudgetItem.DataSourceID = sdsBudgetItems.ID;
                ddlNewBudgetItem.DataBind();
                tbNewPayPeriod1.Text = "";
                tbNewPayPeriod2.Text = "";
                gvBudget.EditIndex = -1;
            }
            catch (Exception ex)
            {
                DisplayException("ClearInsertControls", ex.Message);
            }
        }
    }
}