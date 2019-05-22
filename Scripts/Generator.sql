use Nanjing

go
alter procedure generate_quantity
as
begin
	declare @Price float;
	declare @IdOrder nvarchar(max);	
	declare @IdItems int;	
	declare @Quantity int;
	declare @IdDataItem int;
	declare @TypeItem nvarchar(max);
	declare @counter int = 0;
	begin try
		while @counter <> 100000
			begin
				set @counter = @counter + 1;
				set @Price =  ROUND(1 + RAND() * 99, 2);
				set @Quantity =  ROUND(RAND() * 10, 0);
				set @IdItems = (select top(1) id from Items order by NEWID());
				set @IdOrder = (select top(1) id from Orders order by NEWID());		
				set @IdDataItem = ROUND(RAND() * 3, 0);
				set @TypeItem = 'video'
				execute AddQuantityOrderItems @Quantity, @Price, @IdItems, @IdOrder, @IdDataItem, @TypeItem;
			end
	end try	
	begin catch
		select ERROR_MESSAGE()
	end catch
end

execute generate_quantity
select distinct i.[Name], 
	   i.[Author],
	   q.[Price], 
	   q.Quantity, 
	   q.TypeItem, 
	   d.[Data],  
	   q.IdOrder
from QuantityOrderItems q
join Items i on i.Id = q.IdItems
join DataNanjing d on d.[Name] = i.[Name] 

CREATE NONCLUSTERED INDEX index_Nanjing
ON QuantityOrderItems (IdItems, IdOrder)
WITH FILLFACTOR= 80;

select i.[Name], 
	   i.[Author],
	   q.[Price], 
	   q.Quantity, 
	   q.TypeItem, 
	   d.[Data],  
	   q.IdOrder 
	   from QuantityOrderItems q 
	   join Items i on i.Id = q.IdItems
	   join DataNanjing d on d.[Name] = i.[Name] 
where IdItems = 2  and IdOrder = 6