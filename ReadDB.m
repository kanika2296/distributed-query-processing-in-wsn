function [data] = ReadDB(conn, id)
query_create = "select * from SensorData"+id;
curs = exec(conn,query_create);
curs = fetch(curs);
data = curs.Data;

