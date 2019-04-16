use Nanjing;

create login [admin_Nanjing] with password = 'admin', 
CHECK_EXPIRATION=OFF, 
CHECK_POLICY=ON;

create user admin_Nanjing for login [admin];

alter server role [dbcreator] add member [admin_Nanjing];

create login [manager_Nanjing] with password = 'manager', 
DEFAULT_DATABASE=[Nanjing];

create user manager_Nanjing for login [manager_Nanjing];

create login [default_Nanjing] with password = 'default', 
DEFAULT_DATABASE=[Nanjing];

create user default_Nanjing for login [default_Nanjing];

create login [user_Nanjing] with password = 'user', 
DEFAULT_DATABASE=[Nanjing];

create user user_Nanjing for login [user_Nanjing];






