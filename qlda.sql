
﻿use master
IF EXISTS (SELECT * FROM master.sys.databases WHERE  name = 'QlDean_NguyenThaiDuong_20ct2')
    drop database QlDean_NguyenThaiDuong_20ct2
GO

CREATE DATABASE QlDean_NguyenThaiDuong_20ct2
ON
    ( Name = QlDean_NguyenThaiDuong_20ct2, 
    Filename= 'D:\SQL data\QlDean_NguyenThaiDuong_20ct2.mdf',
    Size=3MB, Filegrowth=10% )
go
USE QlDean_NguyenThaiDuong_20ct2

--PHONG BAN
go
CREATE TABLE PHONGBAN
(
	TENPHG NVARCHAR(50),
	MAPH NVARCHAR(50) NOT null,
	TRPHG NVARCHAR(50) NOT null,
	NG_NHANCHUC DATETIME
)
go
--dd phg
CREATE TABLE DIADIEM_PHG
(
	MAPHG NVARCHAR(50) NOT null,
	DIADIEM NVARCHAR(50)  NOT null
)
--Nvien
go
CREATE TABLE NHANVIEN
(
	HONV NVARCHAR(50),
	TENLOT NVARCHAR(50),
	TEN NVARCHAR(50),
	MANV NVARCHAR(50) NOT null,
	NGSINH DATETIME,
	DCHI NVARCHAR(50),
	PHAI NVARCHAR(50),
	LUONG INT,
	PHG NVARCHAR(50) NOT null
)
--DeAn
go
CREATE TABLE DEAN
(
	TENDA NVARCHAR(50),
	MADA NVARCHAR(50) NOT null,
	DDIEM_DA NVARCHAR(50),
	NGAYBD DATETIME,
	NGAYKT DATETIME
	
)
--phancong
go
CREATE TABLE PHANCONG
(
	MADA NVARCHAR(50) NOT null,
	MA_NVIEN NVARCHAR(50) NOT null,
	VITRI NVARCHAR(50) NOT null
)
--thannhan
go
CREATE TABLE THANNHAN
(
	MA_NVIEN NVARCHAR(50) NOT NULL,
	TENTN NVARCHAR(50) NOT null,
	PHAI NVARCHAR(50),
	NGSINH DATETIME,
	QUANHE NVARCHAR(50)
)
go

--các ràng buộc
--CHÍNH
alter table PHONGBAN
ADD CONSTRAINT pk_PHONGBAN PRIMARY KEY(MAPH)

alter table DIADIEM_PHG
ADD CONSTRAINT pk_DIADIEM_PHG PRIMARY KEY(MAPHG,DIADIEM)

alter table NHANVIEN
ADD CONSTRAINT pk_NHANVIEN PRIMARY KEY(MANV)

alter table DEAN
ADD CONSTRAINT pk_DEAN PRIMARY KEY(MADA)

alter table PHANCONG
ADD CONSTRAINT pk_PHANCONG PRIMARY KEY(MADA,MA_NVIEN)

alter table THANNHAN
ADD CONSTRAINT pk_THANNHAN PRIMARY KEY(MA_NVIEN,TENTN)

--ngoại
-- DIADIEM_PHG
alter table DIADIEM_PHG
add
    CONSTRAINT fk_DIADIEM_PHG_MaPH FOREIGN KEY(MAPHG)
            REFERENCES dbo.PHONGBAN(MAPH)
--nhanvien
alter table dbo.NHANVIEN
add
    CONSTRAINT fk_NHANVIEN_MaPH FOREIGN KEY(PHG)
            REFERENCES dbo.PHONGBAN(MAPH)

--PHANCONG
alter table dbo.PHANCONG
add
    CONSTRAINT fk_PHANCONG_Mada FOREIGN KEY(MADA)
            REFERENCES dbo.DEAN(MADA)

alter table dbo.PHANCONG
add
    CONSTRAINT fk_PHANCONG_MaNV FOREIGN KEY(MA_NVIEN)
            REFERENCES dbo.NHANVIEN(MANV)
--THANNHAN

alter table dbo.THANNHAN
add
    CONSTRAINT fk_THANNHAN_MaNV FOREIGN KEY(MA_NVIEN)
            REFERENCES dbo.NHANVIEN(MANV)
--phong ban 
alter table dbo.PHONGBAN
add
    CONSTRAINT fk_PHONGBAN_TRGPHG FOREIGN KEY(TRPHG)
            REFERENCES dbo.NHANVIEN(MANV)


set dateformat dmy
go
--insert dữ liệu phòng ban
INSERT INTO PHONGBAN VALUES(N'Phòng triển khai','5','333445555','22/05/2010')
INSERT INTO PHONGBAN VALUES(N'Phòng xây dựng','4','987987987','01/01/2011')
INSERT INTO PHONGBAN VALUES(N'Phòng quản lý','1','888665555','19/06/2012')

--insert dữ liệu DIADIEM_PHG
INSERT INTO DIADIEM_PHG VALUES('1',N'Đà Nẵng')
INSERT INTO DIADIEM_PHG VALUES('4',N'Đà Nẵng')
INSERT INTO DIADIEM_PHG VALUES('5',N'Đà Nẵng')
INSERT INTO DIADIEM_PHG VALUES('5',N'Hà Nội')
INSERT INTO DIADIEM_PHG VALUES('5',N'Quảng Nam')

