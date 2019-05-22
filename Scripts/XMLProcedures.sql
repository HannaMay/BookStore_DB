use Nanjing

go  
alter procedure ImportFromXml
as
begin
	declare @xml xml
	select @xml = convert(xml, bulkcolumn, 2) 
	from openrowset(bulk 'E:\Users.xml', single_blob) as X 
	select @xml
		insert into Users 
		select
			p.value('FName[1]', 'nvarchar(max)') as FName,
			p.value('SName[1]', 'nvarchar(max)') as SName,
			p.value('Login[1]', 'nvarchar(25)')  as [Login],
			p.value('Email[1]', 'nvarchar(max)') as [Email],
			p.value('Address[1]', 'nvarchar(max)') as [Address],
			p.value('Birthday[1]', 'date') as [Birthday],
			p.value('Password[1]', 'nvarchar(25)') as [Password],
			p.value('Phone[1]', 'nvarchar(12)') as [Phone],
			p.value('IdRole[1]', 'int') as [IdRole]
	FROM @xml.nodes('/Users/Users') PropertyFeed(P);
end

execute ImportFromXml

go
alter procedure ExportToXML
as
begin
	EXEC [Nanjing].dbo.sp_configure 'show advanced options', 1 
	RECONFIGURE 
	EXEC [Nanjing].dbo.sp_configure 'xp_cmdshell', 1 
	RECONFIGURE 

	EXEC xp_cmdshell 'bcp "use Nanjing SELECT FName,SName,Login,Email,Address,Birthday,Password,Phone,IdRole FROM Users FOR XML PATH (''User''), ROOT(''Users'')" queryout "E:\Users.xml" -U admin_Nanjing -P admin -S HANNIKA\SQLEXPRESS -w -T' 
end

execute ExportToXML