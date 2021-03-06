function deadNum=ploter(Sensors,Model)
    deadNum=0;
    n=Model.n;
    for i=1:n
        %check dead node
        if (Sensors(i).E>0)
            
            if(Sensors(i).type=='N' )   
                plot3(Sensors(i).xd,Sensors(i).yd,Sensors(i).zd,'o');     
            else %Sensors.type=='C'       
                plot3(Sensors(i).xd,Sensors(i).yd,Sensors(i).zd,'kx','MarkerSize',10);
            end
            
        else
            deadNum=deadNum+1;
            plot3(Sensors(i).xd,Sensors(i).yd,Sensors(i).zd,'red .');
        end
        
        hold on;
        
    end 
    for i = 1:4
        plot3(Sensors(n+i).xd,Sensors(n+i).yd,Sensors(n+i).zd,'g*','MarkerSize',15); 
    end
    plot3(Sensors(n+5).xd,Sensors(n+5).yd,Sensors(n+5).zd,'b*','MarkerSize',12);
    plot3(Sensors(n+6).xd,Sensors(n+6).yd,Sensors(n+6).zd,'b*','MarkerSize',12);
    p = plot3(Sensors(n+7).xd,Sensors(n+7).yd,Sensors(n+7).zd,'r*','MarkerSize',15);
    axis equal
    saveas(p, "k.jpg");
end