--insert dữ liệu nhanvien
INSERT INTO nhanvien VALUES(N'Đinh',N'Bá',N'Tiên','123456789','09/01/1970',N'TPHCM','Nam',30000,'5')
INSERT INTO nhanvien VALUES(N'Nguyễn',N'Thanh',N'Tùng','333445555','08/12/1975',N'TPHCM','Nam',40000,'5')
INSERT INTO nhanvien VALUES(N'Bùi',N'Thúy',N'Vũ','999887777','19/07/1985',N'Đà Nẵng',N'Nữ',25000,'4')
INSERT INTO nhanvien VALUES(N'Lê',N'Thị',N'Nhàn','987654321','20/06/1978',N'Huế',N'Nữ',43000,'4')
INSERT INTO nhanvien VALUES(N'Nguyễn',N'Mạnh',N'Hùng','666884444','15/09/1984',N'Quảng Nam',N'Nam',38000,'5')
INSERT INTO nhanvien VALUES(N'Trần',N'Thanh',N'Tâm','453453453','31/07/1988',N'Quảng Trị','Nam',25000,'5')
INSERT INTO nhanvien VALUES(N'Trần',N'Hồng',N'Quân','987987987','29/03/1990',N'Đà nẵng','Nam',25000,'4')
INSERT INTO nhanvien VALUES(N'Vương',N'Ngọc',N'Quyền','888665555','10/10/1965',N'Quảng Ngãi',N'Nữ',55000,'1')


--insert du lieu dean
INSERT INTO DEAN VALUES(N'Quản lý khách sạn','100',N'Đà Nẵng','1/1/2012','20/2/2012')
INSERT INTO DEAN VALUES(N'Quản lý bệnh viện','200',N'Đà Nẵng','15/3/2013','30/6/2013')
INSERT INTO DEAN VALUES(N'Quản lý bán hàng','300',N'Hà Nội','1/12/2013','1/2/2014')
INSERT INTO DEAN VALUES(N'Quản lý đào tạo','400',N'Hà Nội','15/3/2014','')


--insert du lieu phan cong
INSERT INTO PHANCONG VALUES('100','333445555',N'Trưởng nhóm')
INSERT INTO PHANCONG VALUES('100','123456789',N'Thành viên')
INSERT INTO PHANCONG VALUES('100','666884444',N'Thành viên')
INSERT INTO PHANCONG VALUES('200','987987987',N'Trưởng dự án')
INSERT INTO PHANCONG VALUES('200','999887777',N'Trưởng nhóm')
INSERT INTO PHANCONG VALUES('200','453453453',N'Thành viên')
INSERT INTO PHANCONG VALUES('200','987654321',N'Thành viên')
INSERT INTO PHANCONG VALUES('300','987987987',N'Trưởng dự án')
INSERT INTO PHANCONG VALUES('300','999887777',N'Trưởng nhóm')
INSERT INTO PHANCONG VALUES('300','333445555',N'Trưởng nhóm')
INSERT INTO PHANCONG VALUES('300','666884444',N'Thành viên')
INSERT INTO PHANCONG VALUES('300','123456789',N'Thành viên')
INSERT INTO PHANCONG VALUES('400','987987987',N'Trưởng dự án')
INSERT INTO PHANCONG VALUES('400','999887777',N'Trưởng nhóm')
INSERT INTO PHANCONG VALUES('400','123456789',N'Thành viên')
INSERT INTO PHANCONG VALUES('400','333445555',N'Thành viên')
INSERT INTO PHANCONG VALUES('400','987654321',N'Thành viên')
INSERT INTO PHANCONG VALUES('400','666884444',N'Thành viên')

--insert du lieu than nhan
INSERT INTO THANNHAN VALUES('333445555',N'Quang',N'Nữ','05/04/2005','Con gai')
INSERT INTO THANNHAN VALUES('333445555',N'Khang',N'Nam','25/10/2008','Con trai')
INSERT INTO THANNHAN VALUES('333445555',N'Duong',N'Nữ','03/05/1978','Vo chong')
INSERT INTO THANNHAN VALUES('987654321',N'Dang',N'Nam','20/02/1970','Vo chong')
INSERT INTO THANNHAN VALUES('123456789',N'Duy',N'Nam','01/01/2000','Con trai')
INSERT INTO THANNHAN VALUES('123456789',N'Chau',N'Nữ','31/12/2004','Con gai')
INSERT INTO THANNHAN VALUES('123456789',N'Phuong',N'Nữ','05/05/1977','Vo chong')

--cac cau lenh truy van
--a. Cho biết danh sách các nhân viên thuộc phòng triển khai.
SELECT * FROM dbo.NHANVIEN a
INNER JOIN dbo.PHONGBAN b ON a.PHG=b.MAPH
WHERE b.TENPHG=N'Phòng triển khai'
--b. Cho biết họ tên trưởng phòng của phòng quản lý
SELECT a.HONV,a.TENLOT,a.TEN FROM dbo.NHANVIEN a
INNER JOIN dbo.PHONGBAN b ON a.MANV =b.TRPHG
WHERE b.TENPHG=N'Phòng quản lý'
--c. Cho biết họ tên những trưởng phòng tham gia đề án ở “Hà Nội”
SELECT DISTINCT a.HONV,a.TENLOT,a.TEN  FROM dbo.NHANVIEN a
INNER JOIN dbo.PHONGBAN b ON a.MANV =b.TRPHG
INNER JOIN dbo.PHANCONG c ON c.MA_NVIEN=b.TRPHG
INNER JOIN dbo.DEAN d ON c.MADA=d.MADA
WHERE d.DDIEM_DA=N'Hà Nội'

--d. Cho biết họ tên nhân viên có thân nhân.
SELECT DISTINCT a.HONV,a.TENLOT,a.TEN  FROM dbo.NHANVIEN a
INNER JOIN dbo.THANNHAN b ON a.MANV=b.MA_NVIEN
--e. Cho biết họ tên nhân viên được phân công tham gia đề án.
SELECT DISTINCT a.HONV,a.TENLOT,a.TEN  FROM dbo.NHANVIEN a
INNER JOIN dbo.PHANCONG c ON a.MANV=c.MA_NVIEN
--f. Cho biết mã nhân viên (MA_NVIEN) có người thân và tham gia đề án.
SELECT DISTINCT c.MA_NVIEN FROM dbo.NHANVIEN a
INNER JOIN dbo.THANNHAN b ON a.MANV=b.MA_NVIEN
INNER JOIN dbo.PHANCONG c ON a.MANV=c.MA_NVIEN

