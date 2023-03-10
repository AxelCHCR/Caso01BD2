USE [master]
GO
/****** Object:  Database [Caso01_Ferianueva]    Script Date: 16/2/2023 14:11:37 ******/
CREATE DATABASE [Caso01_Ferianueva]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Caso01_Ferianueva', FILENAME = N'D:\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Caso01_Ferianueva.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Caso01_Ferianueva_log', FILENAME = N'D:\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Caso01_Ferianueva_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Caso01_Ferianueva] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Caso01_Ferianueva].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Caso01_Ferianueva] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Caso01_Ferianueva] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Caso01_Ferianueva] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Caso01_Ferianueva] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Caso01_Ferianueva] SET ARITHABORT OFF 
GO
ALTER DATABASE [Caso01_Ferianueva] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Caso01_Ferianueva] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Caso01_Ferianueva] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Caso01_Ferianueva] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Caso01_Ferianueva] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Caso01_Ferianueva] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Caso01_Ferianueva] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Caso01_Ferianueva] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Caso01_Ferianueva] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Caso01_Ferianueva] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Caso01_Ferianueva] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Caso01_Ferianueva] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Caso01_Ferianueva] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Caso01_Ferianueva] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Caso01_Ferianueva] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Caso01_Ferianueva] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Caso01_Ferianueva] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Caso01_Ferianueva] SET RECOVERY FULL 
GO
ALTER DATABASE [Caso01_Ferianueva] SET  MULTI_USER 
GO
ALTER DATABASE [Caso01_Ferianueva] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Caso01_Ferianueva] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Caso01_Ferianueva] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Caso01_Ferianueva] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Caso01_Ferianueva] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Caso01_Ferianueva] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Caso01_Ferianueva', N'ON'
GO
ALTER DATABASE [Caso01_Ferianueva] SET QUERY_STORE = OFF
GO
USE [Caso01_Ferianueva]
GO
/****** Object:  Table [dbo].[Facturas]    Script Date: 16/2/2023 14:11:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Facturas](
	[numFactura] [int] NOT NULL,
	[fechaFactura] [datetime] NOT NULL,
	[numPedido] [int] NOT NULL,
	[total] [float] NOT NULL,
	[detalles] [varchar](200) NOT NULL,
 CONSTRAINT [PK_Facturas] PRIMARY KEY CLUSTERED 
(
	[numFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pedidos]    Script Date: 16/2/2023 14:11:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pedidos](
	[numPedido] [int] NOT NULL,
	[fechaPedido] [date] NOT NULL,
	[idEstadoP] [int] NOT NULL,
	[totales] [float] NULL,
	[codUsuario] [int] NULL,
 CONSTRAINT [PK_Pedidos] PRIMARY KEY CLUSTERED 
(
	[numPedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 16/2/2023 14:11:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[codUsuario] [int] IDENTITY(1,1) NOT NULL,
	[nomUsu] [varchar](50) NOT NULL,
	[contraseña] [varchar](50) NOT NULL,
	[Identificacion_Personal] [int] NOT NULL,
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[codUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[top5BestBuyers]    Script Date: 16/2/2023 14:11:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[top5BestBuyers] AS
SELECT TOP 5
U.nomUsu, U.Identificacion_Personal, SUM(F.total) AS 'Total' FROM dbo.Usuarios U
INNER JOIN dbo.Pedidos P ON P.codUsuario = U.codUsuario
INNER JOIN dbo.Facturas F ON P.numPedido = F.numPedido
GROUP BY U.nomUsu, U.Identificacion_Personal ORDER BY 'Total' DESC
GO
/****** Object:  Table [dbo].[PedidosXProductos]    Script Date: 16/2/2023 14:11:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PedidosXProductos](
	[numPedido] [int] NOT NULL,
	[codProducto] [int] NOT NULL,
	[cantidadProducto] [int] NOT NULL,
	[porcentajeDesc] [float] NOT NULL,
	[motivoDesc] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 16/2/2023 14:11:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos](
	[codProducto] [int] IDENTITY(1,1) NOT NULL,
	[nombreProducto] [varchar](50) NOT NULL,
	[codTipProdu] [int] NOT NULL,
	[cantMinima] [int] NOT NULL,
	[cantMaxima] [int] NOT NULL,
	[codUnidad] [int] NOT NULL,
 CONSTRAINT [PK_Productos] PRIMARY KEY CLUSTERED 
(
	[codProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[top5MostSoldProducts]    Script Date: 16/2/2023 14:11:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[top5MostSoldProducts] AS
SELECT TOP 5
P.codProducto, P.nombreProducto, SUM(PXP.cantidadProducto) AS 'Total Vendido' FROM dbo.PedidosXProductos PXP
INNER JOIN dbo.Productos P ON P.codProducto = PXP.codProducto
INNER JOIN dbo.Pedidos Ped ON Ped.numPedido = PXP.numPedido
WHERE (SELECT DATEDIFF(DAY, Ped.fechaPedido, GETDATE())) <= 15 and Ped.idEstadoP = 2
GROUP BY P.codProducto, P.nombreProducto ORDER BY 'Total Vendido' DESC
GO
/****** Object:  View [dbo].[topBuysPerPerson]    Script Date: 16/2/2023 14:11:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[topBuysPerPerson] AS
SELECT U.nomUsu, U.Identificacion_Personal, SUM(F.total) AS 'Total' FROM dbo.Usuarios U
INNER JOIN dbo.Pedidos Ped ON Ped.codUsuario = U.codUsuario
INNER JOIN dbo.Facturas F ON Ped.numPedido = F.numPedido
GROUP BY U.nomUsu, U.Identificacion_Personal ORDER BY 'Total' DESC OFFSET 0 ROWS
--SELECT * FROM topBuysPerPerson
GO
/****** Object:  View [dbo].[totalSoldByProduct]    Script Date: 16/2/2023 14:11:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[totalSoldByProduct] AS
SELECT
P.codProducto, P.nombreProducto, SUM(F.total) AS 'Total' FROM dbo.Facturas F
INNER JOIN dbo.Pedidos Ped ON Ped.numPedido = F.numPedido
INNER JOIN dbo.PedidosXProductos PXP ON Ped.numPedido = PXP.numPedido
INNER JOIN dbo.Productos P ON PXP.codProducto = P.codProducto
GROUP BY P.codProducto, P.nombreProducto ORDER BY 'Total' DESC OFFSET 0 ROWS
GO
/****** Object:  Table [dbo].[BodegaProductos]    Script Date: 16/2/2023 14:11:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BodegaProductos](
	[codBodega] [int] IDENTITY(1,1) NOT NULL,
	[codProducto] [int] NOT NULL,
	[cantidadActual] [int] NOT NULL,
 CONSTRAINT [PK_BodegaProductos] PRIMARY KEY CLUSTERED 
(
	[codBodega] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BodegaXLotes]    Script Date: 16/2/2023 14:11:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BodegaXLotes](
	[codBodega] [int] NOT NULL,
	[codLote] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ciudades]    Script Date: 16/2/2023 14:11:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ciudades](
	[codCiudad] [int] NOT NULL,
	[codProvincia] [int] NOT NULL,
	[nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Ciudades] PRIMARY KEY CLUSTERED 
(
	[codCiudad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EstadosPedido]    Script Date: 16/2/2023 14:11:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EstadosPedido](
	[idEstadoP] [int] NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_EstadosPedido] PRIMARY KEY CLUSTERED 
(
	[idEstadoP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lotes]    Script Date: 16/2/2023 14:11:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lotes](
	[codLote] [int] IDENTITY(1,1) NOT NULL,
	[codProducto] [int] NOT NULL,
	[codProveedor] [int] NOT NULL,
	[precioCompra] [money] NOT NULL,
	[fechaCompra] [date] NOT NULL,
	[cantidad] [int] NOT NULL,
	[fechaProduccion] [date] NOT NULL,
	[fechaVencimiento] [date] NOT NULL,
 CONSTRAINT [PK_Lotes] PRIMARY KEY CLUSTERED 
(
	[codLote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Paises]    Script Date: 16/2/2023 14:11:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Paises](
	[codPais] [int] NOT NULL,
	[nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Paises] PRIMARY KEY CLUSTERED 
(
	[codPais] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Personas]    Script Date: 16/2/2023 14:11:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Personas](
	[Identificacion_Personal] [int] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Apellido1] [varchar](50) NOT NULL,
	[Apellido2] [varchar](50) NOT NULL,
	[FechaNaci] [date] NOT NULL,
	[direccionResidencia] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Personas] PRIMARY KEY CLUSTERED 
(
	[Identificacion_Personal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Proveedores]    Script Date: 16/2/2023 14:11:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proveedores](
	[codProveedor] [int] NOT NULL,
	[nombreProveedor] [varchar](50) NOT NULL,
	[codCiudad] [int] NOT NULL,
	[localizacion] [geography] NULL,
 CONSTRAINT [PK_Proveedores] PRIMARY KEY CLUSTERED 
(
	[codProveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Provincias]    Script Date: 16/2/2023 14:11:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Provincias](
	[codProvincia] [int] NOT NULL,
	[codPais] [int] NOT NULL,
	[nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Provincias] PRIMARY KEY CLUSTERED 
(
	[codProvincia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposProducto]    Script Date: 16/2/2023 14:11:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposProducto](
	[codTipProdu] [int] IDENTITY(1,1) NOT NULL,
	[nombreTipProdu] [varchar](50) NOT NULL,
	[descripcionTipProdu] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TiposProducto] PRIMARY KEY CLUSTERED 
(
	[codTipProdu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Unidades]    Script Date: 16/2/2023 14:11:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Unidades](
	[codUnidad] [int] IDENTITY(1,1) NOT NULL,
	[descipcion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Unidades] PRIMARY KEY CLUSTERED 
(
	[codUnidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Ciudades] ([codCiudad], [codProvincia], [nombre]) VALUES (1, 1, N'San José')
INSERT [dbo].[Ciudades] ([codCiudad], [codProvincia], [nombre]) VALUES (2, 2, N'Alajuela')
INSERT [dbo].[Ciudades] ([codCiudad], [codProvincia], [nombre]) VALUES (3, 3, N'Oriental')
INSERT [dbo].[Ciudades] ([codCiudad], [codProvincia], [nombre]) VALUES (4, 4, N'Santa Bárbara')
INSERT [dbo].[Ciudades] ([codCiudad], [codProvincia], [nombre]) VALUES (5, 5, N'Liberia')
INSERT [dbo].[Ciudades] ([codCiudad], [codProvincia], [nombre]) VALUES (6, 6, N'Quepos')
INSERT [dbo].[Ciudades] ([codCiudad], [codProvincia], [nombre]) VALUES (7, 7, N'Guápiles')
INSERT [dbo].[Ciudades] ([codCiudad], [codProvincia], [nombre]) VALUES (8, 3, N'Cartago')
INSERT [dbo].[Ciudades] ([codCiudad], [codProvincia], [nombre]) VALUES (9, 3, N'Oriental')
INSERT [dbo].[Ciudades] ([codCiudad], [codProvincia], [nombre]) VALUES (10, 3, N'La Lima')
INSERT [dbo].[Ciudades] ([codCiudad], [codProvincia], [nombre]) VALUES (11, 3, N'Aguas Calientes')
GO
INSERT [dbo].[EstadosPedido] ([idEstadoP], [descripcion]) VALUES (1, N'En espera')
INSERT [dbo].[EstadosPedido] ([idEstadoP], [descripcion]) VALUES (2, N'Completado')
INSERT [dbo].[EstadosPedido] ([idEstadoP], [descripcion]) VALUES (3, N'Cancelado')
GO
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (1, CAST(N'2022-12-21T00:00:00.000' AS DateTime), 1001, 100000, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (2, CAST(N'2023-01-27T00:00:00.000' AS DateTime), 1011, 250000, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (3, CAST(N'2022-12-27T00:00:00.000' AS DateTime), 1021, 140000, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (4, CAST(N'2023-02-07T00:00:00.000' AS DateTime), 1031, 7500, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (5, CAST(N'2023-01-14T00:00:00.000' AS DateTime), 1041, 1000, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (6, CAST(N'2023-01-22T00:00:00.000' AS DateTime), 1051, 1500, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (7, CAST(N'2022-12-29T00:00:00.000' AS DateTime), 1061, 2000, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (8, CAST(N'2023-01-09T00:00:00.000' AS DateTime), 1071, 264780, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (9, CAST(N'2023-01-21T00:00:00.000' AS DateTime), 1081, 455000, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (10, CAST(N'2023-01-15T00:00:00.000' AS DateTime), 1200, 10000, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (11, CAST(N'2022-12-27T00:00:00.000' AS DateTime), 1210, 15500, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (12, CAST(N'2022-11-27T00:00:00.000' AS DateTime), 1220, 17850, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (13, CAST(N'2022-12-25T00:00:00.000' AS DateTime), 1230, 16800, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (14, CAST(N'2023-01-12T00:00:00.000' AS DateTime), 1240, 17800, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (15, CAST(N'2023-01-02T00:00:00.000' AS DateTime), 1250, 16900, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (16, CAST(N'2023-01-08T00:00:00.000' AS DateTime), 1051, 458710, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (17, CAST(N'2023-01-09T00:00:00.000' AS DateTime), 1260, 1000, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (18, CAST(N'2022-11-10T00:00:00.000' AS DateTime), 1270, 2000, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (19, CAST(N'2023-01-14T00:00:00.000' AS DateTime), 1280, 2500, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (20, CAST(N'2023-01-14T00:00:00.000' AS DateTime), 1290, 670, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (21, CAST(N'2023-01-12T00:00:00.000' AS DateTime), 1300, 180, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (22, CAST(N'2022-12-28T00:00:00.000' AS DateTime), 1310, 180, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (23, CAST(N'2022-12-12T00:00:00.000' AS DateTime), 1320, 1700, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (24, CAST(N'2022-11-15T00:00:00.000' AS DateTime), 1330, 19900, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (25, CAST(N'2023-01-02T00:00:00.000' AS DateTime), 1340, 12500, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (26, CAST(N'2022-10-10T00:00:00.000' AS DateTime), 1350, 14560, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (27, CAST(N'2022-09-25T00:00:00.000' AS DateTime), 1360, 12000, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (28, CAST(N'2022-11-23T00:00:00.000' AS DateTime), 1370, 13500, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (29, CAST(N'2023-01-09T00:00:00.000' AS DateTime), 1380, 4850, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (30, CAST(N'2023-01-18T00:00:00.000' AS DateTime), 1390, 5840, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (31, CAST(N'2022-09-08T00:00:00.000' AS DateTime), 1400, 125000, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (32, CAST(N'2022-06-04T00:00:00.000' AS DateTime), 1410, 20000, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (33, CAST(N'2023-01-15T00:00:00.000' AS DateTime), 1420, 247800, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (34, CAST(N'2023-01-18T00:00:00.000' AS DateTime), 1430, 45250, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (35, CAST(N'2023-01-11T00:00:00.000' AS DateTime), 1440, 30020, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (36, CAST(N'2022-10-25T00:00:00.000' AS DateTime), 1450, 45000, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (37, CAST(N'2022-10-10T00:00:00.000' AS DateTime), 1460, 12540, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (38, CAST(N'2023-01-26T00:00:00.000' AS DateTime), 1470, 12525, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (39, CAST(N'2023-01-04T00:00:00.000' AS DateTime), 1480, 60000, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (40, CAST(N'2023-01-05T00:00:00.000' AS DateTime), 1490, 4500, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (41, CAST(N'2022-11-02T00:00:00.000' AS DateTime), 1500, 17000, N'"no"')
INSERT [dbo].[Facturas] ([numFactura], [fechaFactura], [numPedido], [total], [detalles]) VALUES (42, CAST(N'2022-11-25T00:00:00.000' AS DateTime), 1510, 1800, N'"no"')
GO
SET IDENTITY_INSERT [dbo].[Lotes] ON 

INSERT [dbo].[Lotes] ([codLote], [codProducto], [codProveedor], [precioCompra], [fechaCompra], [cantidad], [fechaProduccion], [fechaVencimiento]) VALUES (1, 1, 2, 50.0000, CAST(N'2022-05-05' AS Date), 500, CAST(N'2022-05-01' AS Date), CAST(N'2023-12-01' AS Date))
INSERT [dbo].[Lotes] ([codLote], [codProducto], [codProveedor], [precioCompra], [fechaCompra], [cantidad], [fechaProduccion], [fechaVencimiento]) VALUES (2, 1, 2, 50.0000, CAST(N'2022-05-05' AS Date), 500, CAST(N'2022-05-01' AS Date), CAST(N'2023-12-01' AS Date))
INSERT [dbo].[Lotes] ([codLote], [codProducto], [codProveedor], [precioCompra], [fechaCompra], [cantidad], [fechaProduccion], [fechaVencimiento]) VALUES (3, 1, 2, 50.0000, CAST(N'2022-05-05' AS Date), 500, CAST(N'2022-05-01' AS Date), CAST(N'2023-12-01' AS Date))
SET IDENTITY_INSERT [dbo].[Lotes] OFF
GO
INSERT [dbo].[Paises] ([codPais], [nombre]) VALUES (506, N'Costa Rica')
GO
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1001, CAST(N'2022-12-21' AS Date), 2, NULL, 1)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1011, CAST(N'2023-01-27' AS Date), 2, NULL, 1)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1021, CAST(N'2022-12-27' AS Date), 2, NULL, 1)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1031, CAST(N'2023-02-07' AS Date), 2, NULL, 2)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1041, CAST(N'2023-01-14' AS Date), 2, NULL, 2)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1051, CAST(N'2023-01-22' AS Date), 2, NULL, 3)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1061, CAST(N'2022-12-29' AS Date), 2, NULL, 4)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1071, CAST(N'2023-01-09' AS Date), 2, NULL, 5)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1081, CAST(N'2023-01-21' AS Date), 2, NULL, 7)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1200, CAST(N'2023-01-15' AS Date), 2, NULL, 7)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1210, CAST(N'2022-12-27' AS Date), 2, NULL, 7)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1220, CAST(N'2022-11-27' AS Date), 2, NULL, 8)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1230, CAST(N'2022-12-25' AS Date), 2, NULL, 8)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1240, CAST(N'2023-01-12' AS Date), 2, NULL, 9)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1250, CAST(N'2023-01-02' AS Date), 2, NULL, 10)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1260, CAST(N'2023-01-08' AS Date), 2, NULL, 10)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1270, CAST(N'2023-01-09' AS Date), 2, NULL, 12)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1280, CAST(N'2022-11-10' AS Date), 2, NULL, 12)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1290, CAST(N'2023-01-14' AS Date), 2, NULL, 12)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1300, CAST(N'2023-01-12' AS Date), 2, NULL, 13)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1310, CAST(N'2022-12-28' AS Date), 2, NULL, 14)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1320, CAST(N'2022-12-12' AS Date), 2, NULL, 14)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1330, CAST(N'2022-11-15' AS Date), 2, NULL, 15)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1340, CAST(N'2023-01-02' AS Date), 2, NULL, 16)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1350, CAST(N'2022-10-10' AS Date), 2, NULL, 16)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1360, CAST(N'2022-09-25' AS Date), 2, NULL, 18)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1370, CAST(N'2022-11-23' AS Date), 2, NULL, 18)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1380, CAST(N'2023-01-09' AS Date), 2, NULL, 18)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1390, CAST(N'2023-01-18' AS Date), 2, NULL, 19)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1400, CAST(N'2022-09-08' AS Date), 2, NULL, 20)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1410, CAST(N'2022-06-04' AS Date), 2, NULL, 20)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1420, CAST(N'2023-01-15' AS Date), 2, NULL, 20)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1430, CAST(N'2023-01-18' AS Date), 2, NULL, 21)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1440, CAST(N'2023-01-11' AS Date), 2, NULL, 21)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1450, CAST(N'2022-10-25' AS Date), 2, NULL, 21)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1460, CAST(N'2022-10-10' AS Date), 2, NULL, 24)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1470, CAST(N'2023-01-26' AS Date), 2, NULL, 24)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1480, CAST(N'2023-01-04' AS Date), 2, NULL, 24)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1490, CAST(N'2023-01-05' AS Date), 2, NULL, 25)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1500, CAST(N'2022-11-02' AS Date), 2, NULL, 25)
INSERT [dbo].[Pedidos] ([numPedido], [fechaPedido], [idEstadoP], [totales], [codUsuario]) VALUES (1510, CAST(N'2022-11-25' AS Date), 2, NULL, 25)
GO
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1001, 1, 2, 0, N'No')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1001, 2, 2, 0, N'No')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1011, 5, 5, 0, N'No')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1021, 7, 4, 0, N'No')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1031, 7, 2, 0, N'No')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1041, 10, 5, 0, N'No')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1051, 12, 3, 0, N'No')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1061, 11, 2, 0, N'No')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1071, 20, 10, 0, N'No')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1001, 1, 10, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1001, 2, 5, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1001, 5, 1, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1011, 13, 2, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1011, 7, 8, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1011, 9, 1, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1021, 18, 5, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1021, 6, 11, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1021, 10, 6, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1031, 1, 2, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1031, 16, 3, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1031, 17, 5, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1041, 2, 10, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1041, 6, 2, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1041, 9, 15, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1051, 1, 1, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1051, 5, 2, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1051, 7, 3, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1051, 8, 4, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1051, 10, 1, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1061, 2, 8, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1061, 18, 6, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1061, 6, 4, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1061, 8, 3, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1061, 10, 5, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1071, 1, 4, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1071, 19, 5, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1071, 5, 2, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1071, 7, 3, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1071, 9, 1, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1081, 1, 6, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1081, 2, 3, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1081, 17, 2, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1081, 19, 7, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1081, 5, 4, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1081, 6, 5, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1200, 2, 3, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1200, 17, 4, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1200, 6, 5, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1200, 8, 1, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1200, 10, 2, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1210, 1, 2, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1210, 17, 3, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1210, 5, 1, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1210, 7, 6, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1210, 9, 2, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1220, 18, 4, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1220, 6, 5, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1220, 8, 2, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1230, 1, 6, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1510, 20, 3, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1510, 22, 1, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1510, 25, 2, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1230, 1, 10, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1240, 2, 5, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1240, 5, 1, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1250, 13, 2, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1250, 7, 8, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1250, 9, 1, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1260, 18, 5, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1270, 6, 11, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1270, 10, 6, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1280, 1, 2, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1290, 16, 3, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1280, 17, 5, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1290, 2, 10, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1300, 6, 2, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1300, 9, 15, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1300, 1, 1, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1310, 5, 2, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1310, 7, 3, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1320, 8, 4, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1320, 10, 1, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1340, 2, 8, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1350, 18, 6, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1350, 6, 4, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1360, 8, 3, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1370, 10, 5, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1370, 1, 4, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1370, 19, 5, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1380, 5, 2, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1390, 7, 3, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1390, 9, 1, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1400, 1, 6, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1400, 2, 3, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1410, 17, 2, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1420, 19, 7, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1430, 5, 4, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1440, 6, 5, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1450, 2, 3, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1450, 17, 4, 0, N'no')
GO
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1450, 6, 5, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1450, 8, 1, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1460, 10, 2, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1470, 1, 2, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1470, 17, 3, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1480, 5, 1, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1490, 7, 6, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1490, 9, 2, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1500, 18, 4, 0, N'no')
INSERT [dbo].[PedidosXProductos] ([numPedido], [codProducto], [cantidadProducto], [porcentajeDesc], [motivoDesc]) VALUES (1500, 6, 5, 0, N'no')
GO
INSERT [dbo].[Personas] ([Identificacion_Personal], [Nombre], [Apellido1], [Apellido2], [FechaNaci], [direccionResidencia]) VALUES (118440792, N'Jose Pablo', N'Hidalgo', N'Navarro', CAST(N'2002-06-05' AS Date), N'Al costado parque la Brasa')
INSERT [dbo].[Personas] ([Identificacion_Personal], [Nombre], [Apellido1], [Apellido2], [FechaNaci], [direccionResidencia]) VALUES (118465973, N'María del Mar', N'Monsalve', N'Achoy', CAST(N'1998-12-31' AS Date), N'300mts este del Walmart, Cartago Oriental')
INSERT [dbo].[Personas] ([Identificacion_Personal], [Nombre], [Apellido1], [Apellido2], [FechaNaci], [direccionResidencia]) VALUES (118730548, N'Girlany', N'Villanueva', N'Fonseca', CAST(N'2004-05-14' AS Date), N'Turrialba, Cartago')
INSERT [dbo].[Personas] ([Identificacion_Personal], [Nombre], [Apellido1], [Apellido2], [FechaNaci], [direccionResidencia]) VALUES (118920438, N'Axel', N'Chaves', N'Reyes', CAST(N'2003-12-12' AS Date), N'La Puebla, Cartago')
INSERT [dbo].[Personas] ([Identificacion_Personal], [Nombre], [Apellido1], [Apellido2], [FechaNaci], [direccionResidencia]) VALUES (123456789, N'Alejandro ', N'Garcia ', N'Hernandez', CAST(N'1990-01-01' AS Date), N'Residencias ITCR, Cartago')
INSERT [dbo].[Personas] ([Identificacion_Personal], [Nombre], [Apellido1], [Apellido2], [FechaNaci], [direccionResidencia]) VALUES (147258369, N'Carlos ', N'Martinez ', N'Garcia', CAST(N'1975-09-30' AS Date), N'Frente a las Ruinas, Cartago')
INSERT [dbo].[Personas] ([Identificacion_Personal], [Nombre], [Apellido1], [Apellido2], [FechaNaci], [direccionResidencia]) VALUES (321654987, N'Carmen ', N'Ortiz ', N'Hernandez', CAST(N'1992-06-17' AS Date), N'El Guarco, Cartago')
INSERT [dbo].[Personas] ([Identificacion_Personal], [Nombre], [Apellido1], [Apellido2], [FechaNaci], [direccionResidencia]) VALUES (369258147, N'Sofia ', N'Avila', N'Ramos', CAST(N'1991-08-21' AS Date), N'El Quijongo, Cartago')
INSERT [dbo].[Personas] ([Identificacion_Personal], [Nombre], [Apellido1], [Apellido2], [FechaNaci], [direccionResidencia]) VALUES (456789123, N'Jose Paolo', N'Rodriguez ', N'Chavez', CAST(N'1978-03-23' AS Date), N'Curridabat, San José')
INSERT [dbo].[Personas] ([Identificacion_Personal], [Nombre], [Apellido1], [Apellido2], [FechaNaci], [direccionResidencia]) VALUES (503000405, N'Alexander', N'Chaves', N'Ruiz', CAST(N'1976-11-04' AS Date), N'Cariari, Guápiles')
INSERT [dbo].[Personas] ([Identificacion_Personal], [Nombre], [Apellido1], [Apellido2], [FechaNaci], [direccionResidencia]) VALUES (504440146, N'Kevin', N'Cruz ', N'Núñez', CAST(N'2002-06-16' AS Date), N'Residencias TEC, Cartago')
INSERT [dbo].[Personas] ([Identificacion_Personal], [Nombre], [Apellido1], [Apellido2], [FechaNaci], [direccionResidencia]) VALUES (504500973, N'Vivian', N'Jarquín ', N'Fonseca', CAST(N'2003-09-10' AS Date), N'Grecia, residencias UCR')
INSERT [dbo].[Personas] ([Identificacion_Personal], [Nombre], [Apellido1], [Apellido2], [FechaNaci], [direccionResidencia]) VALUES (513497652, N'Wendy', N'Quesada', N'Vargas', CAST(N'1997-09-25' AS Date), N'Apartamentos el Chino, al sur del ITCR')
INSERT [dbo].[Personas] ([Identificacion_Personal], [Nombre], [Apellido1], [Apellido2], [FechaNaci], [direccionResidencia]) VALUES (604720006, N'Dilany', N'López', N'Rojas', CAST(N'2002-03-05' AS Date), N'300m Sur Walmart Cartago')
INSERT [dbo].[Personas] ([Identificacion_Personal], [Nombre], [Apellido1], [Apellido2], [FechaNaci], [direccionResidencia]) VALUES (654123789, N'Luis Gonzalo', N'Hernandez ', N'Rivera', CAST(N'1983-05-05' AS Date), N'Desamparados, San José')
INSERT [dbo].[Personas] ([Identificacion_Personal], [Nombre], [Apellido1], [Apellido2], [FechaNaci], [direccionResidencia]) VALUES (703000278, N'María ', N'González', N'Mora', CAST(N'2003-05-28' AS Date), N'Apartamentos Chino, La Puebla')
INSERT [dbo].[Personas] ([Identificacion_Personal], [Nombre], [Apellido1], [Apellido2], [FechaNaci], [direccionResidencia]) VALUES (703000417, N'Helberth', N'Cubillo', N'Jarquín', CAST(N'2003-03-06' AS Date), N'La Puebla, Cartago')
INSERT [dbo].[Personas] ([Identificacion_Personal], [Nombre], [Apellido1], [Apellido2], [FechaNaci], [direccionResidencia]) VALUES (784571352, N'Joctan', N'Campos', N'Chaves', CAST(N'2000-10-28' AS Date), N'Frente a Cantarana, Cartago')
INSERT [dbo].[Personas] ([Identificacion_Personal], [Nombre], [Apellido1], [Apellido2], [FechaNaci], [direccionResidencia]) VALUES (789456123, N'Ana ', N'Torres ', N'Gomez', CAST(N'1995-04-10' AS Date), N'Zapote, San José')
INSERT [dbo].[Personas] ([Identificacion_Personal], [Nombre], [Apellido1], [Apellido2], [FechaNaci], [direccionResidencia]) VALUES (800940902, N'Nora', N'Reyes', N'Vidal ', CAST(N'1978-04-15' AS Date), N'La Sole, Cariari, Guápiles')
INSERT [dbo].[Personas] ([Identificacion_Personal], [Nombre], [Apellido1], [Apellido2], [FechaNaci], [direccionResidencia]) VALUES (852963741, N'Rafael ', N'Diaz ', N'Rodriguez', CAST(N'1980-07-07' AS Date), N'La Lima, Cartago')
INSERT [dbo].[Personas] ([Identificacion_Personal], [Nombre], [Apellido1], [Apellido2], [FechaNaci], [direccionResidencia]) VALUES (887654321, N'Maria Fernanda', N'Gonzalez ', N'Ramirez', CAST(N'1985-02-14' AS Date), N'Residencias ITCR, Cartago')
GO
SET IDENTITY_INSERT [dbo].[Productos] ON 

INSERT [dbo].[Productos] ([codProducto], [nombreProducto], [codTipProdu], [cantMinima], [cantMaxima], [codUnidad]) VALUES (1, N'Manzana', 2, 10, 35, 10)
INSERT [dbo].[Productos] ([codProducto], [nombreProducto], [codTipProdu], [cantMinima], [cantMaxima], [codUnidad]) VALUES (2, N'Banano', 2, 10, 50, 10)
INSERT [dbo].[Productos] ([codProducto], [nombreProducto], [codTipProdu], [cantMinima], [cantMaxima], [codUnidad]) VALUES (5, N'Sandía', 2, 10, 25, 10)
INSERT [dbo].[Productos] ([codProducto], [nombreProducto], [codTipProdu], [cantMinima], [cantMaxima], [codUnidad]) VALUES (6, N'Lechuga', 3, 5, 12, 10)
INSERT [dbo].[Productos] ([codProducto], [nombreProducto], [codTipProdu], [cantMinima], [cantMaxima], [codUnidad]) VALUES (7, N'Brócoli', 3, 5, 20, 10)
INSERT [dbo].[Productos] ([codProducto], [nombreProducto], [codTipProdu], [cantMinima], [cantMaxima], [codUnidad]) VALUES (8, N'Kiwi', 2, 5, 30, 10)
INSERT [dbo].[Productos] ([codProducto], [nombreProducto], [codTipProdu], [cantMinima], [cantMaxima], [codUnidad]) VALUES (9, N'Papa', 4, 20, 55, 10)
INSERT [dbo].[Productos] ([codProducto], [nombreProducto], [codTipProdu], [cantMinima], [cantMaxima], [codUnidad]) VALUES (10, N'Zanahoria', 4, 3, 40, 10)
INSERT [dbo].[Productos] ([codProducto], [nombreProducto], [codTipProdu], [cantMinima], [cantMaxima], [codUnidad]) VALUES (11, N'Camote', 4, 2, 40, 10)
INSERT [dbo].[Productos] ([codProducto], [nombreProducto], [codTipProdu], [cantMinima], [cantMaxima], [codUnidad]) VALUES (12, N'Leche entera', 1, 30, 75, 6)
INSERT [dbo].[Productos] ([codProducto], [nombreProducto], [codTipProdu], [cantMinima], [cantMaxima], [codUnidad]) VALUES (13, N'Queso semiduro', 1, 8, 20, 2)
INSERT [dbo].[Productos] ([codProducto], [nombreProducto], [codTipProdu], [cantMinima], [cantMaxima], [codUnidad]) VALUES (16, N'Queso amarillo', 1, 10, 50, 10)
INSERT [dbo].[Productos] ([codProducto], [nombreProducto], [codTipProdu], [cantMinima], [cantMaxima], [codUnidad]) VALUES (17, N'Leche condensada', 1, 5, 20, 10)
INSERT [dbo].[Productos] ([codProducto], [nombreProducto], [codTipProdu], [cantMinima], [cantMaxima], [codUnidad]) VALUES (18, N'Leche semidescremada', 1, 10, 100, 10)
INSERT [dbo].[Productos] ([codProducto], [nombreProducto], [codTipProdu], [cantMinima], [cantMaxima], [codUnidad]) VALUES (19, N'Yogurt Griego', 1, 10, 30, 6)
INSERT [dbo].[Productos] ([codProducto], [nombreProducto], [codTipProdu], [cantMinima], [cantMaxima], [codUnidad]) VALUES (20, N'Tomate', 2, 3, 25, 10)
INSERT [dbo].[Productos] ([codProducto], [nombreProducto], [codTipProdu], [cantMinima], [cantMaxima], [codUnidad]) VALUES (21, N'Atun con Vegetales', 5, 10, 30, 8)
INSERT [dbo].[Productos] ([codProducto], [nombreProducto], [codTipProdu], [cantMinima], [cantMaxima], [codUnidad]) VALUES (22, N'Atun en agua', 5, 10, 40, 8)
INSERT [dbo].[Productos] ([codProducto], [nombreProducto], [codTipProdu], [cantMinima], [cantMaxima], [codUnidad]) VALUES (24, N'Maiz en granos', 6, 10, 30, 8)
INSERT [dbo].[Productos] ([codProducto], [nombreProducto], [codTipProdu], [cantMinima], [cantMaxima], [codUnidad]) VALUES (25, N'Hongos', 6, 10, 25, 8)
SET IDENTITY_INSERT [dbo].[Productos] OFF
GO
INSERT [dbo].[Proveedores] ([codProveedor], [nombreProveedor], [codCiudad], [localizacion]) VALUES (1, N'Tres Pinos', 3, NULL)
INSERT [dbo].[Proveedores] ([codProveedor], [nombreProveedor], [codCiudad], [localizacion]) VALUES (2, N'Verdureria Don Luis', 3, NULL)
INSERT [dbo].[Proveedores] ([codProveedor], [nombreProveedor], [codCiudad], [localizacion]) VALUES (3, N'Supermercado MB', 3, NULL)
INSERT [dbo].[Proveedores] ([codProveedor], [nombreProveedor], [codCiudad], [localizacion]) VALUES (4, N'MiniSuper El Chino', 3, NULL)
INSERT [dbo].[Proveedores] ([codProveedor], [nombreProveedor], [codCiudad], [localizacion]) VALUES (5, N'Verdulería Cartagena', 3, NULL)
INSERT [dbo].[Proveedores] ([codProveedor], [nombreProveedor], [codCiudad], [localizacion]) VALUES (6, N'Lechería Prusiana', 3, NULL)
GO
INSERT [dbo].[Provincias] ([codProvincia], [codPais], [nombre]) VALUES (1, 506, N'San José')
INSERT [dbo].[Provincias] ([codProvincia], [codPais], [nombre]) VALUES (2, 506, N'Alajuela')
INSERT [dbo].[Provincias] ([codProvincia], [codPais], [nombre]) VALUES (3, 506, N'Cartago')
INSERT [dbo].[Provincias] ([codProvincia], [codPais], [nombre]) VALUES (4, 506, N'Heredia')
INSERT [dbo].[Provincias] ([codProvincia], [codPais], [nombre]) VALUES (5, 506, N'Guanacaste')
INSERT [dbo].[Provincias] ([codProvincia], [codPais], [nombre]) VALUES (6, 506, N'Puntarenas')
INSERT [dbo].[Provincias] ([codProvincia], [codPais], [nombre]) VALUES (7, 506, N'Limón')
GO
SET IDENTITY_INSERT [dbo].[TiposProducto] ON 

INSERT [dbo].[TiposProducto] ([codTipProdu], [nombreTipProdu], [descripcionTipProdu]) VALUES (1, N'Lácteo', N'Productos derivados de la leche')
INSERT [dbo].[TiposProducto] ([codTipProdu], [nombreTipProdu], [descripcionTipProdu]) VALUES (2, N'Frutas', N'Fruta')
INSERT [dbo].[TiposProducto] ([codTipProdu], [nombreTipProdu], [descripcionTipProdu]) VALUES (3, N'Verdura', N'Verdura')
INSERT [dbo].[TiposProducto] ([codTipProdu], [nombreTipProdu], [descripcionTipProdu]) VALUES (4, N'Tuberculo', N'Tuberculos')
INSERT [dbo].[TiposProducto] ([codTipProdu], [nombreTipProdu], [descripcionTipProdu]) VALUES (5, N'Atun', N'Atunes')
INSERT [dbo].[TiposProducto] ([codTipProdu], [nombreTipProdu], [descripcionTipProdu]) VALUES (6, N'Enlatado', N'Enlatados')
SET IDENTITY_INSERT [dbo].[TiposProducto] OFF
GO
SET IDENTITY_INSERT [dbo].[Unidades] ON 

INSERT [dbo].[Unidades] ([codUnidad], [descipcion]) VALUES (1, N'Gramos')
INSERT [dbo].[Unidades] ([codUnidad], [descipcion]) VALUES (2, N'Kilogramos')
INSERT [dbo].[Unidades] ([codUnidad], [descipcion]) VALUES (5, N'Militros')
INSERT [dbo].[Unidades] ([codUnidad], [descipcion]) VALUES (6, N'Litros')
INSERT [dbo].[Unidades] ([codUnidad], [descipcion]) VALUES (7, N'Galones')
INSERT [dbo].[Unidades] ([codUnidad], [descipcion]) VALUES (8, N'Latas')
INSERT [dbo].[Unidades] ([codUnidad], [descipcion]) VALUES (9, N'Quintal')
INSERT [dbo].[Unidades] ([codUnidad], [descipcion]) VALUES (10, N'Unidad Individual')
SET IDENTITY_INSERT [dbo].[Unidades] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([codUsuario], [nomUsu], [contraseña], [Identificacion_Personal]) VALUES (1, N'jpablohidalgona', N'118440792JPHN@', 118440792)
INSERT [dbo].[Usuarios] ([codUsuario], [nomUsu], [contraseña], [Identificacion_Personal]) VALUES (2, N'mariadelmarmma', N'118465973MMA@', 118465973)
INSERT [dbo].[Usuarios] ([codUsuario], [nomUsu], [contraseña], [Identificacion_Personal]) VALUES (3, N'gvillanuevafonseca', N'118730548GVF@', 118730548)
INSERT [dbo].[Usuarios] ([codUsuario], [nomUsu], [contraseña], [Identificacion_Personal]) VALUES (4, N'axelchavesreyes', N'118920438ACR@', 118920438)
INSERT [dbo].[Usuarios] ([codUsuario], [nomUsu], [contraseña], [Identificacion_Personal]) VALUES (5, N'alejandrogarciah', N'123456789AGH@', 123456789)
INSERT [dbo].[Usuarios] ([codUsuario], [nomUsu], [contraseña], [Identificacion_Personal]) VALUES (7, N'carlosmartinezg', N'147258369CMG@', 147258369)
INSERT [dbo].[Usuarios] ([codUsuario], [nomUsu], [contraseña], [Identificacion_Personal]) VALUES (8, N'carmenortizh', N'321654987COH@', 321654987)
INSERT [dbo].[Usuarios] ([codUsuario], [nomUsu], [contraseña], [Identificacion_Personal]) VALUES (9, N'sofiasofiar', N'369258147SSR@', 369258147)
INSERT [dbo].[Usuarios] ([codUsuario], [nomUsu], [contraseña], [Identificacion_Personal]) VALUES (10, N'jpolorodriguezch', N'456789123JPRC@', 456789123)
INSERT [dbo].[Usuarios] ([codUsuario], [nomUsu], [contraseña], [Identificacion_Personal]) VALUES (12, N'kevincruznunez', N'504440146KCN@', 504440146)
INSERT [dbo].[Usuarios] ([codUsuario], [nomUsu], [contraseña], [Identificacion_Personal]) VALUES (13, N'vivianjarquinfonseca', N'504500973VJF@', 504500973)
INSERT [dbo].[Usuarios] ([codUsuario], [nomUsu], [contraseña], [Identificacion_Personal]) VALUES (14, N'wendyquesadav', N'513497652WQV@', 513497652)
INSERT [dbo].[Usuarios] ([codUsuario], [nomUsu], [contraseña], [Identificacion_Personal]) VALUES (15, N'dilanylopezr', N'604720006DLR@', 604720006)
INSERT [dbo].[Usuarios] ([codUsuario], [nomUsu], [contraseña], [Identificacion_Personal]) VALUES (16, N'luisgonzalohernandezr', N'654123789LHR@', 654123789)
INSERT [dbo].[Usuarios] ([codUsuario], [nomUsu], [contraseña], [Identificacion_Personal]) VALUES (18, N'mariagonzalezmora', N'703000278MGM@', 703000278)
INSERT [dbo].[Usuarios] ([codUsuario], [nomUsu], [contraseña], [Identificacion_Personal]) VALUES (19, N'helberthcubillojarquin', N'703000417HCJ@', 703000417)
INSERT [dbo].[Usuarios] ([codUsuario], [nomUsu], [contraseña], [Identificacion_Personal]) VALUES (20, N'joctancamposchaves', N'784571352JCC@', 784571352)
INSERT [dbo].[Usuarios] ([codUsuario], [nomUsu], [contraseña], [Identificacion_Personal]) VALUES (21, N'anatorresgomez', N'789456123ATG@', 789456123)
INSERT [dbo].[Usuarios] ([codUsuario], [nomUsu], [contraseña], [Identificacion_Personal]) VALUES (24, N'norareyesvidal', N'800940902NRV@', 800940902)
INSERT [dbo].[Usuarios] ([codUsuario], [nomUsu], [contraseña], [Identificacion_Personal]) VALUES (25, N'alexanderchavesr', N'503000405ACR@', 503000405)
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
GO
ALTER TABLE [dbo].[BodegaProductos]  WITH CHECK ADD  CONSTRAINT [FK_BodegaProductos_Productos1] FOREIGN KEY([codProducto])
REFERENCES [dbo].[Productos] ([codProducto])
GO
ALTER TABLE [dbo].[BodegaProductos] CHECK CONSTRAINT [FK_BodegaProductos_Productos1]
GO
ALTER TABLE [dbo].[BodegaXLotes]  WITH CHECK ADD  CONSTRAINT [FK_BodegaXLotes_BodegaProductos] FOREIGN KEY([codBodega])
REFERENCES [dbo].[BodegaProductos] ([codBodega])
GO
ALTER TABLE [dbo].[BodegaXLotes] CHECK CONSTRAINT [FK_BodegaXLotes_BodegaProductos]
GO
ALTER TABLE [dbo].[BodegaXLotes]  WITH CHECK ADD  CONSTRAINT [FK_BodegaXLotes_Lotes] FOREIGN KEY([codLote])
REFERENCES [dbo].[Lotes] ([codLote])
GO
ALTER TABLE [dbo].[BodegaXLotes] CHECK CONSTRAINT [FK_BodegaXLotes_Lotes]
GO
ALTER TABLE [dbo].[Ciudades]  WITH CHECK ADD  CONSTRAINT [FK_Ciudades_Provincias] FOREIGN KEY([codProvincia])
REFERENCES [dbo].[Provincias] ([codProvincia])
GO
ALTER TABLE [dbo].[Ciudades] CHECK CONSTRAINT [FK_Ciudades_Provincias]
GO
ALTER TABLE [dbo].[Facturas]  WITH CHECK ADD  CONSTRAINT [FK_Facturas_Pedidos] FOREIGN KEY([numPedido])
REFERENCES [dbo].[Pedidos] ([numPedido])
GO
ALTER TABLE [dbo].[Facturas] CHECK CONSTRAINT [FK_Facturas_Pedidos]
GO
ALTER TABLE [dbo].[Lotes]  WITH CHECK ADD  CONSTRAINT [FK_Lotes_Productos] FOREIGN KEY([codProducto])
REFERENCES [dbo].[Productos] ([codProducto])
GO
ALTER TABLE [dbo].[Lotes] CHECK CONSTRAINT [FK_Lotes_Productos]
GO
ALTER TABLE [dbo].[Lotes]  WITH CHECK ADD  CONSTRAINT [FK_Lotes_Proveedores] FOREIGN KEY([codProveedor])
REFERENCES [dbo].[Proveedores] ([codProveedor])
GO
ALTER TABLE [dbo].[Lotes] CHECK CONSTRAINT [FK_Lotes_Proveedores]
GO
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD  CONSTRAINT [FK_Pedidos_EstadosPedido] FOREIGN KEY([idEstadoP])
REFERENCES [dbo].[EstadosPedido] ([idEstadoP])
GO
ALTER TABLE [dbo].[Pedidos] CHECK CONSTRAINT [FK_Pedidos_EstadosPedido]
GO
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD  CONSTRAINT [FK_Pedidos_Usuarios] FOREIGN KEY([codUsuario])
REFERENCES [dbo].[Usuarios] ([codUsuario])
GO
ALTER TABLE [dbo].[Pedidos] CHECK CONSTRAINT [FK_Pedidos_Usuarios]
GO
ALTER TABLE [dbo].[PedidosXProductos]  WITH CHECK ADD  CONSTRAINT [FK_PedidosXProductos_Pedidos] FOREIGN KEY([numPedido])
REFERENCES [dbo].[Pedidos] ([numPedido])
GO
ALTER TABLE [dbo].[PedidosXProductos] CHECK CONSTRAINT [FK_PedidosXProductos_Pedidos]
GO
ALTER TABLE [dbo].[PedidosXProductos]  WITH CHECK ADD  CONSTRAINT [FK_PedidosXProductos_Productos1] FOREIGN KEY([codProducto])
REFERENCES [dbo].[Productos] ([codProducto])
GO
ALTER TABLE [dbo].[PedidosXProductos] CHECK CONSTRAINT [FK_PedidosXProductos_Productos1]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [FK_Productos_TiposProducto1] FOREIGN KEY([codTipProdu])
REFERENCES [dbo].[TiposProducto] ([codTipProdu])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [FK_Productos_TiposProducto1]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [FK_Productos_Unidades] FOREIGN KEY([codUnidad])
REFERENCES [dbo].[Unidades] ([codUnidad])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [FK_Productos_Unidades]
GO
ALTER TABLE [dbo].[Proveedores]  WITH CHECK ADD  CONSTRAINT [FK_Proveedores_Ciudades] FOREIGN KEY([codCiudad])
REFERENCES [dbo].[Ciudades] ([codCiudad])
GO
ALTER TABLE [dbo].[Proveedores] CHECK CONSTRAINT [FK_Proveedores_Ciudades]
GO
ALTER TABLE [dbo].[Provincias]  WITH CHECK ADD  CONSTRAINT [FK_Provincias_Paises] FOREIGN KEY([codPais])
REFERENCES [dbo].[Paises] ([codPais])
GO
ALTER TABLE [dbo].[Provincias] CHECK CONSTRAINT [FK_Provincias_Paises]
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [FK_Usuarios_Personas] FOREIGN KEY([Identificacion_Personal])
REFERENCES [dbo].[Personas] ([Identificacion_Personal])
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [FK_Usuarios_Personas]
GO
/****** Object:  StoredProcedure [dbo].[consultas]    Script Date: 16/2/2023 14:11:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[consultas]
AS 
BEGIN 
SELECT TOP 5
U.nomUsu, U.Identificacion_Personal, SUM(F.total) AS 'Total' FROM dbo.Usuarios U
INNER JOIN dbo.Pedidos P ON P.codUsuario = U.codUsuario
INNER JOIN dbo.Facturas F ON P.numPedido = F.numPedido
GROUP BY U.nomUsu, U.Identificacion_Personal ORDER BY 'Total' DESC

SELECT TOP 5
P.codProducto, P.nombreProducto, SUM(PXP.cantidadProducto) AS 'Total Vendido' FROM dbo.PedidosXProductos PXP
INNER JOIN dbo.Productos P ON P.codProducto = PXP.codProducto
INNER JOIN dbo.Pedidos Ped ON Ped.numPedido = PXP.numPedido
WHERE (SELECT DATEDIFF(DAY, Ped.fechaPedido, GETDATE())) <= 15 and Ped.idEstadoP = 2
GROUP BY P.codProducto, P.nombreProducto ORDER BY 'Total Vendido' DESC

SELECT U.nomUsu, U.Identificacion_Personal, SUM(F.total) AS 'Total' FROM dbo.Usuarios U
INNER JOIN dbo.Pedidos Ped ON Ped.codUsuario = U.codUsuario
INNER JOIN dbo.Facturas F ON Ped.numPedido = F.numPedido
GROUP BY U.nomUsu, U.Identificacion_Personal ORDER BY 'Total' DESC

SELECT
P.codProducto, P.nombreProducto, SUM(F.total) AS 'Total' FROM dbo.Facturas F
INNER JOIN dbo.Pedidos Ped ON Ped.numPedido = F.numPedido
INNER JOIN dbo.PedidosXProductos PXP ON Ped.numPedido = PXP.numPedido
INNER JOIN dbo.Productos P ON PXP.codProducto = P.codProducto
GROUP BY P.codProducto, P.nombreProducto ORDER BY 'Total' DESC

END
GO
USE [master]
GO
ALTER DATABASE [Caso01_Ferianueva] SET  READ_WRITE 
GO
