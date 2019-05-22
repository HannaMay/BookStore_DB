use [Nanjing]

-- Add Item
go 
create procedure AddItem
	@Name nvarchar(max),
	@Author nvarchar(max),
	@Desc nvarchar(max)
as
begin
	begin try
		declare @countBefore int,
			@countAfter int,
			@result int
		set @countBefore = (select count(*) from Items)
		insert into [Items] ([Name], [Author], [Description])
			   values (@Name, @Author, @Desc)
		set @countAfter = (select count(*) from Items)
		set @result = @countAfter - @countBefore
		select @result as result
	end try
	begin catch
		select -1 as result
	end catch
end

-- Get Data from Item

go
alter procedure GetAllItem
as
begin
	select i.Id, 
		   i.[Name], 
		   i.Author, 
		   i.[Description],
		   d.[Data]
	from Items i
	join DataNanjing d on d.Id = i.IdDataLogo
	order by i.[Name] asc
end

go
create procedure GetItemById
	@Id int
as
begin
	select i.Id, 
		   i.[Name], 
		   i.Author, 
		   i.[Description],
		   d.[Data]
	from Items i
	join DataNanjing d on d.Id = i.IdDataLogo
	where i.Id = @Id
end

go
create procedure GetItemByName
	@Name nvarchar(max)
as
begin
	select i.Id, 
		   i.[Name], 
		   i.Author, 
		   i.[Description],
		   d.[Data]
	from Items i
	join DataNanjing d on d.Id = i.IdDataLogo
	where i.[Name] = @Name
end

-- Add Audio 
go 
alter procedure AddAudio
	@duration time(7), 
	@reader nvarchar(max), 
	@price float, 
	@translater nvarchar(max), 
	@Publisher int
as
begin
	begin try
		declare @countBefore int,
			@countAfter int,
			@result int
		set @countBefore = (select count(*) from Audio)
		insert into [Audio] (duration, reader, price, translater, Publisher)
		values (@duration, @reader, @price, @translater, @Publisher)
		set @countAfter = (select count(*) from Audio)
		set @result = @countAfter - @countBefore
		select @result as result
	end try
	begin catch
		select -1 as result
	end catch
end

-- Get Data from Audio
go
alter procedure GetAllAudio
as
begin
	select i.Id, 
		   i.[Name], 
		   i.Author, 
		   i.[Description],	
		   a.Duration, 
		   a.Price, 
		   a.Publisher, 
		   a.Reader, 
		   a.Translater, 
		   d.[Data]
	from Audio a 
	join Items i on i.Id = a.IdItems
	join DataNanjing d on d.[Name] = i.[Name]	
	where d.[Type]='picture'
	order by i.[Name] desc
end


go
alter procedure GetAudioById
	@Id int
as
begin
	select i.Id, 
		   i.[Name], 
		   i.Author, 
		   i.[Description],	
		   a.Duration, 
		   a.Price, 
		   a.Publisher, 
		   a.Reader, 
		   a.Translater, 
		   d.[Data]
	from Audio a 
	join Items i on i.Id = a.IdItems
	join DataNanjing d on i.[Name] = d.[Name]
	where d.[Type]='picture' and a.Id = @Id
end

go
alter procedure GetAudioByName
	@Name nvarchar(max)
as
begin
	select i.Id, 
		   i.[Name], 
		   i.Author, 
		   i.[Description],	
		   a.Duration, 
		   a.Price, 
		   a.Publisher, 
		   a.Reader, 
		   a.Translater, 
		   d.[Data]
	from Audio a 
	join Items i on i.Id = a.IdItems
	join DataNanjing d on i.[Name] = d.[Name]
	where d.[Type]='picture' and i.[Name] = @Name
end


-- Add Book 
go 
alter procedure AddBook
	 @price float, 
	 @publishdate date, 
	 @publisher int
