function [info] = InsertToDB_global(Vars, conn, id, data_time, k)
query_create = "CREATE TABLE IF NOT EXISTS SensorData_global"+id+" (id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,time_stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP";
for i = 1: length(Vars)
    query_create = query_create + ","+Vars(i)+" float ";
end
curs = exec(conn,query_create+")");
query_insert = "Insert into Sensordata_global"+id+ "( time_stamp , ";
for i = 1: length(Vars)
    if i~=length(Vars)
        query_insert = query_insert +Vars(i)+" , ";
    else
        query_insert = query_insert +Vars(i)+" ) ";
    end
    
end

query_insert = query_insert + " values ('"+string(data_time)+"', ";
for i = 1: length(k)
    if i~=length(k)
        query_insert = query_insert + k(i)+", ";
    else
        query_insert = query_insert + k(i)+")";
    end
end
%query_insert
curs = exec(conn,query_insert);
curs = fetch(curs);
info = curs.Data;
