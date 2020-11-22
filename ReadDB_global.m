function [data] = ReadDB_global( conn, id)
query_create = "select * from SensorData_global"+id;
curs = exec(conn,query_create);
curs = fetch(curs);
data = curs.Data;
