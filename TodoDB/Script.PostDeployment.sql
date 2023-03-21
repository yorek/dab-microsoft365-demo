-- Create application user 
if (serverproperty('Edition') = 'SQL Azure') begin

    if not exists (select * from sys.database_principals where [type] in ('E', 'S') and [name] = 'todo_dab_user')
    begin 
        create user [todo_dab_user] with password = 'rANd0m_PAzzw0rd!'        
    end

    alter role db_datareader add member [todo_dab_user]
    alter role db_datawriter add member [todo_dab_user]
    
end else begin

    if not exists (select * from sys.server_principals where [type] in ('E', 'S') and [name] = 'todo_dab_user')
    begin 
        create login [todo_dab_user] with password = 'rANd0m_PAzzw0rd!'
    end    

    if not exists (select * from sys.database_principals where [type] in ('E', 'S') and [name] = 'todo_dab_user')
    begin
        create user [todo_dab_user] from login [todo_dab_user]            
    end

    alter role db_datareader add member [todo_dab_user]
    alter role db_datawriter add member [todo_dab_user]
end