use charity
go
create table thongtin_nguoidung(
	id int identity(1,1) not null,
	username varchar(50) not null,
	pass varchar(30) not null,
	ho_ten varchar(50) not null,
	tuoi int,
	dia_chi varchar(100),
	dien_thoai varchar(10)
)
go
create table thongtin_quyengop(
	id int identity(1,1) not null,
	ngaybatdau date not null,
	ngayketthuc date not null,
	tong_tien int default 0
)
go
create table nguoidung_quyengop(
id_nguoidung int not null,
sotien_quyengop int not null,
dot_quyengop int not null,
stt varchar(200)
)

go

insert thongtin_nguoidung values('s@gmail.com','12345678','s', 25, 'myhoahung', '0367868698'),('f@gmail.com','12345678','f', 25, 'myhoahung', '0367868698'),('g@gmail.com','12345678','g', 25, 'myhoahung', '0367868698'),('maivanvi@gmail.com','12345678','maivanvi', 25, 'myhoahung', '0367868698'),('maivandai@gmail.com','12345678','maivandai', 28, 'myhoahung', '020300440'),('maithanhnhan@gmail.com','12345678','maithanhnhan', 30, 'myhoahung', '032434343'),('a@gmail.com','12345678','a', 25, 'myhoahung', '0367868698'),('b@gmail.com','12345678','b', 25, 'myhoahung', '0367868698'),('c@gmail.com','12345678','c', 25, 'myhoahung', '0367868698'),('d@gmail.com','12345678','d', 25, 'myhoahung', '0367868698'),('e@gmail.com','12345678','e', 25, 'myhoahung', '0367868698'),('f@gmail.com','12345678','f', 25, 'myhoahung', '0367868698'),('i@gmail.com','12345678','i', 25, 'myhoahung', '0367868698'),('k@gmail.com','12345678','k', 25, 'myhoahung', '0367868698'),('l@gmail.com','12345678','l', 25, 'myhoahung', '0367868698')
insert thongtin_quyengop (ngaybatdau, ngayketthuc) values('2022-1-1','2022-4-1'),('2022-5-1','2022-8-1'),('2022-9-1','2022-12-1'),('2022-1-1','2022-4-1'),('2022-1-1','2022-4-1'),('2022-1-1','2022-4-1'),('2022-1-1','2022-4-1'),('2022-1-1','2022-4-1'),('2022-1-1','2022-4-1'),('2022-1-1','2022-4-1'),('2022-1-1','2022-4-1'),('2022-1-1','2022-4-1'),('2022-1-1','2022-4-1'),('2022-1-1','2022-4-1'),('2022-1-1','2022-4-1')
insert nguoidung_quyengop values(1,300000,4, 'stt'),(2,300000,4, 'stt'),(5,300000,4, 'stt'),(15,300000,5, 'stt'),(6,300000,6, 'stt'),(4,300000,2, 'stt'),(7,300000,5, 'stt'),(8,300000,6, 'stt'),(15,300000,2, 'stt'),(2,300000,3, 'stt'),(3,200000,1,'stt'),(11,300000,1,'stt'),(12,300000,3,'stt'),(13,300000,3,'stt'),(14,300000,3,'stt')

select * from thongtin_nguoidung a, thongtin_quyengop b, nguoidung_quyengop c where a.id = c.id_nguoidung and b.id = c.dot_quyengop
select * from thongtin_quyengop
select * from nguoidung_quyengop

alter table thongtin_nguoidung
add constraint PK_ttnguoi_dung primary key(id)

alter table thongtin_quyengop
add constraint PK_ttquyen_gop primary key(id)

alter table nguoidung_quyengop
add constraint PK_nguoidung_quyengop primary key(id_nguoidung, dot_quyengop)

alter table nguoidung_quyengop
add constraint FK_nguoidung_quyengop_ttnguoidung foreign key(id_nguoidung) references thongtin_nguoidung(id)

alter table nguoidung_quyengop
add constraint FK_nguoidung_quyengop_ttquyengop foreign key(dot_quyengop) references thongtin_quyengop(id)

create trigger tongtien_quyengop on nguoidung_quyengop for insert as
begin
	begin
		update thongtin_quyengop
		set tong_tien = tong_tien + (select sum(sotien_quyengop) from inserted where inserted.dot_quyengop = thongtin_quyengop.id group by dot_quyengop) from inserted, thongtin_quyengop where inserted.dot_quyengop = thongtin_quyengop.id
	end
end

