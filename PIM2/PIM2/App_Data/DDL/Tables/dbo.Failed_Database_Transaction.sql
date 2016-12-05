CREATE TABLE [dbo].[Failed_Database_Transaction](
	[Transaction_ID] [int] IDENTITY(1,1) NOT NULL,
	[Transaction_Date] [datetime] NULL,
	[Database_Object] [varchar](50) NOT NULL,
	[Database_Command] [varchar](50) NOT NULL,
	[Error_Number] [int] NULL,
	[Error_Message] [nvarchar](4000) NULL,
	[Error_Severity] [int] NULL,
	[Error_State] [int] NULL,
	[Error_Line] [int] NULL,
	[Error_Procedure] [nvarchar](200) NULL,
 CONSTRAINT [PK_Failed_Transaction] PRIMARY KEY CLUSTERED 
(
	[Transaction_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