--g. Danh sách các đề án (MADA) có nhân viên họ “Nguyễn” tham gia.
SELECT DISTINCT b.MADA FROM dbo.NHANVIEN a
INNER JOIN dbo.PHANCONG b ON a.MANV=b.MA_NVIEN
WHERE a.HONV=N'Nguyễn'
--h. Danh sách các đề án (TENDA) có người trưởng phòng họ “Nguyễn” chủ trì.
SELECT DISTINCT d.TENDA  FROM dbo.NHANVIEN a
INNER JOIN dbo.PHONGBAN b ON a.MANV=b.TRPHG
INNER JOIN dbo.PHANCONG c ON a.MANV=c.MA_NVIEN
INNER JOIN dbo.DEAN d ON d.MADA=c.MADA
WHERE a.HONV=N'Nguyễn'

--i. Cho biết tên của các nhân viên và tên các phòng ban mà họ phụ trách nếu có
SELECT  a.HONV,a.TENLOT,a.TEN ,b.TENPHG  FROM dbo.NHANVIEN a
INNER JOIN dbo.PHONGBAN b ON a.PHG=b.MAPH
--j.
--j1 Danh sách những đề án có: Người tham gia có họ “Đinh”
SELECT DISTINCT c.* FROM dbo.NHANVIEN a
INNER JOIN dbo.PHANCONG b ON a.MANV=b.MA_NVIEN
INNER JOIN dbo.DEAN c ON b.MADA=c.MADA
WHERE a.HONV=N'Đinh'
--j2Danh sách những đề án Có người trưởng phòng chủ trì đề án họ “Đinh”
SELECT DISTINCT c.* FROM dbo.NHANVIEN a
INNER JOIN dbo.PHANCONG b ON a.MANV=b.MA_NVIEN
INNER JOIN dbo.DEAN c ON b.MADA=c.MADA
WHERE a.HONV=N'Đinh' AND b.VITRI=N'Trưởng dự án'

--cac lenh truy vấn lồng
--k.k. Viết lại tất cả các câu trên thành các câu SELECT lồng.
--a.
SELECT * FROM dbo.NHANVIEN a
WHERE a.PHG = (
SELECT MAPH from dbo.PHONGBAN b 
WHERE b.TENPHG=N'Phòng triển khai')
--b.

SELECT a.HONV,a.TENLOT,a.TEN FROM dbo.NHANVIEN a
WHERE a.MANV = (
SELECT b.TRPHG from dbo.PHONGBAN b 
WHERE b.TENPHG=N'Phòng quản lý')
--c.

SELECT a.HONV,a.TENLOT,a.TEN FROM dbo.NHANVIEN a
WHERE a.MANV in (
SELECT DISTINCT TRPHG from dbo.PHONGBAN b
INNER JOIN dbo.PHANCONG c ON c.MA_NVIEN=b.TRPHG
INNER JOIN dbo.DEAN d ON c.MADA=d.MADA
WHERE d.DDIEM_DA=N'Hà Nội'
)

--d.

SELECT DISTINCT a.HONV,a.TENLOT,a.TEN  FROM dbo.NHANVIEN a
WHERE a.MANV IN (
	SELECT DISTINCT b.MA_NVIEN from dbo.THANNHAN b 
)	

--e.
SELECT DISTINCT a.HONV,a.TENLOT,a.TEN  FROM dbo.NHANVIEN a
WHERE a.MANV IN (
	SELECT DISTINCT b.MA_NVIEN from dbo.PHANCONG b 
)	

--f.
SELECT DISTINCT a.MANV FROM dbo.NHANVIEN a
WHERE a.MANV IN (
	SELECT DISTINCT b.MA_NVIEN from dbo.THANNHAN b 
)	AND a.MANV IN (
	SELECT DISTINCT b.MA_NVIEN from dbo.PHANCONG b 
)	

--g.
SELECT DISTINCT a.MADA FROM dbo.PHANCONG a
WHERE a.MA_NVIEN IN (
	SELECT DISTINCT b.MANV from dbo.NHANVIEN b
	WHERE b.HONV=N'Nguyễn'
)	

--h.

SELECT DISTINCT d.TENDA FROM dbo.PHANCONG a
INNER JOIN dbo.DEAN d ON d.MADA=a.MADA
WHERE a.MA_NVIEN IN (
	SELECT DISTINCT b.MANV from dbo.NHANVIEN b
	INNER JOIN dbo.PHONGBAN c ON b.MANV=c.TRPHG
	WHERE b.HONV=N'Nguyễn'
)	

--i.
SELECT  a.HONV,a.TENLOT,a.TEN ,b.TENPHG  FROM dbo.NHANVIEN a
INNER JOIN dbo.PHONGBAN b ON a.PHG=b.MAPH

--j.
--j1

SELECT DISTINCT a.MADA FROM dbo.PHANCONG a
WHERE a.MA_NVIEN IN (
	SELECT DISTINCT c.MA_NVIEN from dbo.NHANVIEN b
	INNER JOIN dbo.PHANCONG c ON b.MANV=c.MA_NVIEN
	WHERE b.HONV=N'Đinh'
)	

--j2

SELECT DISTINCT a.MADA FROM dbo.PHANCONG a
WHERE a.MA_NVIEN IN (
	SELECT DISTINCT c.MA_NVIEN from dbo.NHANVIEN b
	INNER JOIN dbo.PHANCONG c ON b.MANV=c.MA_NVIEN
	WHERE b.HONV=N'Đinh' AND c.VITRI=N'Trưởng dự án'
)	

--l. Cho biết những nhân viên có cùng tên với người thân

SELECT * FROM dbo.NHANVIEN a
WHERE ten IN (
	SELECT TENTN FROM dbo.THANNHAN
)
--m Cho biết danh sách những nhân viên có 2 thân nhân trở lên
SELECT * FROM dbo.NHANVIEN
WHERE MANV IN (
SELECT MA_NVIEN FROM dbo.THANNHAN
GROUP BY MA_NVIEN
HAVING COUNT(*)>1
)

