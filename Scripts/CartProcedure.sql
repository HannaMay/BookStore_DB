use Nanjing
select * from Orders o
select * from OrdersHistory
select * from QuantityOrderItems

go
alter procedure AddQuantityOrderItems
	@quantity int,
	@price float,
	@iditems int,
	@idorders int,
	@iddataitem int,
	@typeitem nvarchar(max)
as
begin
	begin try
		declare @countBefore int,
			@countAfter int,
			@result int
		set @countBefore = (select count(*) from QuantityOrderItems)
		insert into QuantityOrderItems ([Quantity], [price], [IdItems], IdOrder, IdDataItem, TypeItem)
			values ( @quantity, @price, @iditems, @idorders, @iddataitem, @typeitem)
		set @countAfter = (select count(*) from QuantityOrderItems)
		set @result = @countAfter - @countBefore
		select @result as result
	end try
	begin catch
		select -1 as result
	end catch
end

delete from QuantityOrderItems
select  * from QuantityOrderItems



go
alter procedure AddItemstoCart
	@Date date,
	@Payment nvarchar(max),	
	@IdUser int,	
	@isApproved bit
as
begin
	begin try
		declare @countBefore int,
			@countAfter int,
			@result int
		set @countBefore = (select count(*) from Orders)
		insert into Orders ([Date],	[Payment], [IdUser], [isApproved])
			values ( @Date, @Payment, @IdUser, @isApproved)
		set @countAfter = (select count(*) from Orders)
		set @result = @countAfter - @countBefore 
		select @result as result
	end try
	begin catch
		select -1 as result
	end catch
end

go
alter procedure GetItemsFromCart
	@isApproved bit
as
begin
	if exists (select id from Orders where @isApproved = 0)
	begin
		select ord.isApproved, 
			   i.[Name],
			   i.Author,
			   d.[Data],
			   o.Price, 
			   o.Quantity	 
		from QuantityOrderItems o
		join Orders ord on o.IdOrder = ord.Id
		join Items i on i.Id = o.IdItems
		join DataNanjing d on d.Id = i.IdDataLogo	
	end 
	else 
	begin
		print 'Товаров в корзине нету'
	end
end

go
create procedure DeleteItemsFromCart
	@id int
as
begin
	if exists (select count(1) from Orders where Id = @Id)
	begin 
		delete from Orders where Orders.Id = @Id
	end
	else
		ROLLBACK TRANSACTION
		print 'Ошибка удаления в таблице Orders (ItemsFromCart)'
end

go 
create procedure AddToOrdersHistory
	@ok bit,
	@Date date,
	@IdOrder int
as
begin
	begin try
		declare @countBefore int,
			@countAfter int,
			@result int
		set @countBefore = (select count(*) from OrdersHistory)
		if (@ok = 1)
		begin 
			insert into OrdersHistory ([Date],[IdOrder])
			values ( @Date, @IdOrder)
		end
		else
		begin
			rollback transaction 
		end
		set @countAfter = (select count(*) from OrdersHistory)
		set @result = @countAfter - @countBefore
		select @result as result
	end try
	begin catch
		select -1 as result
	end catch
end

go
declare @price float = (select price from Audio where id = 1)
execute AddQuantityOrderItems 4, @price, 1, 6, 1, 'audio'
go
declare @date date = (select GETDATE())
execute AddItemstoCart @date, 'paypal', 7, 0

execute GetItemsFromCart 0
execute DeleteItemsFromCart 5