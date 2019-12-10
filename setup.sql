USE [master]
GO

CREATE DATABASE [ODataEFCoreShadowKeys]
GO

USE [ODataEFCoreShadowKeys]
GO

CREATE TABLE [dbo].[Person](
	[ShadowId] [int] NOT NULL DEFAULT 1,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
    CONSTRAINT [PK_Owner] PRIMARY KEY CLUSTERED ([ShadowId] ASC, [Id] ASC)
)
GO

CREATE TABLE [dbo].[Pet](
	[ShadowId] [int] NOT NULL DEFAULT 1,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[OwnerId] [int] NULL,
    CONSTRAINT [PK_Pets] PRIMARY KEY CLUSTERED ([ShadowId] ASC, [Id] ASC)
)
GO

ALTER TABLE [dbo].[Pet]  WITH CHECK ADD  CONSTRAINT [FK_Pet_Owner] FOREIGN KEY([ShadowId], [OwnerId]) REFERENCES [dbo].[Person] ([ShadowId], [Id])
GO

ALTER TABLE [dbo].[Pet] CHECK CONSTRAINT [FK_Pet_Owner]
GO

USE [master]
GO

ALTER DATABASE [ODataEFCoreShadowKeys] SET READ_WRITE 
GO

USE [ODataEFCoreShadowKeys]
GO

SET IDENTITY_INSERT [dbo].[Person] ON 
INSERT [dbo].[Person] ([Id], [Name]) VALUES (4, N'Annie')
SET IDENTITY_INSERT [dbo].[Person] OFF
GO

SET IDENTITY_INSERT [dbo].[Pet] ON 
INSERT [dbo].[Pet] ([Id], [Name], [OwnerId]) VALUES (4, N'Mittens', 4)
INSERT [dbo].[Pet] ([Id], [Name], [OwnerId]) VALUES (5, N'Patches', NULL)
SET IDENTITY_INSERT [dbo].[Pet] OFF
GO

SELECT [p].[ShadowId], [p].[Id], [p].[Name], [p].[OwnerId], [p.Owner].[ShadowId], [p.Owner].[Id], [p.Owner].[Name]
FROM [Pet] AS [p]
LEFT JOIN [Person] AS [p.Owner] ON ([p].[ShadowId] = [p.Owner].[ShadowId]) AND ([p].[OwnerId] = [p.Owner].[Id])