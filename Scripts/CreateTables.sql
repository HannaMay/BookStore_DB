EXEC sp_configure filestream_access_level, 2
RECONFIGURE

create database Nanjing;
use Nanjing;

alter database Nanjing add filegroup FileStreamGroup1 contains filestream
alter database Nanjing add file (
	name = FSGroup1File, 
	filename = 'F:\Hannika\Univer\Semestr_6\CP_DB\CP_Nanling\DB\file group') to filegroup FileStreamGroup1

create table Roles
(
	Id int primary key identity(1,1) not null,
	Name nvarchar(max) not null,
	Login nvarchar(max) not null,
	Password nvarchar(25) not null
);

create table Users
(
	Id int primary key identity(1,1) not null,
	FName nvarchar(max) not null,
	SName nvarchar(max) not null,
	Login nvarchar(25) not null,
	Email nvarchar(max) not null,
	Address nvarchar(max) not null,
	Birthday date not null,
	Password nvarchar(25) not null,
	Phone nvarchar(12) not null,
	IdRole int foreign key references Roles(Id) not null	
);

create table Genre
(
	Id int primary key identity(1,1) not null,
	Name nvarchar(max) not null
);
 
create table Publisher 
(
	Id int primary key identity(1,1) not null,
	Name nvarchar(max) not null,
	Decsription nvarchar(max) not null,
);


--General description items
create table Items
(
	Id int primary key identity(1,1) not null,
	Name nvarchar(max) not null,
	Author nvarchar(max) not null,
	Description nvarchar(max) not null,
	Genre int foreign key references Genre (Id) not null,
	IdData int foreign key references DataNanjing(Id) not null
);


--Description of book
create table Book
(
	Id int primary key identity(1,1) not null,
	IdItem int foreign key references Items(Id) not null,
	IsSoftCover bit not null,
	IsHardCover bit not null,
	Price float not null,
	PublishDate date not null,
	Publisher int foreign key references Publisher(Id) not null
);

--Description of order
create table Orders
(
	Id int primary key identity(1,1) not null,
	Date date not null,
	Payment nvarchar(max) not null,
	IdUser int foreign key references Users(Id) not null,
	QuantityOrderItems int foreign key references QuantityOrderItems(Id) not null	
);

--Quantity of items oredered
create table QuantityOrderItems 
(
	Id int primary key identity(1,1) not null,
	Quantity int not null,
	Price float not null,
	IdItems int foreign key references Items(Id)
);

--History orderds
create table OrdersHistory
(
	Id int primary key identity(1,1) not null,
	Date date not null,
	IdItems int foreign key references Items(Id) not null,
	IdUser int foreign key references Users(Id) not null	
);


--Description movie
create table Movie
(
	Id int primary key identity(1,1) not null,	
	Duration time(7) not null,
	Country nvarchar(max) not null,
	Producer nvarchar(max) not null,
	PubliserYear date,
	IdItems int foreign key references Items(Id) not null
);

--Description audio
create table Audio
(
	Id int primary key identity(1,1) not null ,	
	Duration time(7) not null,	
	Reader nvarchar(max) not null,
	Translater nvarchar(max),	
	IdItems int foreign key references Items(Id) not null,
	Publiser int foreign key references Publisher(Id) not null	
);

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



drop table Item;
drop table Orders;
drop table OrdersHistory;
drop table Movie;
drop table Audio;
drop table Publisher;
drop table Book;
drop table QuantityOrderItems;
drop table Roles;
drop table Users;
drop table Genre;

drop database Nanjing;