--n Cho biết những trưởng phòng có tối thiểu 1 thân nhân
SELECT * FROM dbo.NHANVIEN a
WHERE MANV IN (
SELECT MA_NVIEN FROM dbo.THANNHAN
) AND MANV IN (
SELECT TRPHG FROM dbo.PHONGBAN
)
--o Cho biết những trưởng phòng có mức lương ít hơn (ít nhất một) nhân viên của mình
SELECT a.TRPHG,b.LUONG,a.MAPH FROM dbo.PHONGBAN a
INNER JOIN dbo.NHANVIEN b ON b.MANV=a.TRPHG
WHERE EXISTS(
	SELECT * FROM dbo.NHANVIEN c WHERE MANV NOT IN (SELECT DISTINCT TRPHG FROM dbo.PHONGBAN)
	AND a.MAPH=c.PHG AND b.LUONG<c.LUONG
)

--cac lenh ve gom nhom
--p Cho biết tên phòng, mức lương trung bình của phòng đó >40000.
SELECT b.TENPHG,AVG(a.LUONG) FROM dbo.NHANVIEN a
INNER JOIN dbo.PHONGBAN b ON a.PHG=b.MAPH

GROUP BY b.TENPHG
HAVING AVG(a.LUONG)>40000
--q Cho biết lương trung bình của tất các nhân viên nữ phòng số 4

SELECT AVG(LUONG) FROM dbo.NHANVIEN
WHERE PHAI=N'Nữ' AND PHG='4'
--r Cho biết họ tên và số thân nhân của nhân viên phòng số 5 có trên 2 thân nhân

SELECT a.MANV,COUNT(*) AS SoTN FROM dbo.NHANVIEN a
INNER JOIN dbo.THANNHAN b ON a.MANV=b.MA_NVIEN
WHERE a.PHG='5'
GROUP BY a.MANV
HAVING COUNT(*)>2
--s Ứng với mỗi phòng cho biết họ tên nhân viên có mức lương cao nhất

SELECT PHG,MAX(LUONG) FROM dbo.NHANVIEN
GROUP BY PHG

--t Cho biết họ tên nhân viên nam và số lượng các đề án mà nhân viên đó tham gia
SELECT a.MANV,COUNT(b.MADA) FROM dbo.NHANVIEN a
INNER JOIN dbo.PHANCONG b ON a.MANV=b.MA_NVIEN
 WHERE PHAI=N'Nam'
 GROUP BY a.MANV

 --u. Cho biết nhân viên (HONV, TENLOT, TENNV) nào có lương cao nhất.

 SELECT HONV,TENLOT,TEN FROM dbo.NHANVIEN WHERE LUONG =(
 SELECT MAX(LUONG) FROM dbo.NHANVIEN
 )
 --v. Cho biết mã nhân viên (MA_NVIEN) nào có nhiều thân nhân nhất.

 SELECT MA_NVIEN FROM dbo.THANNHAN 
 GROUP BY MA_NVIEN
 HAVING COUNT(*)=(
	  SELECT TOP 1 COUNT(*) FROM dbo.THANNHAN
	  GROUP BY MA_NVIEN
	  ORDER BY COUNT(*) DESC
  )
--w. Cho biết họ tên trưởng phòng của phòng có đông nhân viên nhất

SELECT b.HONV,b.TENLOT,b.TEN FROM dbo.PHONGBAN a
INNER JOIN dbo.NHANVIEN b ON a.TRPHG=b.MANV
WHERE a.MAPH IN (
SELECT TOP 1 PHG FROM dbo.NHANVIEN 
GROUP BY PHG
ORDER BY COUNT(*) desc
)

--x. Đếm số nhân viên nữ của từng phòng, hiển thị: TenPHG, SoNVNữ, những khoa không có nhân viên nữ hiển thị SoNVNữ=0

SELECT a.TENPHG,ISNULL(C1.SLNVNu,0) AS SLNVNu FROM dbo.PHONGBAN a
OUTER APPLY
(
	SELECT COUNT(*) AS SLNVNu FROM dbo.NHANVIEN WHERE PHG=a.MAPH
	AND PHAI=N'Nữ'
	GROUP BY PHG

)C1

--3. VIEW
--a.Cho biết tên phòng, số lượng nhân viên và mức lương trung bình của từng phòng.
CREATE VIEW vw_soluongnhanvien
AS
SELECT b.TENPHG,COUNT(*) AS SLNV,AVG(a.LUONG) AS LuongTB FROM dbo.NHANVIEN a
INNER JOIN dbo.PHONGBAN b ON a.PHG=b.MAPH
GROUP BY b.TENPHG 

--b.Cho biết họ tên nhân viên và số lượng các đề án mà nhân viên đó tham gia
CREATE VIEW vw_soluongdean
AS
SELECT a.HONV,a.TENLOT,a.TEN,COUNT(*) AS SLDeAN FROM dbo.NHANVIEN a
INNER JOIN dbo.PHANCONG b ON a.MANV=b.MA_NVIEN
GROUP BY a.HONV,a.TENLOT,a.TEN

--c. Thống kê số nhân viên của từng phòng, hiển thị: MaPH, TenPHG, SoNVNữ,SoNVNam, TongSoNV.
CREATE VIEW vw_thongkenhanvientungphong
AS
SELECT b.MAPH, b.TENPHG,SUM(CASE WHEN a.PHAI=N'Nữ' THEN 1 ELSE 0 end) AS SONVNu
,SUM(CASE WHEN a.PHAI=N'Nam' THEN 1 ELSE 0 end) AS SONVNam
,COUNT(a.MANV) AS TongSoNV
FROM dbo.NHANVIEN a
INNER JOIN dbo.PHONGBAN b ON a.PHG=b.MAPH
GROUP BY b.MAPH, b.TENPHG

