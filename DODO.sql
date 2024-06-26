USE [master]
GO
/****** Object:  Database [dodo1]    Script Date: 20.05.2024 15:19:31 ******/
CREATE DATABASE [dodo1]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dodo1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\dodo1.mdf' , SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'dodo1_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\dodo1_log.ldf' , SIZE = 1072KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [dodo1] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dodo1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dodo1] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [dodo1] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [dodo1] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [dodo1] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [dodo1] SET ARITHABORT OFF 
GO
ALTER DATABASE [dodo1] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [dodo1] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dodo1] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dodo1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dodo1] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [dodo1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [dodo1] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dodo1] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [dodo1] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dodo1] SET  ENABLE_BROKER 
GO
ALTER DATABASE [dodo1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dodo1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dodo1] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dodo1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [dodo1] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dodo1] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [dodo1] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dodo1] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [dodo1] SET  MULTI_USER 
GO
ALTER DATABASE [dodo1] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [dodo1] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dodo1] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [dodo1] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [dodo1] SET DELAYED_DURABILITY = DISABLED 
GO
USE [dodo1]
GO
/****** Object:  Table [dbo].[klient]    Script Date: 20.05.2024 15:19:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[klient](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[i] [nvarchar](35) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pitsa]    Script Date: 20.05.2024 15:19:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pitsa](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[_name] [nvarchar](70) NULL,
	[opisanie] [nvarchar](300) NULL,
	[razmer] [int] NULL,
	[price] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rabotnik]    Script Date: 20.05.2024 15:19:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rabotnik](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[f] [nvarchar](35) NULL,
	[i] [nvarchar](35) NULL,
	[o] [nvarchar](35) NULL,
	[dolgnost] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[zakaz]    Script Date: 20.05.2024 15:19:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zakaz](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_klienta] [int] NULL,
	[id_rabotnika] [int] NULL,
	[id_pitsa] [int] NULL,
	[kolvo] [int] NULL,
	[_time] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[all_zakaz]    Script Date: 20.05.2024 15:19:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[all_zakaz] as

SELECT
	klient.i as 'Имя клиента',
	CONCAT(rabotnik.f, ' ', rabotnik.i, ' ', rabotnik.o) as 'ФИО работника',
	pitsa._name as 'Название пиццы',
	kolvo as 'Количество',
	CONCAT(pitsa.price * kolvo, ' ', N'руб') as 'Итоговая сумма',
	_time as 'Время заказа'
	
FROM zakaz
inner join klient on klient.id = zakaz.id_klienta
inner join rabotnik on rabotnik.id = zakaz.id_rabotnika
inner join pitsa on pitsa.id = zakaz.id_pitsa
GO
SET IDENTITY_INSERT [dbo].[klient] ON 

INSERT [dbo].[klient] ([id], [i]) VALUES (1, N'Кирилл')
INSERT [dbo].[klient] ([id], [i]) VALUES (2, N'Александр')
INSERT [dbo].[klient] ([id], [i]) VALUES (3, N'Захар')
INSERT [dbo].[klient] ([id], [i]) VALUES (4, N'Вера')
INSERT [dbo].[klient] ([id], [i]) VALUES (5, N'Тимофей')
INSERT [dbo].[klient] ([id], [i]) VALUES (6, N'Демьян')
INSERT [dbo].[klient] ([id], [i]) VALUES (7, N'Артём')
INSERT [dbo].[klient] ([id], [i]) VALUES (8, N'Елисей')
INSERT [dbo].[klient] ([id], [i]) VALUES (9, N'Кирилл')
INSERT [dbo].[klient] ([id], [i]) VALUES (10, N'Егор')
SET IDENTITY_INSERT [dbo].[klient] OFF
GO
SET IDENTITY_INSERT [dbo].[pitsa] ON 

INSERT [dbo].[pitsa] ([id], [_name], [opisanie], [razmer], [price]) VALUES (1, N'Креветки со сладким чили', N'Креветки, ананасы, соус сладкий чили, сладкий перец, моцарелла, фирменный соус альфредо', 25, 589)
INSERT [dbo].[pitsa] ([id], [_name], [opisanie], [razmer], [price]) VALUES (2, N'Пицца из половинок', N'Соберите свою пиццу 35 см с двумя разными вкусами', 35, 680)
INSERT [dbo].[pitsa] ([id], [_name], [opisanie], [razmer], [price]) VALUES (3, N'Сырная', N'Моцарелла, сыры чеддер и пармезан, фирменный соус альфредо', 30, 539)
INSERT [dbo].[pitsa] ([id], [_name], [opisanie], [razmer], [price]) VALUES (4, N'Двойной цыпленок', N'Цыпленок, моцарелла, фирменный соус альфредо', 30, 619)
INSERT [dbo].[pitsa] ([id], [_name], [opisanie], [razmer], [price]) VALUES (5, N'Чоризо фреш', N'Острые колбаски чоризо, сладкий перец, моцарелла, фирменный томатный соус', 30, 539)
INSERT [dbo].[pitsa] ([id], [_name], [opisanie], [razmer], [price]) VALUES (6, N'Ветчина и сыр', N'Ветчина, моцарелла, фирменный соус альфредо', 30, 619)
INSERT [dbo].[pitsa] ([id], [_name], [opisanie], [razmer], [price]) VALUES (7, N'Песто', N'Цыпленок, соус песто, кубики брынзы, томаты, моцарелла, фирменный соус альфредо', 30, 799)
INSERT [dbo].[pitsa] ([id], [_name], [opisanie], [razmer], [price]) VALUES (8, N'Аррива!', N'Цыпленок, острые колбаски чоризо, соус бургер, сладкий перец, красный лук, томаты, моцарелла, соус ранч, чеснок', 30, 799)
INSERT [dbo].[pitsa] ([id], [_name], [opisanie], [razmer], [price]) VALUES (9, N'Мясная', N'Цыпленок, ветчина, пикантная пепперони, острые колбаски чоризо, моцарелла, фирменный томатный соус', 30, 799)
INSERT [dbo].[pitsa] ([id], [_name], [opisanie], [razmer], [price]) VALUES (10, N'Четыре сезона', N'Увеличенная порция моцареллы, ветчина, пикантная пепперони, кубики брынзы, томаты, шампиньоны, итальянские травы, фирменный томатный соус', 30, 729)
SET IDENTITY_INSERT [dbo].[pitsa] OFF
GO
SET IDENTITY_INSERT [dbo].[rabotnik] ON 

INSERT [dbo].[rabotnik] ([id], [f], [i], [o], [dolgnost]) VALUES (1, N'Левин', N'Савва', N'Павлович', N'Повар')
INSERT [dbo].[rabotnik] ([id], [f], [i], [o], [dolgnost]) VALUES (2, N'Тарасов', N'Василий', N'Петрович', N'Повар')
INSERT [dbo].[rabotnik] ([id], [f], [i], [o], [dolgnost]) VALUES (3, N'Левина', N'Вероника', N'Павловна', N'Повар')
INSERT [dbo].[rabotnik] ([id], [f], [i], [o], [dolgnost]) VALUES (4, N'Власова', N'Татьяна', N'Михайловна', N'Повар')
INSERT [dbo].[rabotnik] ([id], [f], [i], [o], [dolgnost]) VALUES (5, N'Покровский', N'Константин', N'Миронович', N'Повар')
INSERT [dbo].[rabotnik] ([id], [f], [i], [o], [dolgnost]) VALUES (6, N'Козина', N'Виктория', N'Владимировна', N'Повар')
INSERT [dbo].[rabotnik] ([id], [f], [i], [o], [dolgnost]) VALUES (7, N'Сергеев', N'Максим', N'Никитич', N'Повар')
INSERT [dbo].[rabotnik] ([id], [f], [i], [o], [dolgnost]) VALUES (8, N'Абрамов', N'Евгений', N'Алексеевич', N'Повар')
INSERT [dbo].[rabotnik] ([id], [f], [i], [o], [dolgnost]) VALUES (9, N'Михайлов', N'Фёдор', N'Ильич', N'Повар')
INSERT [dbo].[rabotnik] ([id], [f], [i], [o], [dolgnost]) VALUES (10, N'Гусева', N'Николь', N'Сергеевна', N'Повар')
SET IDENTITY_INSERT [dbo].[rabotnik] OFF
GO
SET IDENTITY_INSERT [dbo].[zakaz] ON 

INSERT [dbo].[zakaz] ([id], [id_klienta], [id_rabotnika], [id_pitsa], [kolvo], [_time]) VALUES (1, 1, 1, 6, 3, N'12:30:00')
INSERT [dbo].[zakaz] ([id], [id_klienta], [id_rabotnika], [id_pitsa], [kolvo], [_time]) VALUES (2, 2, 7, 1, 2, N'13:30:00')
INSERT [dbo].[zakaz] ([id], [id_klienta], [id_rabotnika], [id_pitsa], [kolvo], [_time]) VALUES (3, 3, 4, 5, 1, N'15:30:00')
INSERT [dbo].[zakaz] ([id], [id_klienta], [id_rabotnika], [id_pitsa], [kolvo], [_time]) VALUES (4, 4, 6, 8, 3, N'16:30:00')
INSERT [dbo].[zakaz] ([id], [id_klienta], [id_rabotnika], [id_pitsa], [kolvo], [_time]) VALUES (5, 5, 4, 9, 5, N'17:30:00')
INSERT [dbo].[zakaz] ([id], [id_klienta], [id_rabotnika], [id_pitsa], [kolvo], [_time]) VALUES (6, 5, 7, 2, 2, N'13:30:00')
INSERT [dbo].[zakaz] ([id], [id_klienta], [id_rabotnika], [id_pitsa], [kolvo], [_time]) VALUES (7, 6, 4, 5, 3, N'18:30:00')
INSERT [dbo].[zakaz] ([id], [id_klienta], [id_rabotnika], [id_pitsa], [kolvo], [_time]) VALUES (8, 7, 6, 3, 1, N'15:30:00')
INSERT [dbo].[zakaz] ([id], [id_klienta], [id_rabotnika], [id_pitsa], [kolvo], [_time]) VALUES (9, 9, 3, 10, 1, N'18:30:00')
INSERT [dbo].[zakaz] ([id], [id_klienta], [id_rabotnika], [id_pitsa], [kolvo], [_time]) VALUES (10, 1, 7, 7, 3, N'14:30:00')
SET IDENTITY_INSERT [dbo].[zakaz] OFF
GO
ALTER TABLE [dbo].[zakaz]  WITH CHECK ADD FOREIGN KEY([id_klienta])
REFERENCES [dbo].[klient] ([id])
GO
ALTER TABLE [dbo].[zakaz]  WITH CHECK ADD FOREIGN KEY([id_pitsa])
REFERENCES [dbo].[pitsa] ([id])
GO
ALTER TABLE [dbo].[zakaz]  WITH CHECK ADD FOREIGN KEY([id_rabotnika])
REFERENCES [dbo].[rabotnik] ([id])
GO
USE [master]
GO
ALTER DATABASE [dodo1] SET  READ_WRITE 
GO
