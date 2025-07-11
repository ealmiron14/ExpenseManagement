USE [DBBudget_2]
GO
/****** Object:  Table [dbo].[Constante]    Script Date: 15/11/2024 15:06:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConstantValue](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](50) NOT NULL,
	[Amount] [money] NOT NULL,
	[EffectiveDate] [date] NOT NULL,
	[NullDate] [date] NULL,
	[UpdateDate] [date] NOT NULL
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[ConstantValue]
   ADD CONSTRAINT PK_ConstantValue_ID PRIMARY KEY CLUSTERED (Id)
GO

/****** Object:  Table [dbo].[Movimiento]    Script Date: 15/11/2024 15:06:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movement](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](50) NOT NULL,
	[Amount] [money] NOT NULL,
--	[IdTipo] [int] NULL,
	[MovementSubTypeId] [int] NULL,
	[CompletionDate] [date] NOT NULL,
	[EffectiveDate] [date] NULL,
	[UpdateDate] [date] NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Movement]
   ADD CONSTRAINT PK_Movement_Id PRIMARY KEY CLUSTERED (Id)
GO

/****** Object:  Table [dbo].[SubTipoMovimiento]    Script Date: 15/11/2024 15:06:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovementSubType](
	[Id] [int] NOT NULL,
	[Description] [varchar](50) NOT NULL,
	[MovementTypeId] [int] NOT NULL
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[MovementSubType]
   ADD CONSTRAINT PK_MovementSubType_Id PRIMARY KEY CLUSTERED (Id, MovementTypeId)
GO


/****** Object:  Table [dbo].[TipoMovimiento]    Script Date: 15/11/2024 15:06:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovementType](
	[Id] [int] NOT NULL,
	[Description] [varchar](50) NOT NULL
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[MovementType]
   ADD CONSTRAINT PK_MovementType_Id PRIMARY KEY CLUSTERED (Id)
GO


USE [master]
GO
ALTER DATABASE [DBBudget_2] SET  READ_WRITE 
GO