--4 .TRANSACTION
--a. Xóa một nhân viên bất kỳ và xóa thông tin trưởng phòng của nhân viên này (không
--xóa phòng ban, chỉ xóa dữ liệu trưởng phòng và ngày nhận chức). Nếu bất kỳ hành động nào
--xảy ra lỗi thì hủy bỏ tất cả các hành động.

SET XACT_ABORT ON
BEGIN TRAN


	UPDATE a SET TRPHG=NULL,NG_NHANCHUC=NULL
	FROM PHONGBAN a
	INNER JOIN dbo.NHANVIEN b ON a.MAPH=b.PHG
	 WHERE b.MANV='888665555'
	 DELETE FROM dbo.NHANVIEN WHERE MANV='888665555'

COMMIT


--b. Xóa một phòng ban, xóa những địa điểm liên quan đến phòng ban, xóa thông tin
--phòng ban của nhân viên viên thuộc phòng ban này (không xóa nhân viên, chỉ xóa dữ liệu
--phòng trong nhân viên). Nếu bất kỳ hành động nào xảy ra lỗi thì hủy bỏ tất cả các hành động.
SET XACT_ABORT ON
BEGIN TRAN
	 
	 DELETE FROM dbo.PHONGBAN WHERE MAPH='4'
	 update  dbo.DIADIEM_PHG SET DIADIEM=NULL WHERE MAPHG='4'
	 update  dbo.NHANVIEN SET PHG=NULL WHERE PHG='4'
COMMIT


--5 PROCEDURE
--a. Tạo thủ tục hiển thị nhân viên (họ tên) tham gia nhiều dự án nhất trong năm 2013
CREATE PROC sp_hienthinhanvienthamgianhieuduan2013
AS
BEGIN
	DECLARE @MaxDeAn INT
	SELECT TOP 1 @MaxDeAn = COUNT(*) FROM dbo.NHANVIEN a
		INNER JOIN dbo.PHANCONG b ON a.MANV=b.MA_NVIEN
		INNER JOIN dbo.DEAN c ON c.MADA=b.MADA
		WHERE YEAR(c.NGAYBD)='2013'
		--YEAR(c.NGAYBD)=2013 AND YEAR(c.NGAYKT)=2013
		GROUP BY a.MANV
		ORDER BY COUNT(*) desc

	SELECT a.HONV,a.TENLOT,a.TEN FROM dbo.NHANVIEN a
	INNER JOIN dbo.PHANCONG b ON a.MANV=b.MA_NVIEN
	INNER JOIN dbo.DEAN c ON c.MADA=b.MADA
		WHERE YEAR(c.NGAYBD)='2013'
	GROUP BY a.HONV,a.TENLOT,a.TEN
	HAVING COUNT(*)=@MaxDeAn
END

--b. Tạo thủ tục hiển thị tên dự án, trưởng dự án và số nhân viên tham gia dự án đó.
CREATE PROC sp_hienthitenduan
AS
BEGIN

	SELECT c.TENDA,a.HONV,a.TENLOT,a.TEN ,C1.SONV FROM dbo.NHANVIEN a
	INNER JOIN dbo.PHANCONG b ON a.MANV=b.MA_NVIEN
	INNER JOIN dbo.DEAN c ON c.MADA=b.MADA
	OUTER APPLY
	(
		SELECT b1.MADA,COUNT(b1.MA_NVIEN) AS SONV FROM dbo.NHANVIEN a1
		INNER JOIN dbo.PHANCONG b1 ON a1.MANV=b1.MA_NVIEN 
		WHERE b1.VITRI<>N'Trưởng dự án' AND b1.MADA=b.MADA
			GROUP BY b1.MADA
	)C1
	WHERE b.VITRI=N'Trưởng dự án'
END

--c. Tạo thủ tục truyền vào mã dự án, hiển thị tất cả các nhân viên tham gia dự án đó.
CREATE PROC sp_hienthinhanvienthamgiaduantheomaduan
@MaDA nvarchar(50)
AS
BEGIN

	SELECT a.* FROM dbo.NHANVIEN a
	INNER JOIN dbo.PHANCONG b ON a.MANV=b.MA_NVIEN
	WHERE b.MADA=@MaDA
END

--d. Tạo thủ tục truyền vào mã phòng ban, hiển thị tên phòng ban, số lượng nhân viên và
--số lượng địa điểm của phòng ban đó.

CREATE PROC sp_hienthitenphongbantheomapb
@MaPH nvarchar(50)
AS
BEGIN
	SELECT a.TENPHG,c1.SLNV,c2.SLDD FROM dbo.PHONGBAN a
	OUTER APPLY
	(
		SELECT COUNT(*) AS SLNV FROM dbo.NHANVIEN b WHERE b.PHG=a.MAPH
		GROUP BY b.PHG
	)C1
	OUTER APPLY
	(
		SELECT COUNT(*) AS SLDD FROM dbo.DIADIEM_PHG b WHERE b.MAPHG=a.MAPH
		GROUP BY b.MAPHG
	)C2
	WHERE a.MAPH=@MaPH
END
--e.Tạo thủ tục truyền vào mã nhân viên (@manv) và vị trí (@vitri), hiển thị tên những
--dự án mà @manv tham gia với vị trí là @vitri.
CREATE PROC sp_hienthitenduantheovitrimanv
@manv nvarchar(50),@vitri nvarchar(50)
AS
BEGIN
	SELECT  b.TENDA FROM dbo.PHANCONG a
	INNER JOIN dbo.DEAN b ON b.MADA = a.MADA
	WHERE a.MA_NVIEN=@manv AND a.VITRI=@vitri
END

--f. Tạo thủ tục:o Tham số vào: @mapb  Tham số ra: @luongcaonhat, @tennhanvien: lương cao nhất của phòng ban đó và họ tên nhân viên đạt lương cao nhất đó.
create PROC sp_hienthiluongcaonhatcuapb
@mapb nvarchar(50),@luongcaonhat int OUTPUT,@tennhanvien nvarchar(50) OUTPUT
AS
BEGIN

	SELECT @luongcaonhat =MAX(LUONG)  FROM dbo.NHANVIEN
	WHERE PHG=@mapb

	SELECT  @tennhanvien= TEN
	FROM dbo.NHANVIEN WHERE PHG=@mapb AND
    LUONG = (SELECT MAX(LUONG)  FROM dbo.NHANVIEN
	WHERE PHG=@mapb)

