using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;

namespace PIM2
{
    public partial class Transaction : System.Web.UI.Page
    {
        private string sStatus = "";
        private string sException = "";
        protected TextBox tbNewTransactionDate;
        protected ImageButton ibNewTransactionDate;
        protected Calendar calNewTransactionDate;
        protected DropDownList ddlNewTransactionDefinition;
        protected TextBox tbNewDebit;
        protected TextBox tbNewCredit;
        private string sTransactionTypeDebit = "Debit";
        private string sTransactionTypeCredit = "Credit";

        /*******************************************************************
         * Events
         * 
         * *****************************************************************
         * */

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    string sCurrentYear = DateTime.Now.Year.ToString();
                    tbBeginTransactionDate.Text = "1/1/" + sCurrentYear;
                    tbEndTransactionDate.Text = "12/31/" + sCurrentYear;
                }
            }
            catch (Exception ex)
            {
                DisplayException("Page_Load", ex.Message);
            }
        }

        protected void btnTransactions_Click(object sender, EventArgs e)
        {
            FindTransactions();
        }

        protected void lbInsert_Click(object sender, EventArgs e)
        {
            try
            {
                GetInsertControls();

                sdsTransactions.InsertParameters["iAccountID"].DefaultValue = ddlAccounts.SelectedItem.Value.ToString();
                sdsTransactions.InsertParameters["dtTransactionDate"].DefaultValue = tbNewTransactionDate.Text;
                sdsTransactions.InsertParameters["iTransactionDefinitionID"].DefaultValue = ddlNewTransactionDefinition.SelectedItem.Value.ToString();

                string sTransactionAmount = "";
                string sTransactionType = "";
                string sDebit = tbNewDebit.Text.Trim();
                string sCredit = tbNewCredit.Text.Trim();

                if (sDebit != "")
                {
                    sTransactionAmount = sDebit;
                    sTransactionType = sTransactionTypeDebit;
                }
                else
                {
                    sTransactionAmount = sCredit;
                    sTransactionType = sTransactionTypeCredit;
                }

                sdsTransactions.InsertParameters["dTransactionAmount"].DefaultValue = sTransactionAmount;
                sdsTransactions.InsertParameters["sTransactionType"].DefaultValue = sTransactionType;
                sdsTransactions.Insert();

                ClearInsertControls();

                sdsTransactions.SelectParameters["iAccountID"].DefaultValue = ddlAccounts.SelectedItem.Value.ToString();
                gvTransactions.DataSourceID = sdsTransactions.ID;
                gvTransactions.DataBind();
            }
            catch (Exception ex)
            {
                DisplayException("lbInsert_Click", ex.Message);
            }
        }

        protected void lbCancelInsert_Click(object sender, EventArgs e)
        {
            GetInsertControls();
            ClearInsertControls();
        }

        protected void lbCancelUpdate_Click(object sender, EventArgs e)
        {
            GetInsertControls();
            ClearInsertControls();            
        }

        protected void lbEdit_Click(object sender, EventArgs e)
        {
            GetInsertControls();
            ClearInsertControls();
        }

        protected void lbUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                TextBox tbTransactionDate = (TextBox)gvTransactions.Rows[gvTransactions.EditIndex].FindControl("tbTransactionDate");
                DropDownList ddlTransactionDefinition = (DropDownList)gvTransactions.Rows[gvTransactions.EditIndex].FindControl("ddlTransactionDefinition");
                TextBox tbDebit = (TextBox)gvTransactions.Rows[gvTransactions.EditIndex].FindControl("tbDebit");
                TextBox tbCredit = (TextBox)gvTransactions.Rows[gvTransactions.EditIndex].FindControl("tbCredit");

                sdsTransactions.UpdateParameters["iTransactionID"].DefaultValue = gvTransactions.DataKeys[gvTransactions.EditIndex].Value.ToString();
                sdsTransactions.UpdateParameters["iAccountID"].DefaultValue = ddlAccounts.SelectedItem.Value.ToString();
                sdsTransactions.UpdateParameters["dtTransactionDate"].DefaultValue = tbTransactionDate.Text;
                sdsTransactions.UpdateParameters["iTransactionDefinitionID"].DefaultValue = ddlTransactionDefinition.SelectedItem.Value.ToString();

                string sTransactionAmount = "";
                string sTransactionType = "";
                string sDebit = tbDebit.Text.Trim();
                string sCredit = tbCredit.Text.Trim();

                if (sDebit != "")
                {
                    sTransactionAmount = sDebit;
                    sTransactionType = sTransactionTypeDebit;
                }
                else
                {
                    sTransactionAmount = sCredit;
                    sTransactionType = sTransactionTypeCredit;
                }

                sdsTransactions.UpdateParameters["dTransactionAmount"].DefaultValue = sTransactionAmount;
                sdsTransactions.UpdateParameters["sTransactionType"].DefaultValue = sTransactionType;
                sdsTransactions.Update();

                GetInsertControls();
                ClearInsertControls();
            }
            catch (Exception ex)
            {
                DisplayException("lbUpdate_Click", ex.Message);
            }
        }

        protected void ibNewTransactionDate_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                GetInsertControls();

                if (calNewTransactionDate.Visible)
                {
                    calNewTransactionDate.Visible = false;
                }
                else
                {
                    calNewTransactionDate.Visible = true;
                }
            }
            catch (Exception ex)
            {                
                DisplayException("ibNewTransactionDate_Click", ex.Message);
            }
        }

        protected void calNewTransactionDate_SelectionChanged(object sender, EventArgs e)
        {
            try
            {
                GetInsertControls();
                tbNewTransactionDate.Text = calNewTransactionDate.SelectedDate.ToShortDateString();
                calNewTransactionDate.Visible = false;
            }
            catch (Exception ex)
            {
                DisplayException("calNewTransactionDate_SelectionChanged", ex.Message);
            }
        }

        protected void ibTransactionDate_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                Calendar calTransactionDate = (Calendar)gvTransactions.Rows[gvTransactions.EditIndex].FindControl("calTransactionDate");

                if (calTransactionDate.Visible)
                {
                    calTransactionDate.Visible = false;
                }
                else
                {
                    calTransactionDate.Visible = true;
                }
            }
            catch (Exception ex)
            {
                DisplayException("ibTransactionDate_Click", ex.Message);
            }
        }

        protected void calTransactionDate_SelectionChanged(object sender, EventArgs e)
        {
            try
            {
                TextBox tbTransactionDate = (TextBox)gvTransactions.Rows[gvTransactions.EditIndex].FindControl("tbTransactionDate");
                Calendar calTransactionDate = (Calendar)gvTransactions.Rows[gvTransactions.EditIndex].FindControl("calTransactionDate");
                tbTransactionDate.Text = calTransactionDate.SelectedDate.ToShortDateString();
                calTransactionDate.Visible = false;
            }
            catch (Exception ex)
            {
                DisplayException("calTransactionDate_SelectionChanged", ex.Message);
            }
        }

        protected void ibBeginTransactionDate_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                if (calBeginTransactionDate.Visible)
                {
                    calBeginTransactionDate.Visible = false;
                }
                else
                {
                    calBeginTransactionDate.Visible = true;
                }
            }
            catch (Exception ex)
            {
                DisplayException("ibBeginTransactionDate_Click", ex.Message);
            }
        }

        protected void calBeginTransactionDate_SelectionChanged(object sender, EventArgs e)
        {
            try
            {
                tbBeginTransactionDate.Text = calBeginTransactionDate.SelectedDate.ToShortDateString();
                calBeginTransactionDate.Visible = false;
            }
            catch (Exception ex)
            {
                DisplayException("calBeginTransactionDate_SelectionChanged", ex.Message);
            }
        }

        protected void ibEndTransactionDate_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                if (calEndTransactionDate.Visible)
                {
                    calEndTransactionDate.Visible = false;
                }
                else
                {
                    calEndTransactionDate.Visible = true;
                }
            }
            catch (Exception ex)
            {
                DisplayException("ibEndTransactionDate_Click", ex.Message);
            }
        }

        protected void calEndTransactionDate_SelectionChanged(object sender, EventArgs e)
        {
            try
            {
                tbEndTransactionDate.Text = calEndTransactionDate.SelectedDate.ToShortDateString();
                calEndTransactionDate.Visible = false;
            }
            catch (Exception ex)
            {
                DisplayException("calEndTransactionDate_SelectionChanged", ex.Message);
            }
        }

        protected void lbEmptyDataInsert_Click(object sender, EventArgs e)
        {
            try
            {
                TextBox tbEmptyDataTransactionDate = (TextBox)tblEmptyDataValue.FindControl("tbEmptyDataTransactionDate");
                DropDownList ddlEmptyDataTransactionDefinition = (DropDownList)tblEmptyDataValue.FindControl("ddlEmptyDataTransactionDefinition");
                TextBox tbEmptyDataDebit = (TextBox)tblEmptyDataValue.FindControl("tbEmptyDataDebit");
                TextBox tbEmptyDataCredit = (TextBox)tblEmptyDataValue.FindControl("tbEmptyDataCredit");

                sdsTransactions.InsertParameters["iAccountID"].DefaultValue = ddlAccounts.SelectedItem.Value.ToString();
                sdsTransactions.InsertParameters["dtTransactionDate"].DefaultValue = tbEmptyDataTransactionDate.Text;
                sdsTransactions.InsertParameters["iTransactionDefinitionID"].DefaultValue = ddlEmptyDataTransactionDefinition.SelectedItem.Value.ToString();

                string sTransactionAmount = "";
                string sTransactionType = "";
                string sDebit = tbEmptyDataDebit.Text.Trim();
                string sCredit = tbEmptyDataCredit.Text.Trim();

                if (sDebit != "")
                {
                    sTransactionAmount = sDebit;
                    sTransactionType = sTransactionTypeDebit;
                }
                else
                {
                    sTransactionAmount = sCredit;
                    sTransactionType = sTransactionTypeCredit;
                }

                sdsTransactions.InsertParameters["dTransactionAmount"].DefaultValue = sTransactionAmount;
                sdsTransactions.InsertParameters["sTransactionType"].DefaultValue = sTransactionType;
                sdsTransactions.Insert();

                sdsTransactions.SelectParameters["iAccountID"].DefaultValue = ddlAccounts.SelectedItem.Value.ToString();
                gvTransactions.DataSourceID = sdsTransactions.ID;
                gvTransactions.DataBind();

                tblEmptyDataValue.Visible = false;
            }
            catch (Exception ex)
            {
                DisplayException("lbEmptyDataInsert_Click", ex.Message);
            }
        }

        protected void gvTransactions_Deleted(object sender, GridViewDeletedEventArgs e)
        {
            try
            {
                if (gvTransactions.Rows.Count <= 1)
                {
                    tblEmptyDataValue.Visible = true;
                }
            }
            catch (Exception ex)
            {
                DisplayException("gvTransactions_Deleted", ex.Message);
            }
        }

        protected void ibEmptyDataTransactionDate_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                if (calEmptyDataTransactionDate.Visible)
                {
                    calEmptyDataTransactionDate.Visible = false;
                }
                else
                {
                    calEmptyDataTransactionDate.Visible = true;
                }
            }
            catch (Exception ex)
            {
                DisplayException("ibEmptyDataTransactionDate_Click", ex.Message);
            }
        }

        protected void calEmptyDataTransactionDate_SelectionChanged(object sender, EventArgs e)
        {
            try
            {
                tbEmptyDataTransactionDate.Text = calEmptyDataTransactionDate.SelectedDate.ToShortDateString();
                calEmptyDataTransactionDate.Visible = false;
            }
            catch (Exception ex)
            {
                DisplayException("calEmptyDataTransactionDate_SelectionChanged", ex.Message);
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
                tbNewTransactionDate.Text = "";
                calNewTransactionDate.Visible = false;
                ddlNewTransactionDefinition.DataSourceID = sdsTransactionDefinitions.ID;
                ddlNewTransactionDefinition.DataBind();
                tbNewDebit.Text = "";
                tbNewCredit.Text = "";
                gvTransactions.EditIndex = -1;
            }
            catch (Exception ex)
            {
                DisplayException("ClearInsertControls", ex.Message);
            }
        }

        private void GetInsertControls()
        {
            try
            {
                tbNewTransactionDate = (TextBox)gvTransactions.FooterRow.FindControl("tbNewTransactionDate");
                ibNewTransactionDate = (ImageButton)gvTransactions.FooterRow.FindControl("ibNewTransactionDate");
                calNewTransactionDate = (Calendar)gvTransactions.FooterRow.FindControl("calNewTransactionDate");
                ddlNewTransactionDefinition = (DropDownList)gvTransactions.FooterRow.FindControl("ddlNewTransactionDefinition");
                tbNewDebit = (TextBox)gvTransactions.FooterRow.FindControl("tbNewDebit");
                tbNewCredit = (TextBox)gvTransactions.FooterRow.FindControl("tbNewCredit");
            }
            catch (Exception ex)
            {
                DisplayException("GetInsertControls", ex.Message);
            }
        }

        private void FindTransactions()
        {
            try
            {
                sdsTransactions.SelectParameters["iAccountID"].DefaultValue = ddlAccounts.SelectedItem.Value.ToString();
                sdsTransactions.SelectParameters["dtBeginTransactionDate"].DefaultValue = tbBeginTransactionDate.Text;
                sdsTransactions.SelectParameters["dtEndTransactionDate"].DefaultValue = tbEndTransactionDate.Text;
                gvTransactions.DataSourceID = sdsTransactions.ID;
                gvTransactions.DataBind();

                if (gvTransactions.Rows.Count == 0)
                {
                    tblEmptyDataValue.Visible = true;
                }
            }
            catch (Exception ex)
            {
                DisplayException("FindTransactions", ex.Message);
            }
        }
    }
}