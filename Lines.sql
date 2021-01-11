SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Lines](
	[id] [uniqueidentifier] NOT NULL,
	[file-id] [uniqueidentifier] NOT NULL,
	[row] [int] NOT NULL,
	[status] [varchar](max) NOT NULL,
	[status_reason] [varchar](max) NULL,
	[processingstarttime] [datetime] NULL,
	[processingendtime] [datetime] NULL,
	[flow-uuid] [varchar](max) NULL
 CONSTRAINT [PK_PS-Lines] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [dbo].[PRJ0046-Lines] ADD  CONSTRAINT [DF_PS-Lines_id]  DEFAULT (newid()) FOR [id]
GO

