-- Tạo cơ sở dữ liệu Quản lý Sinh Viên
CREATE DATABASE QuanLySinhVien;
Go
-- Sử dụng cơ sở dữ liệu Quản lý Sinh Viên
USE QuanLySinhVien;
Go
-- Tạo bảng Thông Tin Sinh Viên
CREATE TABLE SinhVien (
    SinhVienID char(20) PRIMARY KEY  NOT NULL,
    Ten NVARCHAR(100) NOT NULL,
    NgaySinh DATE NOT NULL,
    DiaChi NVARCHAR(255) NOT NULL,
	GioiTinh NVARCHAR(10) NOT NULL,
	DuongDanHinhAnh NVARCHAR(255)
    -- Các thông tin khác của sinh viên có thể thêm ở đây
);
select * from SinhVien

/*
ALTER TABLE SinhVien
ADD DuongDanHinhAnh NVARCHAR(255);
*/
Go
-- Tạo bảng Học Phí và Tài Chính
CREATE TABLE LichSuHocPhi (
    HocPhiID INT PRIMARY KEY IDENTITY NOT NULL,
    SinhVienID char(20) NOT NULL,
    SoTien DECIMAL(18, 2) NOT NULL,
    ThoiGianThanhToan DATETIME NOT NULL,
    CONSTRAINT FK_SinhVien_HocPhi FOREIGN KEY (SinhVienID) REFERENCES SinhVien(SinhVienID)
);

CREATE TABLE CongNo (
    CongNoID int primary key identity not null,
    SinhVienID char(20) NOT NULL,
    Sotiencongno DECIMAL(18, 2) NOT NULL DEFAULT 0,
    CONSTRAINT FK_SinhVien_CongNo FOREIGN KEY (SinhVienID) REFERENCES SinhVien(SinhVienID),
    CONSTRAINT CHK_Sotiencongno_NonNegative CHECK (Sotiencongno >= 0)
);

CREATE TABLE TaiKhoan (
	TaiKhoanID int primary key identity NOT NULL,
	Tendangnhap Nvarchar(30) NOT NULL ,
	Matkhau Nvarchar(30)NOT NULL,
	Loaitaikhoan int NOT NULL -- 1 hoac 2 hoac 3
);
GO/*
-- Tạo bảng Điểm Số và Học Tập
CREATE TABLE DiemSo (
    DiemID INT PRIMARY KEY IDENTITY,
    SinhVienID char(20),
    MonHoc NVARCHAR(100),
    Diem FLOAT,
    CONSTRAINT FK_SinhVien_DiemSo FOREIGN KEY (SinhVienID) REFERENCES SinhVien(SinhVienID)
	
);
SELECT DiemSo.SinhVienID, SinhVien.Ten, DiemSo.LichHocID, DiemSo.Diem
FROM DiemSo
JOIN SinhVien ON DiemSo.SinhVienID = SinhVien.SinhVienID
JOIN LichHoc ON DiemSo.LichHocID = LichHoc.LichHocID
WHERE DiemSo.Diem BETWEEN 4 AND 9
AND LichHoc.LichHocID = '321';*/
create table DiemSo(
	SinhVienID char(20) not null,
    LichHocID NVARCHAR(100)  not null,
    Diem FLOAT,
	CONSTRAINT FK_SinhVien_DiemSo FOREIGN KEY (SinhVienID) REFERENCES SinhVien(SinhVienID),
	CONSTRAINT FK_LichHoc_DiemSo FOREIGN KEY (LichHocID) REFERENCES LichHoc(LichHocID)
);

-- Tạo bảng Lịch Học
CREATE TABLE LichHoc (
    LichHocID NVARCHAR(100) PRIMARY KEY not null,
    MonHoc NVARCHAR(100) not null,
    ThoiGian nvarchar(30) not null,
    DiaDiem NVARCHAR(255) not null,
    GiangVienID CHAR(20) not null,
	TinChi int not null,
    CONSTRAINT FK_GiangVien_LichHoc FOREIGN KEY (GiangVienID) REFERENCES GiangVien(GiangVienID)
);


-- Tạo bảng Đăng Ký Học
CREATE TABLE DangKyHoc (
    DangKyID int PRIMARY KEY identity not null,
    SinhVienID CHAR(20) not null,
    LichHocID NVARCHAR(100) not null,
    ThoiGianDangKy DATETIME not null,
    CONSTRAINT FK_SinhVien_DangKyHoc FOREIGN KEY (SinhVienID) REFERENCES SinhVien(SinhVienID),
    CONSTRAINT FK_LichHoc_DangKyHoc FOREIGN KEY (LichHocID) REFERENCES LichHoc(LichHocID)
);


