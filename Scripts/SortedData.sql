-- Сортировка данных по различным критериям;

use Nanjing

go
create procedure GetAudioByPice
@priceSort bit = 0
as
begin
	if(@priceSort = 0)
	begin
	select i.Id, i.[Name], i.Author, i.[Description],	
		   a.Duration, a.Price, a.Publisher, a.Reader, a.Translater, 
		   d.[Data]
	from Audio a 
	join Items i on i.Id = a.IdItems
	join DataNanjing d on d.Id = a.IdDataAudio and d.Id = i.IdDataLogo	
	order by a.Price desc
	end
	else
	begin
	select i.Id, i.[Name], i.Author, i.[Description],	
		   a.Duration, a.Price, a.Publisher, a.Reader, a.Translater, 
		   d.[Data]
	from Audio a 
	join Items i on i.Id = a.IdItems
	join DataNanjing d on d.Id = a.IdDataAudio and d.Id = i.IdDataLogo	
	order by a.Price asc
	end	 			
end

go
create procedure GetBookByPrice
@priceSort bit = 0
as
begin
	if(@priceSort = 0)
	begin
	select i.Id, i.[Name], i.Author,  i.[Description],	
		   b.Price, b.Publisher, b.PublishDate, 
		   d.[Data]
	from Book b 
	join Items i on i.Id = b.IdItems
	join DataNanjing d on d.Id = b.IdDataBook and d.Id = i.IdDataLogo	
	order by b.Price desc
	end
	else
	begin
	select i.Id, i.[Name], i.Author,  i.[Description],	
		   b.Price, b.Publisher, b.PublishDate, 
		   d.[Data]
	from Book b 
	join Items i on i.Id = b.IdItems
	join DataNanjing d on d.Id = b.IdDataBook and d.Id = i.IdDataLogo	
	order by b.Price asc
	end	 			
end

go
create procedure GetMovieByPrice
@priceSort bit = 0
as
begin
	if(@priceSort = 0)
	begin
	select i.Id, i.[Name], i.Author, i.[Description],	
		   m.[duration], m.[country], m.[producer], m.[price], m.[PublishYear], 
		   d.[Data]
	from Movie m  
	join Items i on i.Id = m.IdItems
	join DataNanjing d on d.Id = m.IdDataMovie and d.Id = i.IdDataLogo	
	order by m.Price desc
	end
	else
	begin
	select i.Id, i.[Name], i.Author, i.[Description],	
		   m.[duration], m.[country], m.[producer], m.[price], m.[PublishYear], 
		   d.[Data]
	from Movie m  
	join Items i on i.Id = m.IdItems
	join DataNanjing d on d.Id = m.IdDataMovie and d.Id = i.IdDataLogo	
	order by m.Price asc
	end	 			
end