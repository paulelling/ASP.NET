using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;

namespace PIM2
{
    public partial class Spending : System.Web.UI.Page
    {
        private string sStatus = "";
        private string sException = "";

        /*******************************************************************
         * Events
         * 
         * *****************************************************************
         * */

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSpending_Click(object sender, EventArgs e)
        {
            ViewSpending();
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

        private void ViewSpending()
        {
            try
            {
                sdsSpending.SelectParameters["iYear"].DefaultValue = ddlSpendingYears.SelectedItem.Value.ToString();
                gvSpending.DataSourceID = sdsSpending.ID;
                gvSpending.DataBind();

                int iRowCount = gvSpending.Rows.Count;
                int iRow = 0;
                int iCellCount = 0;
                int iCell = 0;
                string sValue = "";

                for (iRow = 0; iRow < iRowCount; iRow++)
                {
                    iCellCount = gvSpending.Rows[iRow].Cells.Count;
                    iCell = 0;

                    for (iCell = 0; iCell < iCellCount; iCell++)
                    {
                        sValue = gvSpending.Rows[iRow].Cells[iCell].Text;

                        if (sValue == "Total Expenses" || sValue == "Total Extra Spending" || sValue == "Total Spending")
                        {
                            gvSpending.Rows[iRow].Font.Bold = true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                DisplayException("ViewSpending", ex.Message);
            }
        }
    }
}