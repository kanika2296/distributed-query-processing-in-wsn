function [] = InsertToDB( Vars, conn, id, k)
query_create = "CREATE TABLE IF NOT EXISTS SensorData"+id+" (id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,time_stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP";
for i = 1: length(Vars)
    query_create = query_create + ","+Vars(i)+" float NOT NULL ";
end
curs = exec(conn,query_create+")");
curs = fetch(curs);
curs.Data;

query_insert = "INSERT into SensorData"+id+" ( ";
for i = 1: length(Vars)
    if i~=length(Vars)
        query_insert = query_insert +Vars(i)+" ,";
    else
        query_insert = query_insert +Vars(i)+ " ) values (";
    end
end

for i = 1: length(k)
    if i~=length(k)
        query_insert = query_insert + k(i)+", ";
    else
        query_insert = query_insert + k(i)+")";
    end
end
curs = exec(conn,query_insert);
curs = fetch(curs);
curs.Data;