as
begin
	begin try
		declare @countBefore int,
			@countAfter int,
			@result int
		set @countBefore = (select count(*) from Book)
		insert into [book] ([Price], [PublishDate], [Publisher])
		values (@price, @publishdate, @Publisher)
		set @countAfter = (select count(*) from Book)
		set @result = @countAfter - @countBefore
		select @result as result
	end try
	begin catch
		select -1 as result
	end catch
end

select * from Book
delete from Book where id = 5
execute AddBook 6.7, '2016', 6 

-- Get Data from Book
go
alter procedure GetAllBook
as
begin
	select i.Id, 
		   i.[Name], 
		   i.Author, 
		   i.[Description],	
		   b.Price, 
		   b.Publisher, 
		   b.PublishDate, 
		   d.[Data]
	from Book b 
	join Items i on i.Id = b.IdItems
	join DataNanjing d on d.[Name] = i.[Name]	
	where d.[Type]='picture'
	order by i.[Name] desc
end

go
alter procedure GetBookById
	@Id int
as
begin
	select i.Id, 
		   i.[Name], 
		   i.Author, 
		   i.[Description],	
		   b.Price, 
		   b.Publisher, 
		   b.PublishDate, 
		   d.[Data]
	from Book b 
	join Items i on i.Id = b.IdItems
	join DataNanjing d on i.[Name] = d.[Name]
	where d.[Type]='picture' and b.Id = @Id
end

go
alter procedure GetBookByName
	@Name nvarchar(max)
as
begin
	select i.Id, 
		   i.[Name], 
		   i.Author, 
		   i.[Description],	
		   b.Price, 
		   b.Publisher, 
		   b.PublishDate, 
		   d.[Data]
	from Book b 
	join Items i on i.Id = b.IdItems
	join DataNanjing d on i.[Name] = d.[Name]
	where d.[Type]='picture' and i.[Name] = @Name
end

-- Add Movie
go 
alter procedure AddMovie
	 @duration time(7), 
	 @country nvarchar(max), 
	 @producer nvarchar(max), 
	 @price float, 
	 @PublishYear int
as
begin
	begin try
		declare @countBefore int,
			@countAfter int,
			@result int
		set @countBefore = (select count(*) from Movie)
		insert into [Movie] ([duration], [country], [producer], [price], [PublishYear])
		values ( @duration, @country, @producer, @price, @PublishYear)
		set @countAfter = (select count(*) from Movie)
		set @result = @countAfter - @countBefore
		select @result as result
	end try
	begin catch
		select -1 as result
	end catch
end

-- Get Data from Movie

go
alter procedure GetAllMovie
as
begin
	select i.Id, 
		   i.[Name], 
		   i.Author, 
		   i.[Description],	
		   m.[duration], 
		   m.[country], 
		   m.[producer],
		   m.[price], 
		   m.[PublishYear], 
		   d.[Data] as Picture
	from Movie m  
	join Items i on i.Id = m.IdItems
	join DataNanjing d on i.[Name] = d.[Name]
	where d.[Type]='picture'
end

go
alter procedure GetMovieById
	@Id int
as
begin
	select i.Id, 
		   i.[Name], 
		   i.Author, 
		   i.[Description],	
		   m.[duration], 
		   m.[country], 
		   m.[producer],
		   m.[price], 
		   m.[PublishYear], 
		   d.[Data]
	from Movie m 
	join Items i on i.Id = m.IdItems
	join DataNanjing d on i.[Name] = d.[Name]
	where d.[Type]='picture' and m.Id = @Id
end

go
alter procedure GetMovieByName
	@Name nvarchar(max)
as
begin
	select i.Id, 
		   i.[Name], 
		   i.Author, 
		   i.[Description],	
		   m.[duration], 
		   m.[country], 
		   m.[producer],
		   m.[price], 
		   m.[PublishYear], 
		   d.[Data]
	from Movie m 
	join Items i on i.Id = m.IdItems
	join DataNanjing d on i.[Name] = d.[Name]
	where d.[Type]='picture' and i.[Name] = @Name
