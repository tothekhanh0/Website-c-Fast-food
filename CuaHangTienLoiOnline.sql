USE [master]
GO
--drop database [CuaHangTienLoiOnline]
--
CREATE DATABASE [CuaHangTienLoiOnline]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CuaHangTienLoiOnline', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.TOTHEKHANH0\MSSQL\DATA\CuaHangTienLoiOnline.mdf' , SIZE = 4160KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'CuaHangTienLoiOnline_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.TOTHEKHANH0\MSSQL\DATA\CuaHangTienLoiOnline.ldf' , SIZE = 1040KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [CuaHangTienLoiOnline] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CuaHangTienLoiOnline].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CuaHangTienLoiOnline] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CuaHangTienLoiOnline] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CuaHangTienLoiOnline] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CuaHangTienLoiOnline] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CuaHangTienLoiOnline] SET ARITHABORT OFF 
GO
ALTER DATABASE [CuaHangTienLoiOnline] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CuaHangTienLoiOnline] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [CuaHangTienLoiOnline] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CuaHangTienLoiOnline] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CuaHangTienLoiOnline] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CuaHangTienLoiOnline] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CuaHangTienLoiOnline] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CuaHangTienLoiOnline] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CuaHangTienLoiOnline] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CuaHangTienLoiOnline] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CuaHangTienLoiOnline] SET  ENABLE_BROKER 
GO
ALTER DATABASE [CuaHangTienLoiOnline] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CuaHangTienLoiOnline] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CuaHangTienLoiOnline] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CuaHangTienLoiOnline] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CuaHangTienLoiOnline] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CuaHangTienLoiOnline] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CuaHangTienLoiOnline] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CuaHangTienLoiOnline] SET RECOVERY FULL 
GO
ALTER DATABASE [CuaHangTienLoiOnline] SET  MULTI_USER 
GO
ALTER DATABASE [CuaHangTienLoiOnline] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CuaHangTienLoiOnline] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CuaHangTienLoiOnline] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CuaHangTienLoiOnline] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'CuaHangTienLoiOnline', N'ON'
GO
USE [CuaHangTienLoiOnline]
GO
--
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[baiViet](
	[maBV] [varchar](10) NOT NULL,
	[tenBV] [nvarchar](250) NOT NULL,
	[hinhDD] [varchar](max) NULL,
	[ndTomTat] [nvarchar](2000) NULL,
	[ngayDang] [datetime] NULL,
	[noiDung] [nvarchar](4000) NULL,
	[taiKhoan] [varchar](20) NOT NULL,
	[daDuyet] [bit] NULL,
	[maLoai] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[maBV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
--don hang
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ctDonHang](
	[soDH] [varchar](10) NOT NULL,
	[maSP] [varchar](10) NOT NULL,
	[soLuong] [int] NULL,
	[giaBan] [bigint] NULL,
	[giamGia] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[soDH] ASC,
	[maSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
--
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[donHang](
	[soDH] [varchar](10) NOT NULL,
	[maKH] [varchar](10) NOT NULL,
	[taiKhoan] [varchar](20) NOT NULL,
	[ngayDat] [datetime] NULL,
	[daKichHoat] [bit] NULL DEFAULT ((1)),
	[ngayGH] [datetime] NULL,
	[diaChiGH] [nvarchar](250) NULL,
	[ghiChu] [ntext] NULL,
PRIMARY KEY CLUSTERED 
(
	[soDH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
--
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[khachHang](
	[maKH] [varchar](10) NOT NULL,
	[tenKH] [nvarchar](50) NOT NULL,
	[soDT] [varchar](20) NULL,
	[email] [varchar](50) NULL,
	[diaChi] [nvarchar](250) NULL,
	[ngaySinh] [datetime] NULL,
	[gioiTinh] [bit] NULL DEFAULT ((1)),
	[ghiChu] [ntext] NULL,
	[maQH] [int] NULL DEFAULT ((1)),
PRIMARY KEY CLUSTERED 
(
	[maKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
--
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[loaiSanPham](
	[maLoai] [int] IDENTITY(1,1) NOT NULL,
	[loaiSP] [nvarchar](88) NOT NULL DEFAULT (N'Sản phẩm tươi sống'),
	[ghiChu] [ntext] NULL DEFAULT (''),
PRIMARY KEY CLUSTERED 
(
	[maLoai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
--
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[nhomTk](
	[maNhom] [int] IDENTITY(1,1) NOT NULL,
	[tenNhom] [nvarchar](35) NOT NULL DEFAULT (N'Giao hàng'),
	[ghiChu] [ntext] NULL DEFAULT (''),
PRIMARY KEY CLUSTERED 
(
	[maNhom] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[quanHuyen]    Script Date: 4/13/2021 5:24:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[quanHuyen](
	[maQH] [int] IDENTITY(1,1) NOT NULL,
	[tenQH] [nvarchar](88) NOT NULL,
	[tinhThanh] [nvarchar](65) NOT NULL,
	[ghiChu] [ntext] NULL DEFAULT (''),
PRIMARY KEY CLUSTERED 
(
	[maQH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[sanPham]    Script Date: 4/13/2021 5:24:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sanPham](
	[maSP] [varchar](10) NOT NULL,
	[tenSP] [nvarchar](500) NOT NULL,
	[hinhDD] [varchar](max) NULL DEFAULT (''),
	[ndTomTat] [nvarchar](2000) NULL DEFAULT (''),
	[ngayDang] [datetime] NULL DEFAULT (getdate()),
	[loaiHang] [nvarchar](30) NULL DEFAULT ('QA'),
	[noiDung] [nvarchar](4000) NULL DEFAULT (''),
	[taiKhoan] [varchar](20) NOT NULL,
	[daDuyet] [bit] NULL DEFAULT ((0)),
	[giaBan] [int] NULL DEFAULT ((0)),
	[giamGia] [int] NULL DEFAULT ((0)),
	[maLoai] [int] NULL DEFAULT ((1)),
	[nhaSanXuat] [nvarchar](89) NULL DEFAULT (N'Việt nam'),
	[dvt] [nvarchar](12) NULL DEFAULT (N'Cái'),
PRIMARY KEY CLUSTERED 
(
	[maSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[taiKhoanTV]    Script Date: 4/13/2021 5:24:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[taiKhoanTV](
	[taiKhoan] [varchar](20) NOT NULL,
	[matKhau] [varchar](20) NOT NULL,
	[hoDem] [nvarchar](50) NULL,
	[tenTV] [nvarchar](30) NOT NULL,
	[ngaysinh] [datetime] NULL,
	[gioiTinh] [bit] NULL DEFAULT ((1)),
	[soDT] [nvarchar](20) NULL,
	[email] [nvarchar](50) NULL,
	[diaChi] [nvarchar](250) NULL,
	[trangThai] [bit] NULL DEFAULT ((0)),
	[ghiChu] [ntext] NULL,
	[maNhom] [int] NULL DEFAULT ((2)),
	[maQH] [int] NULL DEFAULT ((1)),
PRIMARY KEY CLUSTERED 
(
	[taiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[ctDonHang] ([soDH], [maSP], [soLuong], [giaBan], [giamGia]) VALUES (N'DH0001', N'01', 5, 95000, 20)
INSERT [dbo].[ctDonHang] ([soDH], [maSP], [soLuong], [giaBan], [giamGia]) VALUES (N'DH0001', N'02', 8, 96000, 15)
INSERT [dbo].[ctDonHang] ([soDH], [maSP], [soLuong], [giaBan], [giamGia]) VALUES (N'DH0002', N'03', 3, 84000, 20)
INSERT [dbo].[ctDonHang] ([soDH], [maSP], [soLuong], [giaBan], [giamGia]) VALUES (N'DH0002', N'04', 2, 120000, 35)
INSERT [dbo].[ctDonHang] ([soDH], [maSP], [soLuong], [giaBan], [giamGia]) VALUES (N'DH0003', N'05', 5, 175000, 23)
INSERT [dbo].[ctDonHang] ([soDH], [maSP], [soLuong], [giaBan], [giamGia]) VALUES (N'DH0003', N'06', 8, 15000, 42)
INSERT [dbo].[ctDonHang] ([soDH], [maSP], [soLuong], [giaBan], [giamGia]) VALUES (N'DH0004', N'07', 1, 10000, 12)
INSERT [dbo].[ctDonHang] ([soDH], [maSP], [soLuong], [giaBan], [giamGia]) VALUES (N'DH0004', N'08', 4, 48000, 27)

GO
INSERT [dbo].[donHang] ([soDH], [maKH], [taiKhoan], [ngayDat], [daKichHoat], [ngayGH], [diaChiGH], [ghiChu]) VALUES (N'DH0001', N'KH001', N'minh', CAST(N'2020-02-12 00:00:00.000' AS DateTime), 1, CAST(N'2020-02-14 00:00:00.000' AS DateTime), N'23 Trần Quang Khải, P.Tân Định', N'')
--INSERT [dbo].[donHang] ([soDH], [maKH], [taiKhoan], [ngayDat], [daKichHoat], [ngayGH], [diaChiGH], [ghiChu]) VALUES (N'DH0001', N'KH002', N'minh', CAST(N'2020-02-12 00:00:00.000' AS DateTime), 1, CAST(N'2020-02-14 00:00:00.000' AS DateTime), N'112/2 Bến Vân Đồn, P1', N'')
INSERT [dbo].[donHang] ([soDH], [maKH], [taiKhoan], [ngayDat], [daKichHoat], [ngayGH], [diaChiGH], [ghiChu]) VALUES (N'DH0002', N'KH003', N'minh', CAST(N'2020-02-12 00:00:00.000' AS DateTime), 1, CAST(N'2020-02-14 00:00:00.000' AS DateTime), N'221 Nguyễn Trãi, P5', N'')
--INSERT [dbo].[donHang] ([soDH], [maKH], [taiKhoan], [ngayDat], [daKichHoat], [ngayGH], [diaChiGH], [ghiChu]) VALUES (N'DH0002', N'KH004', N'minh', CAST(N'2020-02-12 00:00:00.000' AS DateTime), 1, CAST(N'2020-02-14 00:00:00.000' AS DateTime), N'122 Cách Mạng Tháng 8, P10', N'')
INSERT [dbo].[donHang] ([soDH], [maKH], [taiKhoan], [ngayDat], [daKichHoat], [ngayGH], [diaChiGH], [ghiChu]) VALUES (N'DH0003', N'KH005', N'minh', CAST(N'2020-02-12 00:00:00.000' AS DateTime), 1, CAST(N'2020-02-14 00:00:00.000' AS DateTime), N'96 Nguyễn Thiện Thuật, P7', N'')
--INSERT [dbo].[donHang] ([soDH], [maKH], [taiKhoan], [ngayDat], [daKichHoat], [ngayGH], [diaChiGH], [ghiChu]) VALUES (N'DH0003', N'KH006', N'minh', CAST(N'2020-02-12 00:00:00.000' AS DateTime), 1, CAST(N'2020-02-14 00:00:00.000' AS DateTime), N'211 Xô Viết Nghệ Tĩnh, P26', N'')
INSERT [dbo].[donHang] ([soDH], [maKH], [taiKhoan], [ngayDat], [daKichHoat], [ngayGH], [diaChiGH], [ghiChu]) VALUES (N'DH0004', N'KH007', N'minh', CAST(N'2020-02-13 00:00:00.000' AS DateTime), 1, CAST(N'2020-02-15 00:00:00.000' AS DateTime), N'23 Trần Quang Khải, P.Tân Định', N'')
--INSERT [dbo].[donHang] ([soDH], [maKH], [taiKhoan], [ngayDat], [daKichHoat], [ngayGH], [diaChiGH], [ghiChu]) VALUES (N'DH0004', N'KH008', N'minh', CAST(N'2020-02-13 00:00:00.000' AS DateTime), 1, CAST(N'2020-02-14 00:00:00.000' AS DateTime), N'112/2 Bến Vân Đồn, P1', N'')
GO
INSERT [dbo].[khachHang] ([maKH], [tenKH], [soDT], [email], [diaChi], [ngaySinh], [gioiTinh], [ghiChu], [maQH]) VALUES (N'KH001', N'Nguyễn Minh Hùng', N'0901222222', N'nmhung@gmail.com', N'23 Trần Quang Khải, P.Tân Định', CAST(N'1985-02-23 00:00:00.000' AS DateTime), 1, N'', 1)
INSERT [dbo].[khachHang] ([maKH], [tenKH], [soDT], [email], [diaChi], [ngaySinh], [gioiTinh], [ghiChu], [maQH]) VALUES (N'KH002', N'Võ Hoàng Ý Lan', N'0901333333', N'vhylan@gmail.com', N'112/2 Bến Vân Đồn, P1', CAST(N'1980-08-11 00:00:00.000' AS DateTime), 0, N'', 4)
INSERT [dbo].[khachHang] ([maKH], [tenKH], [soDT], [email], [diaChi], [ngaySinh], [gioiTinh], [ghiChu], [maQH]) VALUES (N'KH003', N'Trần Thanh Trung', N'0901246357', N'tttrung@gmail.com', N'221 Nguyễn Trãi, P5', CAST(N'1989-01-30 00:00:00.000' AS DateTime), 1, N'', 5)
INSERT [dbo].[khachHang] ([maKH], [tenKH], [soDT], [email], [diaChi], [ngaySinh], [gioiTinh], [ghiChu], [maQH]) VALUES (N'KH004', N'Phan Quang Tuấn', N'0903121212', N'tqtuan@yahoo.com', N'122 Cách Mạng Tháng 8, P10', CAST(N'1994-10-12 00:00:00.000' AS DateTime), 1, N'', 3)
INSERT [dbo].[khachHang] ([maKH], [tenKH], [soDT], [email], [diaChi], [ngaySinh], [gioiTinh], [ghiChu], [maQH]) VALUES (N'KH005', N'Nguyễn Quang Minh', N'0908552323', N'nqminh@hotmail.com', N'96 Nguyễn Thiện Thuật, P7', CAST(N'1981-05-29 00:00:00.000' AS DateTime), 1, N'', 3)
INSERT [dbo].[khachHang] ([maKH], [tenKH], [soDT], [email], [diaChi], [ngaySinh], [gioiTinh], [ghiChu], [maQH]) VALUES (N'KH006', N'Bùi Đình Thưởng', N'0913441256', N'bdthuong@gmail.com', N'211 Xô Viết Nghệ Tĩnh, P26', CAST(N'1995-09-20 00:00:00.000' AS DateTime), 1, N'', 13)
INSERT [dbo].[khachHang] ([maKH], [tenKH], [soDT], [email], [diaChi], [ngaySinh], [gioiTinh], [ghiChu], [maQH]) VALUES (N'KH007', N'Đỗ Nguyễn Hoàng Anh', N'0968717189', N'dnhanh@yahoo.com', N'91 Hoa Sữa, P12', CAST(N'1992-02-11 00:00:00.000' AS DateTime), 1, N'', 20)
INSERT [dbo].[khachHang] ([maKH], [tenKH], [soDT], [email], [diaChi], [ngaySinh], [gioiTinh], [ghiChu], [maQH]) VALUES (N'KH008', N'Nguyễn Vinh Quang', N'0903456789', N'nvquang@yahoo.com', N'11/3/12 Phan Đình Phùng, P11', CAST(N'1981-08-12 00:00:00.000' AS DateTime), 1, N'', 20)
SET IDENTITY_INSERT [dbo].[loaiSanPham] ON 

INSERT [dbo].[loaiSanPham] ([maLoai], [loaiSP], [ghiChu]) VALUES (11, N'Đồ uống', N'có ga')
INSERT [dbo].[loaiSanPham] ([maLoai], [loaiSP], [ghiChu]) VALUES (22, N'Sandwich', N'')
INSERT [dbo].[loaiSanPham] ([maLoai], [loaiSP], [ghiChu]) VALUES (33, N'Gà rán', N'')
INSERT [dbo].[loaiSanPham] ([maLoai], [loaiSP], [ghiChu]) VALUES (44, N'Pizza', N'')
INSERT [dbo].[loaiSanPham] ([maLoai], [loaiSP], [ghiChu]) VALUES (55, N'Hamburger', N'')
INSERT [dbo].[loaiSanPham] ([maLoai], [loaiSP], [ghiChu]) VALUES (66, N'Snack', N'')
INSERT [dbo].[loaiSanPham] ([maLoai], [loaiSP], [ghiChu]) VALUES (77, N'Cafe', N'')
INSERT [dbo].[loaiSanPham] ([maLoai], [loaiSP], [ghiChu]) VALUES (88, N'Bánh donut', N'')
INSERT [dbo].[loaiSanPham] ([maLoai], [loaiSP], [ghiChu]) VALUES (99, N'Combo', N'')
SET IDENTITY_INSERT [dbo].[loaiSanPham] OFF
SET IDENTITY_INSERT [dbo].[nhomTk] ON 

INSERT [dbo].[nhomTk] ([maNhom], [tenNhom], [ghiChu]) VALUES (1, N'Quản lý', N'')
INSERT [dbo].[nhomTk] ([maNhom], [tenNhom], [ghiChu]) VALUES (2, N'Giao hàng', N'')
INSERT [dbo].[nhomTk] ([maNhom], [tenNhom], [ghiChu]) VALUES (3, N'Marketing', N'')
SET IDENTITY_INSERT [dbo].[nhomTk] OFF
SET IDENTITY_INSERT [dbo].[quanHuyen] ON 

INSERT [dbo].[quanHuyen] ([maQH], [tenQH], [tinhThanh], [ghiChu]) VALUES (1, N'Q1', N'TP Hồ Chí Minh', N'')
INSERT [dbo].[quanHuyen] ([maQH], [tenQH], [tinhThanh], [ghiChu]) VALUES (2, N'Q2', N'TP Hồ Chí Minh', N'')
INSERT [dbo].[quanHuyen] ([maQH], [tenQH], [tinhThanh], [ghiChu]) VALUES (3, N'Q3', N'TP Hồ Chí Minh', N'')
INSERT [dbo].[quanHuyen] ([maQH], [tenQH], [tinhThanh], [ghiChu]) VALUES (4, N'Q4', N'TP Hồ Chí Minh', N'')
INSERT [dbo].[quanHuyen] ([maQH], [tenQH], [tinhThanh], [ghiChu]) VALUES (5, N'Q5', N'TP Hồ Chí Minh', N'')
INSERT [dbo].[quanHuyen] ([maQH], [tenQH], [tinhThanh], [ghiChu]) VALUES (6, N'Q6', N'TP Hồ Chí Minh', N'')
INSERT [dbo].[quanHuyen] ([maQH], [tenQH], [tinhThanh], [ghiChu]) VALUES (7, N'Q7', N'TP Hồ Chí Minh', N'')
INSERT [dbo].[quanHuyen] ([maQH], [tenQH], [tinhThanh], [ghiChu]) VALUES (8, N'Q8', N'TP Hồ Chí Minh', N'')
INSERT [dbo].[quanHuyen] ([maQH], [tenQH], [tinhThanh], [ghiChu]) VALUES (9, N'Q9', N'TP Hồ Chí Minh', N'')
INSERT [dbo].[quanHuyen] ([maQH], [tenQH], [tinhThanh], [ghiChu]) VALUES (10, N'Q10', N'TP Hồ Chí Minh', N'')
INSERT [dbo].[quanHuyen] ([maQH], [tenQH], [tinhThanh], [ghiChu]) VALUES (11, N'Q11', N'TP Hồ Chí Minh', N'')
INSERT [dbo].[quanHuyen] ([maQH], [tenQH], [tinhThanh], [ghiChu]) VALUES (12, N'Q12', N'TP Hồ Chí Minh', N'')
INSERT [dbo].[quanHuyen] ([maQH], [tenQH], [tinhThanh], [ghiChu]) VALUES (13, N'Bình Thạnh', N'TP Hồ Chí Minh', N'')
INSERT [dbo].[quanHuyen] ([maQH], [tenQH], [tinhThanh], [ghiChu]) VALUES (14, N'Bình Tân', N'TP Hồ Chí Minh', N'')
INSERT [dbo].[quanHuyen] ([maQH], [tenQH], [tinhThanh], [ghiChu]) VALUES (15, N'Bình chánh', N'TP Hồ Chí Minh', N'')
INSERT [dbo].[quanHuyen] ([maQH], [tenQH], [tinhThanh], [ghiChu]) VALUES (16, N'Tân Phú', N'TP Hồ Chí Minh', N'')
INSERT [dbo].[quanHuyen] ([maQH], [tenQH], [tinhThanh], [ghiChu]) VALUES (17, N'Cần Giờ', N'TP Hồ Chí Minh', N'')
INSERT [dbo].[quanHuyen] ([maQH], [tenQH], [tinhThanh], [ghiChu]) VALUES (18, N'Nhà Bè', N'TP Hồ Chí Minh', N'')
INSERT [dbo].[quanHuyen] ([maQH], [tenQH], [tinhThanh], [ghiChu]) VALUES (19, N'Củ Chi', N'TP Hồ Chí Minh', N'')
INSERT [dbo].[quanHuyen] ([maQH], [tenQH], [tinhThanh], [ghiChu]) VALUES (20, N'Phú Nhuận', N'TP Hồ Chí Minh', N'')
INSERT [dbo].[quanHuyen] ([maQH], [tenQH], [tinhThanh], [ghiChu]) VALUES (21, N'Tân Bình', N'TP Hồ Chí Minh', N'')
INSERT [dbo].[quanHuyen] ([maQH], [tenQH], [tinhThanh], [ghiChu]) VALUES (22, N'Hóc Môn', N'TP Hồ Chí Minh', N'')
INSERT [dbo].[quanHuyen] ([maQH], [tenQH], [tinhThanh], [ghiChu]) VALUES (23, N'Thủ Đức', N'TP Hồ Chí Minh', N'')
INSERT [dbo].[quanHuyen] ([maQH], [tenQH], [tinhThanh], [ghiChu]) VALUES (24, N'Gò Vấp', N'TP Hồ Chí Minh', N'')
SET IDENTITY_INSERT [dbo].[quanHuyen] OFF

INSERT [dbo].[sanPham] ([maSP], [tenSP], [hinhDD], [ndTomTat], [ngayDang], [loaiHang], [noiDung], [taiKhoan], [daDuyet], [giaBan], [giamGia], [maLoai], [nhaSanXuat], [dvt]) 
VALUES (N'01', N'Cà phê', N'cafe.jpg', N'Cà phê g7 3 in 1', CAST(N'2020-09-12 15:31:15.857' AS DateTime), N'QA', N'Nội dung Giới thiệu sản phẩm cà phê g7 3 trong 1 16gram', N'minh', 0, 19000, 20, 77, N'Việt Nam', N'ly')
INSERT [dbo].[sanPham] ([maSP], [tenSP], [hinhDD], [ndTomTat], [ngayDang], [loaiHang], [noiDung], [taiKhoan], [daDuyet], [giaBan], [giamGia], [maLoai], [nhaSanXuat], [dvt]) 
VALUES (N'02', N'Pepsi', N'pepsi.jpg', N'Nước ngọt pepsi', CAST(N'2020-09-12 15:31:15.857' AS DateTime), N'TX', N'Nội dung Giới thiệu sản phẩm nước ngọt pepsi', N'minh', 0, 12000, 15, 11, N'Viêt Nam',N'lon cao')
INSERT [dbo].[sanPham] ([maSP], [tenSP], [hinhDD], [ndTomTat], [ngayDang], [loaiHang], [noiDung], [taiKhoan], [daDuyet], [giaBan], [giamGia], [maLoai], [nhaSanXuat], [dvt]) 
VALUES (N'03', N'Sandwich', N'sandwich.jpg', N'Bánh Sandwich', CAST(N'2020-09-12 15:31:15.857' AS DateTime), N'TX', N'Nội dung Giới thiệu bánh Sandwich', N'minh', 0, 28000, 20, 22, N'Việt Nam', N'phần')
INSERT [dbo].[sanPham] ([maSP], [tenSP], [hinhDD], [ndTomTat], [ngayDang], [loaiHang], [noiDung], [taiKhoan], [daDuyet], [giaBan], [giamGia], [maLoai], [nhaSanXuat], [dvt]) 
VALUES (N'04', N'Gà rán', N'garan.jpg', N'Gà rán', CAST(N'2020-09-12 15:31:15.857' AS DateTime), N'PK', N'Nội dung Giới thiệu món gà rán', N'minh', 0, 30000, 35, 33, N'Viêt Nam', N'Phần')
INSERT [dbo].[sanPham] ([maSP], [tenSP], [hinhDD], [ndTomTat], [ngayDang], [loaiHang], [noiDung], [taiKhoan], [daDuyet], [giaBan], [giamGia], [maLoai], [nhaSanXuat], [dvt]) 
VALUES (N'05', N'Pizza', N'pizza.jpg', N'Bánh pizza', CAST(N'2020-09-12 15:31:15.857' AS DateTime), N'GD', N'Nội dung Giới thiệu bánh pizza cỡ vừa', N'minh', 0, 35000, 23, 44, N'Việt Nam', N'chiếc')
INSERT [dbo].[sanPham] ([maSP], [tenSP], [hinhDD], [ndTomTat], [ngayDang], [loaiHang], [noiDung], [taiKhoan], [daDuyet], [giaBan], [giamGia], [maLoai], [nhaSanXuat], [dvt]) 
VALUES (N'06', N'Hamburger', N'hamburger.jpg', N'Bánh hamburger', CAST(N'2020-09-12 15:31:15.857' AS DateTime), N'GD', N'Nội dung Giới thiệu bánh Hamburger', N'minh', 0, 25000, 42, 55, N'Việt Nam', N'cái')
INSERT [dbo].[sanPham] ([maSP], [tenSP], [hinhDD], [ndTomTat], [ngayDang], [loaiHang], [noiDung], [taiKhoan], [daDuyet], [giaBan], [giamGia], [maLoai], [nhaSanXuat], [dvt]) 
VALUES (N'07', N'Bánh Snack', N'snack.jpg', N'Snack', CAST(N'2020-09-12 15:31:15.857' AS DateTime), N'PK', N'Snack gói', N'minh', 0, 10000, 12, 66, N'Việt Nam', N'gói')
INSERT [dbo].[sanPham] ([maSP], [tenSP], [hinhDD], [ndTomTat], [ngayDang], [loaiHang], [noiDung], [taiKhoan], [daDuyet], [giaBan], [giamGia], [maLoai], [nhaSanXuat], [dvt]) 
VALUES (N'08', N'Bánh Donut', N'donut.jpg', N'Bánh donut', CAST(N'2020-09-12 15:31:15.857' AS DateTime), N'PK', N'Nội dung Giới thiệu bánh donut', N'minh', 0, 12000, 27, 88, N'Việt Nam', N'phần')
INSERT [dbo].[sanPham] ([maSP], [tenSP], [hinhDD], [ndTomTat], [ngayDang], [loaiHang], [noiDung], [taiKhoan], [daDuyet], [giaBan], [giamGia], [maLoai], [nhaSanXuat], [dvt])
VALUES (N'09', N'Combo',  N'garan_pepsi.jpg', N'Combo gà rán + nước pepsi', CAST(N'2020-09-12 15:31:15.857' AS DateTime), N'PK', N'Combo gà rán + nước ngọt pepsi giá 65.000đ', N'minh', 0, 65000, 0, 99, N'Việt Nam', N'phần')


INSERT [dbo].[taiKhoanTV] ([taiKhoan], [matKhau], [hoDem], [tenTV], [ngaysinh], [gioiTinh], [soDT], [email], [diaChi], [trangThai], [ghiChu], [maNhom], [maQH]) 
VALUES (N'admin', N'abc', N'Nguyễn Quang', N'Hưng', CAST(N'1900-01-01 00:00:00.000' AS DateTime), 1, N'935694223', N'nqhung@gmail.com', N'472 CMT8, P.11,Q3, TP.HCM', 1, N'', 1, NULL)
INSERT [dbo].[taiKhoanTV] ([taiKhoan], [matKhau], [hoDem], [tenTV], [ngaysinh], [gioiTinh], [soDT], [email], [diaChi], [trangThai], [ghiChu], [maNhom], [maQH]) 
VALUES (N'minh', N'123', N'Nguyễn Minh', N'Quang', CAST(N'1900-01-01 00:00:00.000' AS DateTime), 1, N'935694223', N'minhminh@gmail.com', N'472 CMT8, P.11,Q3, TP.HCM', 1, N'', NULL, NULL)

ALTER TABLE [dbo].[baiViet] ADD  DEFAULT ((0)) FOR [daDuyet]
GO
ALTER TABLE [dbo].[baiViet] ADD  DEFAULT ((1)) FOR [maLoai]
GO
ALTER TABLE [dbo].[baiViet]  WITH CHECK ADD FOREIGN KEY([maLoai])
REFERENCES [dbo].[loaiSanPham] ([maLoai])
GO
ALTER TABLE [dbo].[baiViet]  WITH CHECK ADD FOREIGN KEY([taiKhoan])
REFERENCES [dbo].[taiKhoanTV] ([taiKhoan])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[ctDonHang]  WITH CHECK ADD FOREIGN KEY([maSP])
REFERENCES [dbo].[sanPham] ([maSP])
GO
ALTER TABLE [dbo].[ctDonHang]  WITH CHECK ADD FOREIGN KEY([soDH])
REFERENCES [dbo].[donHang] ([soDH])
GO
ALTER TABLE [dbo].[donHang]  WITH CHECK ADD FOREIGN KEY([maKH])
REFERENCES [dbo].[khachHang] ([maKH])
GO
ALTER TABLE [dbo].[donHang]  WITH CHECK ADD FOREIGN KEY([taiKhoan])
REFERENCES [dbo].[taiKhoanTV] ([taiKhoan])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[khachHang]  WITH CHECK ADD FOREIGN KEY([maQH])
REFERENCES [dbo].[quanHuyen] ([maQH])
GO
ALTER TABLE [dbo].[sanPham]  WITH CHECK ADD FOREIGN KEY([maLoai])
REFERENCES [dbo].[loaiSanPham] ([maLoai])
GO
ALTER TABLE [dbo].[sanPham]  WITH CHECK ADD FOREIGN KEY([taiKhoan])
REFERENCES [dbo].[taiKhoanTV] ([taiKhoan])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[taiKhoanTV]  WITH CHECK ADD FOREIGN KEY([maNhom])
REFERENCES [dbo].[nhomTk] ([maNhom])
GO
ALTER TABLE [dbo].[taiKhoanTV]  WITH CHECK ADD FOREIGN KEY([maQH])
REFERENCES [dbo].[quanHuyen] ([maQH])
GO
ALTER TABLE [dbo].[sanPham]  WITH CHECK ADD CHECK  (([giamGia]>=(0) AND [giamGia]<=(100)))
GO
USE [master]
GO
ALTER DATABASE [CuaHangTienLoiOnline] SET  READ_WRITE 
GO
select * from sanPham
select * from taiKhoanTV