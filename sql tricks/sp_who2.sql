--trick no. 3


sp_who2 'active'

EXEC sp_who2


kill 67



SELECT
    session_id,
    is_user_process,
    login_name,
    program_name
FROM sys.dm_exec_sessions
WHERE session_id = 57;