end

--Update Item
go
create procedure UpdateItems
	@Id int,
	@Name nvarchar(max),
	@Author nvarchar(max),
	@Desc nvarchar(max),
	@IdDataLogo int
as
begin
	if exists (select count(1) from Items where Id = @Id)
	begin 
		update Items set Items.[Name] = @Name, 
						 Items.Author = @Author, 
						 Items.[Description] = @Desc, 
						 Items.IdDataLogo = @IdDataLogo
						 where Items.Id = @Id
	end
	else
		ROLLBACK TRANSACTION
		print '������ ���������� � ������� Items (proc UpdateItems)'
end

--Update Audio
go
alter procedure UpdateAudio
	@id int,
	@duration time(7), 
	@reader nvarchar(max), 
	@price float, 
	@translater nvarchar(max), 
	@Publisher int
as
begin
	if exists (select count(1) from Audio, Items where Audio.Id = @Id and Audio.IdItems = Items.Id)
	begin 
		update Audio set Audio.Duration = @duration,
						 Audio.Reader = @reader,
						 Audio.Price = @price,
						 Audio.Translater = @translater,
						 Audio.Publisher = @Publisher
						 where Audio.Id = @Id
	end
	else
		begin
			ROLLBACK TRANSACTION
			print '������ ���������� � ������� Audio (proc UpdateAudio)'
		end
end

select * from Audio
execute UpdateAudio 3, '11:17:09', '������� ���������', 8.26, '������', 6
--Update Book
go
alter procedure UpdateBook
	@id int,
	@price float, 
	@publishdate date, 
	@publisher int
as
begin
	if exists (select count(1) from Book, Items where Book.Id = @Id and Book.IdItems = Items.Id)
	begin 
		update Book set Book.Price = @price,
						Book.PublishDate = @publishdate,
						Book.Publisher = @publisher
						where Book.Id = @Id
	end
	else
		begin
			ROLLBACK TRANSACTION
			print '������ ���������� � ������� Book (proc UpdateBook)'
		end
end

execute UpdateBook 4, 6.7, '2016', 6 

--Update Movie
go
alter procedure UpdateMovie
	@id int,
	@duration time(7), 
	@country nvarchar(max), 
	@producer nvarchar(max), 
	@price float, 
    @PublishYear int
as
begin
	if exists (select count(1) from Movie, Items where Movie.Id = @id and Movie.IdItems = Items.Id)
		begin 
			update Movie set Movie.Duration = @duration,
							 Movie.Price = @price,
							 Movie.Country = @country,
							 Movie.Producer = @producer,
							 Movie.PublishYear = @PublishYear
							 where Movie.Id = @Id
		end
	else
		begin
			ROLLBACK TRANSACTION
			print '������ ���������� � ������� Movie (proc UpdateMovie)'
		end
end

execute UpdateMovie 2, '2:32:00', '��������������', '���� ��������', 26, 2001


--Delete Item
go
create procedure DeleteItem
	@Id int
as
begin
	if exists (select count(1) from Items where Id = @Id)
	begin 
		delete from Audio where Audio.Id = @Id;
		delete from Book  where Book.Id = @Id;
		delete from Movie where Movie.Id = @Id;
		delete from Items where Items.Id = @Id;
	end
	else
		ROLLBACK TRANSACTION
		print '������ �������� � ������� Items (proc DeleteItem)'
end

--Delete Audio
go
create procedure DeleteAudio
	@Id int
as
begin
	if exists (select count(1) from Audio where Id = @Id)
	begin 
		delete from Audio where Audio.Id = @Id
	end
	else
		ROLLBACK TRANSACTION
		print '������ �������� � ������� Audio (proc DeleteAudio)'
end

--Delete Book
go
create procedure DeleteBook
	@Id int