-- Tạo bảng Thông Tin Giảng Viên
CREATE TABLE GiangVien (
    GiangVienID char(20) PRIMARY KEY ,
    TenGV NVARCHAR(100) not null,
	NgaySinhGV date not null,
	GioiTinhGV nvarchar(15) not null,
	DiaChiGV NVARCHAR(255) NOT NULL
    -- Thông tin khác về giảng viên có thể thêm ở đây
);


-- Tạo bảng Hồ Sơ Sinh Viên
CREATE TABLE HoSoSinhVien (
    HoSoID INT PRIMARY KEY IDENTITY,
    SinhVienID CHAR(20) NOT NULL,
    TenFile NVARCHAR(255) NOT NULL,
    LoaiFile NVARCHAR(50) NOT NULL,
    DuongDanFile NVARCHAR(500) NOT NULL,
    DuLieuFile VARBINARY(MAX) NOT NULL,
    CONSTRAINT FK_SinhVien_HoSo FOREIGN KEY (SinhVienID) REFERENCES SinhVien(SinhVienID)
);

-- Hoàn thành quá trình tạo cơ sở dữ liệu

INSERT INTO TaiKhoan (Tendangnhap, Matkhau, Loaitaikhoan)
VALUES ('admin', '123', 1);

SELECT * FROM TaiKhoan;
SELECT * FROM TaiKhoan WHERE Loaitaikhoan = 1;

SELECT Loaitaikhoan FROM TaiKhoan WHERE Tendangnhap = 'admin' AND Matkhau = '123';

INSERT INTO SinhVien (Ten, NgaySinh, DiaChi, GioiTinh)
VALUES 
('Nguyen Van A', '2000-01-15', '123 Le Loi, Da Nang', 'Nam'),
('Tran Thi B', '1999-05-30', '456 Tran Phu, Ha Noi', 'Nu'),
('Le Van C', '2001-08-20', '789 Nguyen Trai, Ho Chi Minh', 'Nam');

ALTER TABLE SinhVien
ADD GioiTinh NVARCHAR(10) NOT NULL;
select * from SinhVien

INSERT INTO TaiKhoan (Tendangnhap, Matkhau, Loaitaikhoan)
VALUES ('thaydieu', '123', 2);

DELETE FROM SinhVien;

SET IDENTITY_INSERT SinhVien ON;
INSERT INTO SinhVien (SinhVienID, Ten, NgaySinh, DiaChi, GioiTinh)
VALUES 
('22h1123', 'Nguyen Van A', '2000-01-15', '123 Le Loi, Da Nang', 'Nam'),
('22h1124', 'Tran Thi B', '1999-05-30', '456 Tran Phu, Ha Noi', 'Nu'),
('22h1125', 'Le Van C', '2001-08-20', '789 Nguyen Trai, Ho Chi Minh', 'Nam');
SET IDENTITY_INSERT SinhVien OFF;
ALTER TABLE SinhVien
ALTER COLUMN SinhVienID char(20);

select * from SinhVien
select * from DangKyHoc


INSERT INTO GiangVien (GiangVienID,TenGV, NgaySinhGV, DiaChiGV, GioiTinhGV)
VALUES 
('13a','Nguyen hoang A', '2000-01-15', '123 Le Loi, Da Nang', 'Nam');



INSERT INTO SinhVien (SinhVienID, Ten, NgaySinh, DiaChi, GioiTinh)
VALUES 
('SV001', N'Nguyễn Văn A', '2000-01-01', N'Hà Nội', N'Nam'),
('SV002', N'Trần Thị B', '2000-02-02', N'Hà Nội', N'Nữ'),
('SV003', N'Lê Văn C', '2000-03-03', N'Hà Nội', N'Nam'),
('SV004', N'Phạm Thị D', '2000-04-04', N'Hà Nội', N'Nữ'),
('SV005', N'Hoàng Văn E', '2000-05-05', N'Hà Nội', N'Nam');



SELECT 
    cn.CongNoID,
    sv.Ten AS TenSinhVien,
    cn.Sotiencongno
FROM 
    CongNo cn
JOIN 
    SinhVien sv ON cn.SinhVienID = sv.SinhVienID;
