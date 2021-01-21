SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Files](
	[id] [uniqueidentifier] NOT NULL,
	[filename] [varchar](max) NOT NULL,
	[status] [varchar](50) NOT NULL,
	[status_reason] [varchar](max) NULL,
	[uploadstarttime] [datetime] NULL,
	[uploadcompletetime] [datetime] NULL,
	[processingstarttime] [datetime] NULL,
	[processingendtime] [datetime] NULL,
	[num_lines] [int] NULL,
	[lines_started] [int] NULL,
	[lines_failed] [int] NULL,
	[lines_complete] [int] NULL,
 CONSTRAINT [PK_PS-Spreadsheets] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [dbo].[Files] ADD  CONSTRAINT [DF_PS-Spreadsheets_id]  DEFAULT (newid()) FOR [id]
GO

