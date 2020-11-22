function Sensors=disToSink(Sensors,Model)
    n=Model.n;
    for i=1:n
        
        if(i>n/3 && i<2*n/3)
            distance=sqrt((Sensors(i).xd-Sensors(n+2).xd)^2 + ...
            (Sensors(i).yd-Sensors(n+2).yd)^2 + (Sensors(i).zd-Sensors(n+2).zd)^2);
        else if(i>2*n/3 && i<n) 
            distance=sqrt((Sensors(i).xd-Sensors(n+3).xd)^2 + ...
            (Sensors(i).yd-Sensors(n+3).yd)^2 + (Sensors(i).zd-Sensors(n+3).zd)^2);
            else
                distance=sqrt((Sensors(i).xd-Sensors(n+1).xd)^2 + ...
                (Sensors(i).yd-Sensors(n+1).yd)^2 + (Sensors(i).zd-Sensors(n+3).zd)^2);
            end
        end        
        Sensors(i).dis2sink=distance;
        
    end
    
end