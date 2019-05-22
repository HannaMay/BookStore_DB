USE [master]
GO

create login [admin_Nanjing] with password = 'admin', 
DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[русский],
CHECK_EXPIRATION=OFF, CHECK_POLICY=ON;
GO

alter server role [dbcreator] add member [admin_Nanjing];
GO

ALTER LOGIN [adminR_Nanjing] DISABLE
GO

create login [manager_Nanjing] with password = 'manager', 
DEFAULT_DATABASE=[Nanjing], DEFAULT_LANGUAGE=[русский],
CHECK_EXPIRATION=OFF, CHECK_POLICY=ON;
GO

ALTER LOGIN [manager_Nanjing] DISABLE
GO

create login [default_Nanjing] with password = 'default', 
DEFAULT_DATABASE=[Nanjing], DEFAULT_LANGUAGE=[русский],
CHECK_EXPIRATION=OFF, CHECK_POLICY=ON;
GO

ALTER LOGIN [default_Nanjing] DISABLE
GO

create login [user_Nanjing] with password = 'user', 
DEFAULT_DATABASE=[Nanjing], DEFAULT_LANGUAGE=[русский],
CHECK_EXPIRATION=OFF, CHECK_POLICY=ON;
GO

ALTER LOGIN [user_Nanjing] DISABLE
GO

use Nanjing

create user admin_Nanjing for login [admin_Nanjing];
create user manager_Nanjing for login [manager_Nanjing];
create user default_Nanjing for login [default_Nanjing];
create user user_Nanjing for login [user_Nanjing];