END

----------
--Tạo thủ tục:
--o Tham số vào: @ngaybatdau, @ngayketthuc
--o Tham số ra: @soduan: số lượng dự án bắt đầu và kết thúc trong khoảng thời gian
--trên (có nghĩa sau bắt đầu sau @ ngaybatdau và kết thúc trước @ngayketthuc)
create PROC sp_hienthisoduan
@ngaybatdau nvarchar(50),@ngayketthuc nvarchar(50),@soduan int OUTPUt
AS
BEGIN

	SELECT @soduan=COUNT(*) FROM dbo.DEAN 

	WHERE NGAYBD>=@ngaybatdau AND NGAYKT<=@ngayketthuc

END

--h. Tạo thủ tục:
-- Tham số vào: @mada
-- Tham số ra: @sonu, @sonam: số nhân viên nữ và nhân viên nam tham gia dự án đó.
create PROC sp_hienthisonvnamnuthmagiaduan
@mada nvarchar(50),@sonu int OUTPUT,@sonam int OUTPUt
AS
BEGIN

	SELECT @sonu=SUM(CASE WHEN a.PHAI=N'Nữ' THEN 1 ELSE 0 end)
	,@sonam=SUM(CASE WHEN a.PHAI=N'Nam' THEN 1 ELSE 0 end)
	
	FROM dbo.NHANVIEN a
	INNER JOIN dbo.PHANCONG b ON a.MANV=b.MA_NVIEN
	WHERE b.MADA=@mada
	GROUP BY b.MADA

END

--i. Tạo thủ tục thêm mới một phòng ban với các tham số vào: @mapb, @tenpb, @trphg,
--@ngnhanchuc. Yêu cầu:
--o Kiểm tra @mapb có tồn tại không, nếu tồn tại rồi thì thông báo và kết thúc thủ tục.
--o Kiểm tra @tenpb có tồn tại không, nếu tồn tại rồi thì thông báo và kết thúc thủ tục.
--o Kiểm tra @trphg có phải là nhân viên không, nếu không phải là nhân viên thì thông
--báo và kết thúc thủ tục.
--o Nếu các điều kiện trên đều thỏa thì cho thêm mới phòng ban.
create PROC sp_themmoiphongban
@mapb nvarchar(50),@tenpb nvarchar(50),@trphg nvarchar(50),@ngnhanchuc datetime
AS
BEGIN
	IF EXISTS(SELECT * FROM dbo.PHONGBAN WHERE MAPH=@mapb)
	BEGIN
		PRINT N'mã PB đã tồn tại'
		RETURN;
	END
    IF EXISTS(SELECT * FROM dbo.PHONGBAN WHERE TENPHG=@tenpb)
	BEGIN
		PRINT N'Tên PB đã tồn tại'
		RETURN;
	END
	IF NOT EXISTS(SELECT * FROM dbo.NHANVIEN WHERE MANV=@trphg)
	BEGIN
		PRINT N'không phải là nhân viên'
		RETURN;
	END
	
	--insert pb
	INSERT INTO phongban VALUES(@mapb,@tenpb,@trphg,@ngnhanchuc)

END

--j. Tạo thủ tục cập nhật ngày kết thúc của một dự án với tham số vào là @mada và
--@ngayketthuc. Yêu cầu:
--o Kiểm tra @mada có tồn tại không, nếu không thì thông báo và kết thúc thủ tục.
--o Kiểm tra @ngayketthuc có sau ngày bắt đầu không, nếu không thì thông báo và kết
--thúc thủ tục
--o Nếu các điều kiện trên đều thỏa thì cho cập nhật ngày kết thúc.
create PROC sp_capnhatngayktduan
@mada nvarchar(50),@ngayketthuc datetime
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM dbo.DEAN WHERE MADA=@mada)
	BEGIN
		PRINT N'mã da không tồn tại'
		RETURN;
	END
    IF EXISTS(SELECT * FROM dbo.DEAN WHERE @ngayketthuc<NGAYBD)
	BEGIN
		PRINT N'ngày kt nho hon ngaybd'
		RETURN;
	END

	UPDATE dbo.DEAN SET NGAYKT=@ngayketthuc WHERE MADA=@mada

END

--k. Tạo thủ tục phân công nhân viên vào dự án mới. Các tham số vào là: @mada, @manv,
--@vitri. Yêu cầu:
--o @vitri chỉ nhận một trong 3 giá trị: “Trưởng dự án”, “Trưởng nhóm” và “Thành
--viên”. Nếu không thỏa điều kiện này thì thông báo và kết thúc thủ tục.
--o Nếu @vitri = “Trưởng dự án” thì kiểm tra dự án @duan đã có nhân viên làm “Trưởng
--dự án” chưa, nếu có rồi thì thông báo và kết thúc thủ tục.
--o Nếu các điều kiện trên đều thỏa thì cho thêm mới phân công.

create PROC sp_phancongnhanvienvaoduan
@mada nvarchar(50),@manv nvarchar(50),@vitri nvarchar(50)
AS
BEGIN
	IF (@vitri NOT IN (N'Trưởng dự án',N'Trưởng nhóm',N'Thành viên'))
	BEGIN
		PRINT N'sai'
		RETURN;
	END
    IF (@vitri=N'Trưởng dự án' AND EXISTS(SELECT * FROM dbo.PHANCONG WHERE mada=@mada AND VITRI=N'Trưởng dự án') )
	BEGIN

		PRINT N'đã có Trưởng dự án'
		RETURN;
	END

	INSERT INTO dbo.PHANCONG VALUES(@mada,@manv,@vitri)

END