as
begin
	if exists (select count(1) from Book where Id = @Id)
	begin 
		delete from Book where Book.Id = @Id
	end
	else
		ROLLBACK TRANSACTION
		print '������ �������� � ������� Book (proc DeleteBook)'
end

--Delete Movie
go
create procedure DeleteMovie
	@Id int
as
begin
	if exists (select count(1) from Movie where Id = @Id)
	begin 
		delete from Movie where Movie.Id = @Id
	end
	else
		ROLLBACK TRANSACTION
		print '������ �������� � ������� Movie (proc DeleteMovie)'
end

go
alter procedure AddData
	@name nvarchar(260),
	@url nvarchar(max),
	@type nvarchar(8)
as 
begin
	if exists(select i.[Name] from Items i where i.[Name]=@name)
		begin
			insert into DataNanjing	([Name], [Data], [Type])
				values (@name,  CONVERT(varbinary(max), @url), @type)
			print '���� ��������!'	
		end
	else
		begin
			print '������ ���������� �����'
		end
end

go 
create procedure GetData
as
begin
	select * from DataNanjing
end



execute AddItem '����������� �������', '��. K. �������', '�� �����, ��� ������� �����... ��� �������� �������, ����� � ������. � ����� ����� �������� � ���������� ���������, �� �� ������, ��� � ������� ����� �������� �������, - � ������ ������� ������� �������� ��� � ���� �������� ��������� ��������� �������, ����� ��������������� ����� ������ ������������� �����������.'

declare @nameitem nvarchar(260)
set @nameitem = '����������� �������'
execute AddData @nameitem, 'F:\Hannika\Univer\Semestr_6\CP_DB\CP_Nanjing\Data\����������� �������.jpg', 'picture'

execute GetData
execute GetAllItem
execute GetAllBook
execute GetAllMovie
execute GetAllAudio

execute GetItemById 2
execute GetAudioById 1
execute GetMovieById 1
execute GetBookById 2

execute GetAudioByName '������� ������ �������������'
execute GetMovieByName '������� ������ �������������'
execute GetItemByName '������� ������ �������������'
execute GetBookByName '������� ������ �������������'

execute DeleteAudio 2
execute DeleteMovie 1
execute DeleteBook 2
execute DeleteItem 2

execute UpdateAudio 3, '11:17:09', '������� ���������', 8.26, '������', 6
execute UpdateMovie 2, '2:32:00', '��������������', '���� ��������', 26, 2001
execute UpdateBook 2, 32.2, '2016', 3 
execute UpdateItems 1, '������� ������ �������������', '������ �����', '� 2045 ���� �������� ��� � �� ����� �������� �����. ��-���������� ����� ���� ����� ��������� ���� ���� � OASIS� � �������� ����������� ������������, ��� �������� ���� ��� ������� ����� ������������. ����� ������� ������������� ��������� OASIS�, ��������� ��-��������� ������� ���, ���������� �� �� ������ ��� ���������� �����������. ���, ��� ��������� �� ������, ���������� ��� �������� ��������� � � �������� ��� ����� OASIS��.', '6'

execute AddAudio '11:17:09', '������� ���������', 8.26, NUll, '������'
execute AddMovie '2:32:00', '��������������', '���� ��������', 26, 2001
execute AddBook 32.2, '2016', 3 
execute AddItem '������� ������ �������������', '������ �����', '� 2045 ���� �������� ��� � �� ����� �������� �����. ��-���������� ����� ���� ����� ��������� ���� ���� � OASIS� � �������� ����������� ������������, ��� �������� ���� ��� ������� ����� ������������. ����� ������� ������������� ��������� OASIS�, ��������� ��-��������� ������� ���, ���������� �� �� ������ ��� ���������� �����������. ���, ��� ��������� �� ������, ���������� ��� �������� ��������� � � �������� ��� ����� OASIS��.'
