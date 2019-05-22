EXEC sp_configure filestream_access_level, 2
RECONFIGURE

create database Nanjing;
use Nanjing;

alter database Nanjing add filegroup FileStreamGroup1 contains filestream
alter database Nanjing add file (
	name = FSGroup1File, 
	filename = 'F:\Hannika\Univer\Semestr_6\CP_DB\CP_Nanjing\DB\file group') to filegroup FileStreamGroup1

--роли бд
create table Roles
(
	Id int primary key identity(1,1) not null,
	Name nvarchar(max) not null,
	Login nvarchar(max) not null,
	Password nvarchar(25) not null
);

--роли приложения
create table UserRoles
(
	Id int primary key identity(1,1) not null,
	Name nvarchar(max) not null,
	IdUserRoles int foreign key references Roles(Id)
);

--пользователи
create table Users
(
	Id int primary key identity(1,1) not null,
	FName nvarchar(max) not null,
	SName nvarchar(max) not null,
	[Login] nvarchar(25) not null,
	Email nvarchar(max) not null,
	[Address] nvarchar(max) not null,
	Birthday date not null,
	[Password] nvarchar(25) not null,
	Phone nvarchar(12) not null,
	IdRole int foreign key references UserRoles(Id)	
);

create table Genre
(
	Id int primary key identity(1,1) not null,
	Name nvarchar(max) not null
);


create table ItemsGenres
(
	Id int primary key identity(1,1) not null,
	IdItems int foreign key references Items(Id),
	IdGenre int foreign key references Genre(Id) 
);
 
 
 --General description items
create table Items
(
	Id int primary key identity(1,1) not null,
	Name nvarchar(max) not null,
	Author nvarchar(max) not null,
	Description nvarchar(max) not null,
	IdDataLogo int foreign key references DataNanjing(Id)
);


create table Publisher 
(
	Id int primary key identity(1,1) not null,
	Name nvarchar(max) not null,
	Description nvarchar(max) not null,
);

use Nanjing

--Description of order
create table Orders
(
	Id int primary key identity(1,1) not null,
	Date date not null,
	Payment nvarchar(max) default('cash'),
	isApproved bit not null default 0,
	IdUser int foreign key references Users(Id)
);


--Quantity of items oredered
create table QuantityOrderItems 
(
	Id int primary key identity(1,1) not null,
	Quantity int not null default(1),
	Price float not null,
	IdItems int foreign key references Items(Id),
	IdOrder int foreign key references Orders(Id)
);

alter table QuantityOrderItems ADD IdDataItem int
alter table QuantityOrderItems alter column TypeItem nvarchar(max) 

--History orderds
create table OrdersHistory
(
	Id int primary key identity(1,1) not null,
	Date date not null,
	IdOrder int foreign key references Orders(Id)	
);

--Description of book
create table Book
(
	Id int primary key identity(1,1) not null,
	IdItems int foreign key references Items(Id),
	Price float,
	PublishDate int,
	Publisher int foreign key references Publisher(Id),
	IdDataBook int foreign key references DataNanjing(Id)
);

alter table Book ALTER COLUMN PublishDate int
alter table Book ALTER COLUMN IdItems int null
alter table Book ALTER COLUMN Price float null 
alter table Book ALTER COLUMN PublishDate date null
--Description movie
create table Movie
(
	Id int primary key identity(1,1) not null,	
	Duration time(7),
	Country nvarchar(max),
	Producer nvarchar(max),
	Price float,
	PublishYear int,
	IdItems int foreign key references Items(Id),
	IdDataMovie int foreign key references DataNanjing(Id)
);



--Description audio
create table Audio
(
	Id int primary key identity(1,1) not null ,	
	Duration time(7),	
	Reader nvarchar(max),
	Price float,
	Translater nvarchar(max),		
	Publisher int foreign key references Publisher(Id),
	IdItems int foreign key references Items(Id),
	IdDataAudio int foreign key references DataNanjing(Id)
);


alter table Movie ALTER COLUMN duration time(7) null
alter table Movie ALTER COLUMN Country nvarchar(max) null
alter table Movie ALTER COLUMN Producer nvarchar(max) null
alter table Movie ALTER COLUMN Price float null

--Files data of Nanjing
create table DataNanjing
(
	Id int primary key identity(1,1), 	
	DocGUID UNIQUEIDENTIFIER NOT NULL ROWGUIDCOL UNIQUE DEFAULT NEWID (),
	Name nvarchar(260) not null,
	Data varbinary(max) FILESTREAM not null,
	[Type] nvarchar(8) check ([type] in ('text','audio','video','picture','file')) default 'file'
);

--Alternative full variant data table 

--create table NangingFilesData as FILETABLE with 
--(
--	FILETABLE_DIRECTORY = 'NangingFileTable'
--);



drop table Items;

drop table OrdersHistory;
drop table QuantityOrderItems;
drop table Orders;
drop table Movie;
drop table Audio;
drop table Publisher;
drop table Book;

drop table Roles;
drop table Users;
drop table Genre;
drop table DataNanjing;

drop database Nanjing;