--6. FUNCTION
--a. Viết hàm tính lương trung bình của một phòng ban bất kỳ

create function fn_luongtb(@mapb nvarchar(50))
	returns int
as
begin
		DECLARE @luongtb int
		SELECT @luongtb=AVG(LUONG) FROM dbo.NHANVIEN WHERE PHG=@mapb
		GROUP BY PHG
	
	RETURN @luongtb
end
GO

--b. Viết hàm xác định một nhân viên có tham gia dự án nào đó với chức vụ là “Trưởng dự án” hay không.

create function fn_nhanvienthamgiaduan(@manv nvarchar(50))
	returns bit
as
begin
		DECLARE @thamgia BIT
		SET @thamgia=0
        IF EXISTS(SELECT * FROM dbo.PHANCONG WHERE VITRI=N'Trưởng dự án' AND MA_NVIEN=@manv)
			BEGIN
				SET @thamgia=1
			END
	RETURN @thamgia
end
GO

--c. Viết hàm đếm số lượng đề án đã tham gia của một nhân viên bất kỳ trong một năm bất kỳ

create function fn_demsoluongdean(@manv nvarchar(50),@nam nvarchar(50))
	returns int
as
begin
		DECLARE @soluong int
		SELECT @soluong =COUNT(*) FROM dbo.PHANCONG a
		INNER JOIN dbo.DEAN b ON b.MADA = a.MADA
		WHERE MA_NVIEN=@manv AND YEAR(b.NGAYBD)=@nam

	RETURN @soluong
END

--d. Viết hàm xác định số tiền thưởng cuối năm 2013 của một nhân viên bất kỳ với tiêuchí:
--+ 20 triệu đồng: Nếu nhân viên có tham gia dự án bắt đầu trong năm 2013 với vị trí
--“Trưởng dự án”
--+ 15 triệu đồng: Nếu nhân viên có tham gia dự án bắt đầu trong năm 2013 với vị trí
--“Trưởng nhóm”
--+ 10 triệu đồng: Các trường hợp còn lại
--(Lưu ý: mỗi nhân viên chỉ hưởng một mức cao nhất)

create function fn_sotienthuong(@manv nvarchar(50))
	returns int
as
begin
		DECLARE @tienthuong INT
        IF EXISTS(SELECT * FROM dbo.PHANCONG WHERE MA_NVIEN=@manv AND VITRI=N'Trưởng dự án')
		BEGIN
			SET @tienthuong=2000000
		END
        else IF EXISTS(SELECT * FROM dbo.PHANCONG WHERE MA_NVIEN=@manv AND VITRI=N'Trưởng nhóm')
		BEGIN
			SET @tienthuong=1500000
		END
        ELSE
        BEGIN
			SET @tienthuong=1000000
		end

	RETURN @tienthuong
END

--7. CURSOR
--a. Công ty quyết định tăng lương cho nhân viên như sau:
--+ 20% nếu tham gia ít nhất 2 dự án với chức vụ trưởng dự án
--+ 15% nếu là trưởng phòng hoặc người quản lý trực tiếp
--+ 10% nếu là nhân viên phòng số 5 có tham gia dự án bắt đầu và kết thúc trong năm
--2014
--Dùng con trỏ duyệt qua từng dòng trong bảng NHANVIEN để thực hiện tăng lương
--như trên.

--Khai báo biến @manv để lưu nội dung đọc
DECLARE @manv int
DECLARE cursormanv CURSOR FOR  -- khai báo con trỏ cursormanv
SELECT MANV FROM dbo.NHANVIEN     -- dữ liệu trỏ tới

OPEN cursormanv                -- Mở con trỏ

FETCH NEXT FROM cursormanv     -- Đọc dòng đầu tiên
      INTO @manv
WHILE @@FETCH_STATUS = 0          --vòng lặp WHILE khi đọc Cursor thành công
BEGIN
                                  --In kết quả hoặc thực hiện bất kỳ truy vấn
	                            --nào dựa trên kết quả đọc được
	UPDATE a SET a.LUONG = a.LUONG+luong*20/100
	FROM dbo.NHANVIEN a
	WHERE MANV IN
	(
		SELECT  MA_NVIEN FROM dbo.PHANCONG  WHERE VITRI=N'Trưởng dự án' AND MA_NVIEN=@manv
		GROUP BY MA_NVIEN
		HAVING COUNT(*)>1
	)


	UPDATE a SET a.LUONG = a.LUONG+luong*15/100
	FROM dbo.NHANVIEN a
	WHERE MANV in
	(
		SELECT TRPHG  FROM dbo.PHONGBAN b WHERE b.TRPHG=@manv
	) 
	OR 
	MANV in
	(
			SELECT DISTINCT MA_NVIEN FROM dbo.PHANCONG  WHERE VITRI=N'Trưởng nhóm' AND MA_NVIEN=@manv
	)

	UPDATE a SET a.LUONG = a.LUONG+luong*10/100
	FROM dbo.NHANVIEN a
	INNER JOIN dbo.PHANCONG b ON a.MANV=b.MA_NVIEN
	INNER JOIN dbo.DEAN c ON b.MADA=c.MADA
	WHERE a.MANV=@manv AND a.PHG='5' AND YEAR(c.NGAYBD)='2014' AND YEAR(c.NGAYKT)='2014'

    FETCH NEXT FROM cursormanv -- Đọc dòng tiếp
          INTO @manv
END

CLOSE cursormanv              -- Đóng Cursor
DEALLOCATE cursormanv         -- Giải phóng tài nguyên


--b. Ứng với mỗi đề án, thêm mới 3 cột: số lượng trưởng dự án, số lượng trưởng nhóm,
--số lượng thành viên. Dùng con trỏ duyệt qua từng dòng trong bảng DEAN cập nhật dữ liệu
--cho 3 cột này.

--Khai báo biến @mada để lưu nội dung đọc
ALTER TABLE DEAN ADD SoLuongTruongDA INT
ALTER TABLE DEAN ADD SoLuongTruongNhom INT
ALTER TABLE DEAN ADD SoLuongTV INT

