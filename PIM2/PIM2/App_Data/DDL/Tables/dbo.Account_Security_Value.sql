CREATE TABLE [dbo].[Account_Security_Value](
	[Value_ID] [int] IDENTITY(1,1) NOT NULL,
	[Value_Integer] [int] NULL,
	[Value_Varchar_50] [varchar](50) NULL,
	[Value_Datetime] [datetime] NULL,
	[Value_Decimal] [decimal](18, 2) NULL,
	[Value_Boolean] [bit] NULL,
	[Value_Nvarchar_255] [nvarchar](255) NULL,
	[Account_Security_ID] [int] NOT NULL,
	[Attribute_ID] [int] NOT NULL,
 CONSTRAINT [PK_Setting_Value] PRIMARY KEY CLUSTERED 
(
	[Value_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_Setting_Value] UNIQUE NONCLUSTERED 
(
	[Account_Security_ID] ASC,
	[Attribute_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[Account_Security_Value]  WITH CHECK ADD  CONSTRAINT [FK_Account_Security_Value_Account_Security] FOREIGN KEY([Account_Security_ID])
REFERENCES [dbo].[Account_Security] ([Account_Security_ID])
GO

ALTER TABLE [dbo].[Account_Security_Value] CHECK CONSTRAINT [FK_Account_Security_Value_Account_Security]
GO

ALTER TABLE [dbo].[Account_Security_Value]  WITH CHECK ADD  CONSTRAINT [FK_Account_Security_Value_Account_Security_Attribute] FOREIGN KEY([Attribute_ID])
REFERENCES [dbo].[Account_Security_Attribute] ([Attribute_ID])
GO

ALTER TABLE [dbo].[Account_Security_Value] CHECK CONSTRAINT [FK_Account_Security_Value_Account_Security_Attribute]
GO


