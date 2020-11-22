function [] = RemovePreviousFromDB( conn, id, window_size)
time = datestr(datetime('now')-seconds(window_size), 'yyyy-mm-dd HH:MM:SS');
query_delete = "DELETE FROM SensorData"+id+" WHERE time_stamp <= '"+time+"'";
curs = exec(conn,query_delete);
curs = fetch(curs);
data = curs.Data;