DECLARE @mada int
DECLARE cursormada CURSOR FOR  -- khai báo con trỏ @cursormada
SELECT MADA FROM dbo.DEAN     -- dữ liệu trỏ tới

OPEN cursormada                -- Mở con trỏ

FETCH NEXT FROM cursormada     -- Đọc dòng đầu tiên
      INTO @mada
WHILE @@FETCH_STATUS = 0          --vòng lặp WHILE khi đọc Cursor thành công
BEGIN
	               --In kết quả hoặc thực hiện bất kỳ truy vấn
	                            --nào dựa trên kết quả đọc được
	DECLARE @SoLuongTruongDA int     
	DECLARE @SoLuongTruongNhom int   
	DECLARE @SoLuongTV int   
	SELECT  @SoLuongTruongDA= SUM(CASE WHEN VITRI=N'Trưởng dự án' THEN 1 ELSE 0 end)
	 ,@SoLuongTruongNhom= SUM(CASE WHEN VITRI=N'Trưởng nhóm' THEN 1 ELSE 0 end)
	 ,@SoLuongTV= SUM(CASE WHEN VITRI=N'Thành viên' THEN 1 ELSE 0 end)
	 FROM dbo.PHANCONG a
	 WHERE a.MADA=@mada
	 GROUP BY a.MADA

	 UPDATE dbo.DEAN SET SoLuongTruongDA=@SoLuongTruongDA,SoLuongTruongNhom=@SoLuongTruongNhom,SoLuongTV=@SoLuongTV  where MADA=@mada

    FETCH NEXT FROM cursormada -- Đọc dòng tiếp
          INTO @mada
END

CLOSE cursormada              -- Đóng Cursor
DEALLOCATE cursormada         -- Giải phóng tài nguyên

--8. TRIGGER
--a. Tạo trigger cho ràng buộc: mỗi dự án có tối đa 10 nhân viên tham gia
CREATE TRIGGER [dbo].[triggerDEAN] ON [dbo].[DEAN]
FOR INSERT, UPDATE
AS
BEGIN

	IF EXISTS(SELECT * FROM dbo.inserted WHERE SoLuongTV>10)
	BEGIN
		raiserror(N'Số lượng tv <10',16,1)
		rollback tran
		return
	end

END
--b. Tạo trigger cho ràng buộc: Với mỗi dự án, số lượng “trưởng dự án” phải ít hơn số
--lượng “trưởng nhóm” và số lượng “trưởng nhóm” phải ít hơn số lượng “thành viên”


CREATE TRIGGER [dbo].[triggerSoLuongDEAN] ON [dbo].[DEAN]
FOR INSERT, UPDATE
AS
BEGIN
	SELECT * INTO #tempda FROM inserted 
	WHERE SoLuongTruongDA>SoLuongTruongNhom
	or SoLuongTruongNhom>SoLuongTV

	IF EXISTS(SELECT * FROM #tempda )
	BEGIN
		raiserror(N'số lượng trưởng dự án phải ít hơn số lượng trưởng nhóm và số lượng trưởng nhóm phải ít hơn số lượng thành viên',16,1)
		rollback tran
		return
	end

END
--c. Tạo trigger cho hành động Insert ngăn cấm việc chèn dữ liệu vào bảng PHANCONG
--với những đề án đã kết thúc

CREATE TRIGGER [dbo].[triggerthemdulieuPHANCONG] ON [dbo].[PHANCONG]
FOR INSERT
AS
BEGIN
	IF EXISTS(SELECT * FROM inserted a
	INNER JOIN dbo.DEAN b ON a.MADA=b.MADA
	WHERE GETDATE()>b.NGAYKT
	)
	BEGIN
		RAISERROR(N' đề án đã kết thúc',16,1)
		ROLLBACK TRAN
		RETURN
	END

END

--d. Tạo trigger cho hành động Update ngăn cấm việc thay đổi thông tin của bảng
--PHANCONG với những đề án đã kết thúc.


CREATE TRIGGER [dbo].[triggercapnhatHANCONG] ON [dbo].[PHANCONG]
FOR UPDATE
AS
BEGIN
	IF EXISTS(SELECT * FROM inserted a
	INNER JOIN dbo.DEAN b ON a.MADA=b.MADA
	WHERE GETDATE()>b.NGAYKT
	)
	BEGIN
		RAISERROR(N' đề án đã kết thúc',16,1)
		ROLLBACK TRAN
		RETURN
	END

END

--e. Tạo trigger cho hành động Delete ngăn cấm việc xóa dữ liệu trong PHANCONG của
--những dự án đã kết thúc.
CREATE TRIGGER [dbo].[triggerXoadulieuPHANCONG] ON [dbo].[PHANCONG]
FOR Delete
AS
BEGIN
	IF EXISTS(SELECT * FROM Deleted a
	INNER JOIN dbo.DEAN b ON a.MADA=b.MADA
	WHERE GETDATE()>b.NGAYKT
	)
	BEGIN
		RAISERROR(N' đề án đã kết thúc',16,1)
		ROLLBACK TRAN
		RETURN
	END

END

--f. Tạo trigger cho hành động Insert ngăn cấm việc phân công một nhân viên vào dự án
--mới nếu nhân viên đó đang tham gia một dự án chưa kết thúc
CREATE TRIGGER [dbo].[triggerphancongnhanvien] ON [dbo].[PHANCONG]
FOR INSERT
AS
BEGIN
	IF EXISTS(SELECT * FROM inserted a
	WHERE MA_NVIEN IN( SELECT DISTINCT MA_NVIEN FROM dbo.PHANCONG a1
						INNER JOIN dbo.DEAN b ON a.MADA=b.MADA
						WHERE GETDATE()<b.NGAYKT
					)
	)
	BEGIN
		RAISERROR(N'nhân viên đang tham gia một dự án chưa kết thúc',16,1)
		ROLLBACK TRAN
		RETURN
	END

END