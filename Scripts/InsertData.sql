use Nanjing

delete from  Users


--reaet counter id in table
DBCC CHECKIDENT ('Users', RESEED, 0)

select * from Users
select * from Roles
select * from Items
select * from DataNanjing
select * from Genre

SELECT GETDATE() 

insert into Roles(Name, Login, Password)
	values('admin', 'admin_Nanjing', 'admin'),		  
		  ('manager', 'manager_Nanjing', 'manager'),
		  ('default', 'default_Nanjing', 'default'),
		  ('user', 'user_Nanjing', 'user');

insert into Users(FName, SName, Login, Email, Address, Birthday, Password, Phone, IdRole)
	values('Hanna', 'Bulava', 'hannika', 'hannanice94@gmail.com', 'st. Belarussian 19', '14-08-1998', '123QWEasd', '375292414148', '1'),
		  ('Andrei', 'Chaeuvskii', 'andrei', 'andrei_chaevskii@bk.ru', 'st. Belarussian 19', '08-12-1998', 'asdQWE123', '375336345353', '2')
	
		  
insert into Genre(Name)
	values	(N'Художественная литература'),
			(N'Детектив'),
			(N'Медицина'),
			(N'Кулинария и напитки'),
			(N'Исторический роман'),
			(N'Медицина'),
			(N'Классическая литература'),
			(N'Любовный роман'),
			(N'Поэзия '),
			(N'Фантастика, фэнтези'),
			(N'Военное дело'),
			(N'Детская литература'),
			(N'Искусство. Культура'),
			(N'Биографии и мемуары'),
			(N'Комиксы. Манга');
		  
insert into Items(Name, Author, Description, Genre, IdData)
	values (N'Мятная сказка',
			N'Александр Полярный', 
			N'События книги разворачиваются вокруг мальчика, которого отдали в приют. Он быстро понимает, что справедливости в мире нет. В этой сказке будет несколько мятных капучино, много снега и пара разбитых сердец.', N'1', N'1');



