function Sensors=JoinToNearestCH(Sensors,Model,TotalCH)
n=Model.n;
m=length(TotalCH);
%m
%disp("In join to CH outer");
if(m>1)
    %disp("m greater than 1");
    D=zeros(m,n);  
    for i=1:n     
        for j=1:m
            
            D(j,i)=sqrt((Sensors(i).xd-Sensors(TotalCH(j).id).xd)^2+ ...
                (Sensors(i).yd-Sensors(TotalCH(j).id).yd)^2  + (Sensors(i).zd-Sensors(TotalCH(j).id).zd)^2);        
        end   
    end 
    
    %% 
    [Dmin,idx]=min(D);
    %disp("In join to CH");
    for i=1:n  
        %fprintf("!!! dmin = %0.2f , Model.RR = %0.2f\n", Dmin, Model.RR);
        if (Sensors(i).E>0)
            %if node is in RR CH and is Nearer to CH rather than Sink
            %fprintf("dmin = %0.2f , Model.RR = %0.2f\n", Dmin, Model.RR);
            if (Dmin(i) <= Model.RR && Dmin(i)<Sensors(i).dis2sink )
                Sensors(i).MCH=TotalCH(idx(i)).id;
                Sensors(i).dis2ch=Dmin(i);
            else
                if(i<n/4)
                    Sensors(i).MCH=Sensors(n+1).id;                       %Sink
                else
                    if(i>=n/4 && i<2*n/4)
                        Sensors(i).MCH=Sensors(n+2).id;                   %Sink
                    else
                        if(i>=2*n/4 && i<3*n/4)
                            Sensors(i).MCH=Sensors(n+3).id;               %Sink
                        else
                            Sensors(i).MCH=Sensors(n+4).id;               %Sink
                        end

                    end
                end
                
                Sensors(i).dis2ch=Sensors(i).dis2sink;
            end
        end
        
    end 
end

Sensors(n+1).MCH=Sensors(n+5).id;
Sensors(n+2).MCH=Sensors(n+5).id;
Sensors(n+3).MCH=Sensors(n+6).id;
Sensors(n+4).MCH=Sensors(n+6).id;
Sensors(n+5).MCH=Sensors(n+7).id;
Sensors(n+6).MCH=Sensors(n+7).id;

end

