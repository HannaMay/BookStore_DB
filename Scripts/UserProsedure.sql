use Nanjing;
select * from Users
drop procedure CreateUser
drop procedure AddManager

--регистрация
go
alter procedure CreateUser
	@FName nvarchar(max),
	@SName nvarchar(max),
	@Login nvarchar(25),
	@Email nvarchar(max),
	@Address nvarchar(max),
	@Birthday date,
	@Password nvarchar(25),
	@Phone nvarchar(12)
as
begin 
	declare @countBefore int,
			@countAfter int,
			@count int,
			@result int,
			@IdRole int
	set @countBefore = (select count(*) from [Users])
	set @IdRole = 3
	insert into [Users] (FName, SName, [Login], Email, [Address], Birthday, [Password], Phone,  IdRole)
		  values (@FName, @SName, @Login, @Email, @Address, @Birthday, @Password, @Phone,  @IdRole)
		set @countAfter = (select count(*) from [Users])
	set @result = @countAfter - @countBefore
	select @result as result
end

go
alter procedure AddManager
	@FName nvarchar(max),
	@SName nvarchar(max),
	@Login nvarchar(25),
	@Email nvarchar(max),
	@Address nvarchar(max),
	@Birthday date,
	@Password nvarchar(25),
	@Phone nvarchar(12)
as
begin 
	declare @countBefore int,
			@countAfter int,
			@count int,
			@result int,
			@IdRole int
	set @countBefore = (select count(*) from [Users])
	set @IdRole = 2
	insert into [Users] (FName, SName, [Login], Email, [Address], Birthday, [Password], Phone,  IdRole)
		  values (@FName, @SName, @Login, @Email, @Address, @Birthday, @Password, @Phone,  @IdRole)
		set @countAfter = (select count(*) from [Users])
	set @result = @countAfter - @countBefore
	select @result as result
end

--авторизация
go 
alter procedure LoginIntoNanjing
@login nvarchar(25),
@password nvarchar(25)
as
begin
	if(select COUNT(*) from Users
	   where [login] = @login and [password] = @password) = 1
	   begin
			select [Name], [Password] from Roles
			where Id = (select IdUserRoles from UserRoles
						where Id = (select [IdRole] from [Users]
									where [Login] = @login and [Password] = @password))
	   end
	else
		begin
			select -1 as result
		end
end

--поличение ролей пользователей
go
alter procedure GetRole
as
begin
	select * from UserRoles
end

-- получение списка пользователей
go
alter procedure GetUser
as
begin
	select * from Users
end

--удаление пользователя по Id
go
alter procedure DeleteUser
	@id int
as
begin
	if exists (select id from Users)
	begin 
		delete from Users where id = @id
		print 'Пользователь удалён'
	end
	else
		begin 
			print 'Такого пользователя не существует'
		end
end


execute CreateUser 'Tanya', 'Brovchenko', 'tanya', 't_cat@mail.ru', 'st. Ostrovskogo 60', '02-07-1978', 'tanya_cat', '375256145244'
execute CreateUser 'Вова', 'Бровченко', 'vovan', 'vovan_bear@mail.ru', 'st. Ostrovskogo 60', '22-11-1998', 'vovan_bear', '375251132323'

execute LoginIntoNanjing 'tanya', 'tanya_cat'

execute GetRole
execute GetUser
execute DeleteUser 5
execute AddManager 'Оля', 'Шинкарёва', 'olya_princec', 'mylove@mail.ru', 'пер. Товарный 13', '28-08-1999', 'olychan', '375296657676'
