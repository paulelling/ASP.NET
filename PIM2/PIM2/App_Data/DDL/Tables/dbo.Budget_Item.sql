CREATE TABLE [dbo].[Budget_Item](
	[Item_ID] [int] NOT NULL,
	[Pay_Period] [int] NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Budget_Item] PRIMARY KEY CLUSTERED 
(
	[Item_ID] ASC,
	[Pay_Period] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Budget_Item]  WITH CHECK ADD  CONSTRAINT [FK_Budget_Item_Type_Value] FOREIGN KEY([Item_ID])
REFERENCES [dbo].[Type_Value] ([Value_ID])
GO

ALTER TABLE [dbo].[Budget_Item] CHECK CONSTRAINT [FK_Budget_Item_Type_Value]
GO

ALTER TABLE [dbo].[Budget_Item]  WITH CHECK ADD  CONSTRAINT [FK_Budget_Item_Type_Value1] FOREIGN KEY([Pay_Period])
REFERENCES [dbo].[Type_Value] ([Value_ID])
GO

ALTER TABLE [dbo].[Budget_Item] CHECK CONSTRAINT [FK_Budget_Item_Type_Value1]
GO


