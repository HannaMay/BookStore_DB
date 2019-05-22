use Nanjing;

drop trigger DataNanjing_Data

go
alter trigger DataNanjing_Data
	on DataNanjing
	after insert, update
as
begin
	declare 
		@audio_id int, 
		@book_id int, 
		@video_id int,
		@audio_data_id int,
		@book_data_id int,
		@video_data_id int;

	if exists (select distinct Items.[Name] 
			   from Items, inserted 
			   where Items.[Name] = inserted.[Name] 
			       and inserted.[type] = 'picture')
		begin 
			update Items set Items.IdDataLogo = inserted.Id 
			from inserted 
			where inserted.[type] = 'picture' 
				and Items.[Name] = inserted.[Name]
		end

	else if exists(select Items.[Name] 
				   from Items join inserted on Items.[Name] = inserted.[Name] 
				   where inserted.[type] = 'audio')
		begin 	
			set @audio_id = (select Items.Id 
							 from Items join inserted on Items.[Name] = inserted.[Name] 
							 where inserted.[type] = 'audio')
			set @audio_data_id = (select inserted.Id 
								  from items, inserted 
								  where inserted.[type] = 'audio' 
									  and Items.[Name] = inserted.[Name] 
									  and Items.Id = @audio_id)
			if exists(select distinct Audio.IdItems 
					  from Items join inserted on Items.[Name] = inserted.[Name]
								 join Audio on Items.Id = Audio.IdItems)
				begin
					update Audio set Audio.IdDataAudio = inserted.Id 
					from items, inserted 
					where inserted.[type] = 'audio' 
						and Items.[Name] = inserted.[Name] 
						and Items.Id = Audio.IdItems
				end
			else 			
				begin
					insert into Audio(IdItems, IdDataAudio) values (@audio_id, @audio_data_id)
					print 'Не забудьте добавить данные в таблицу Audio'
				end
		end

	else if exists(select Items.[Name]
				   from Items join inserted on Items.[Name] = inserted.[Name] 
				   where inserted.[type] = 'video')
		begin 
			set @video_id = (select Items.Id 
							 from Items join inserted on Items.[Name] = inserted.[Name] 
							 where inserted.[type] = 'video')
			set @video_data_id = (select inserted.Id 
								  from items, inserted 
								  where inserted.[type] = 'video'
									 and Items.[Name] = inserted.[Name]
									 and Items.Id = @video_id)
			if exists(select distinct Movie.IdItems
						from Items join inserted on Items.[Name] = inserted.[Name]
								   join Movie on Items.Id = Movie.IdItems)
				begin
					update Movie set Movie.IdDataMovie = inserted.Id 
					from items, inserted 
					where inserted.[type] = 'video'
						and Items.[Name] = inserted.[Name]
						and Items.Id = Movie.IdItems
				end
			else 
				begin 
					insert into Movie(IdItems, IdDataMovie) values (@video_id, @video_data_id)
					print 'Не забудьте добавить данные в таблицу Movie'
				end	
		end

	else if exists(select Items.[Name]
				   from Items join inserted on Items.[Name] = inserted.[Name]
				   where inserted.[type] = 'text')
		begin
			set @book_id = (select Items.Id 
							from Items join inserted on Items.[Name] = inserted.[Name] 
							where inserted.[type] = 'text')
			set @book_data_id = (select inserted.Id 
								 from items, inserted 
								 where inserted.[type] = 'text'
									 and Items.[Name] = inserted.[Name]
									 and Items.Id = @book_id)
			if exists(select distinct Book.IdItems
					  from Items join inserted on Items.[Name] = inserted.[Name]
								 join Book on Items.Id = Book.IdItems)
				begin
					update Book set Book.IdDataBook = inserted.Id 
					from items, inserted 
					where inserted.[type] = 'text'
						and Items.[Name] = inserted.[Name]
						and Items.Id = Book.IdItems
				end
			else 
				begin 
					insert into Book(IdItems, IdDataBook) values (@book_id, @book_data_id)
					print 'Не забудьте добавить данные в таблицу Book'
				end	
		end
	else
		begin 
			ROLLBACK TRANSACTION
			print 'Ошибка, нет данных в таблице Items'
		end	
end