function [data] = Skyline(Vars, conn, id, isLocal)

if isLocal==1
    RemovePreviousFromDB( conn, id, 300);% valid set of objects
    query_s = "SELECT * FROM SensorData"+id+" s WHERE  NOT EXISTS( SELECT * FROM SensorData"+id+" s1 WHERE ";
    
else
    RemovePreviousFromDB_global( conn, id, 300); % valid set of objects
    query_s = "SELECT * FROM SensorData_global"+id+" s WHERE  NOT EXISTS( SELECT * FROM SensorData_global"+id+" s1 WHERE ";
    
end

for i = 1: length(Vars)
    query_s = query_s + "s1."+Vars(i)+" <= s."+Vars(i)+" AND ";
end
query_s = query_s + "(";
for i = 1: length(Vars)
    if(i ~= length(Vars))
        query_s = query_s + "s1."+Vars(i)+" < s."+Vars(i)+" OR ";
    else
        query_s = query_s + "s1."+Vars(i)+" < s."+Vars(i)+" )) ";
    end
    
end

curs = exec(conn,query_s);
curs = fetch(curs);
data = curs.Data;
