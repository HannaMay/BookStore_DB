use Nanjing

go
create procedure AddGenre
	@NameGanre nvarchar(max)
as
begin
	begin try
		declare @countBefore int,
			@countAfter int,
			@result int
		set @countBefore = (select count(*) from Book)
		insert into Genre([Name]) values (@NameGanre)
		set @countAfter = (select count(*) from Book)
		set @result = @countAfter - @countBefore
		select @result as result
	end try
	begin catch
		select -1 as result
		print 'Ошибка вставки данных в таблицу Genre. Такой жанр уже есть'
	end catch
end


go
create procedure AddPublisher
	@Name nvarchar(max),
	@Desc nvarchar(max)
as
begin
	begin try
		declare @countBefore int,
			@countAfter int,
			@result int
		set @countBefore = (select count(*) from Book)
		insert into Publisher(Name, Description) 
			values (@Name, @Desc)
		set @countAfter = (select count(*) from Book)
		set @result = @countAfter - @countBefore
		select @result as result
	end try
	begin catch
		select -1 as result
		print 'Ошибка вставки данных в таблицу Publisher Такой издатель уже есть'
	end catch
end

go
create procedure GetAllGenre
as
begin	
	select g.[Name] from Genre g
	order by Name desc
end

go
create procedure GetGenreById
	@Id int,
	@NameGanre nvarchar(max)
as
begin	
	select g.[Name] from Genre g where g.Id = @Id
end


go
create procedure GetAllPublisher
as
begin	
	select p.[Name], p.[Description] from Publisher p
	order by Name desc
end

go
create procedure GetPublisherById
	@Id int
as
begin	
	select p.[Name], p.[Description] from Publisher p where p.Id = @Id
end

go
create procedure GetPublisherByName
	@Name nvarchar(max)
as
begin	
	select p.[Name], p.[Description] from Publisher p where p.[Name] = @Name
end


go
create procedure UpdateGenre
	@Id int,
	@NameGanre nvarchar(max)
as
begin	
	if exists (select count(1) from Genre where Genre.Id = @Id)
		begin 
			update Genre set Genre.[Name] = @NameGanre
							where Genre.Id = @Id
		end 
	else
	ROLLBACK TRANSACTION
	print 'Ошибка обновления данных в таблице Genre.'	
end

go
create procedure UpdatePublisher
	@Id int,
	@Name nvarchar(max),
	@Desc nvarchar(max)
as
begin	
	if exists (select count(1) from Publisher where Publisher.Id = @Id)
		begin 
			update Publisher set Publisher.[Name] = @Name,
								 Publisher.[Description] = @Desc
							 where Publisher.Id = @Id
		end 
	else
	ROLLBACK TRANSACTION
	print 'Ошибка обновления данных в таблице Publisher.'	
end

go
create procedure DeleteGenre
	@Id int
as
begin
	if exists (select count(1) from Genre where Genre.Id = @Id)
	begin 
		delete from ItemsGenres where ItemsGenres.IdGenre = @Id
		delete from Genre where Genre.Id = @Id
	end
	else
		ROLLBACK TRANSACTION
		print 'Ошибка удаления в таблицы Movie (proc DeleteMovie)'
end

go
create procedure DeletePublisher
	@Id int
as
begin
	if exists (select count(1) from Publisher where Publisher.Id = @Id)
	begin
		delete from Publisher where Publisher.Id = @Id
	end
	else
		ROLLBACK TRANSACTION
		print 'Ошибка удаления в таблицы Movie (proc DeleteMovie)'
end

