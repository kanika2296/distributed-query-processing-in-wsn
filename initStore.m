function [] = initStore(conn)
x = 5;
rows =1;
Vars = ["CO", "TinOxide", "NonMetanicHydroCarbons", "Benzene", "Titania", "NOx", "TungstenOxide_3", "NO2", "TungstenOxide_4", "IndiumOxide", "Temperature", "RelativeHumidity", "AbsoluteHumidity"];
M = csvread("n2.csv");
% 
while true
    x = x-1;
    for i =1:40
        InsertToDB(Vars, conn, i, transpose(M(rows, :)));  
        rows = rows+1;
        if(rows > length(M))
            break;
        end
        if x==0
            RemovePreviousFromDB(conn, i, 600)
            RemovePreviousFromDB_global(conn, i, 600)
        end
       
    end
    if x==0
        for p = 41:47
            RemovePreviousFromDB_global( conn, p, 600);
        end
        x = 5;
    end
    pause(2);
end
