function Sensors=ConfigureSensors(Model,n,GX,GY,GZ)

%% Configuration EmptySensor
EmptySensor.xd=0;
EmptySensor.yd=0;
EmptySensor.zd=0;
EmptySensor.G=0;
EmptySensor.df=0;
EmptySensor.type='N';
EmpySensor.Global=[0 0 0];
EmpySensor.local=[];
EmptySensor.SensorType = 1;
EmptySensor.E=0; 
EmptySensor.id=0;
EmptySensor.dis2sink=0;
EmptySensor.dis2ch=0;
EmptySensor.MCH=n+2;    %Member of CH
%% Configuration Sensors
Sensors=repmat(EmptySensor,n+7,1);
for i = 1:7
    Sensors(n+i).xd=Model.Sinkx(i); 
    Sensors(n+i).yd=Model.Sinky(i);
    Sensors(n+i).zd=Model.Sinkz(i);
    Sensors(n+i).E=100;
    Sensors(n+i).id=n+i;
end
for i=1:1:n
    %set x location
    Sensors(i).xd=GX(i); 
    %set y location
    Sensors(i).yd=GY(i);
    %set z location
    Sensors(i).zd=GZ(i);
    %Determinate whether in previous periods has been clusterhead or not? not=0 and be=n
    Sensors(i).G=0;
    %dead flag. Whether dead or alive S(i).df=0 alive. S(i).df=1 dead.
    Sensors(i).df=0; 
    %initially there are not each cluster heads 
    Sensors(i).type='N';
    %initially all nodes have equal Energy
    Sensors(i).E=Model.Eo;
    %id
    Sensors(i).id=i;

    %Sensors(i).RR=Model.RR;
    if mod(i,3)==0
        Sensors(i).SensorType = 1;
    else
        if mod(i,3)==1
            Sensors(i).SensorType = 2;
        else
            Sensors(i).SensorType = 3;
        end
    end
    
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
    
end 

Sensors(n+1).MCH=Sensors(n+5).id;
Sensors(n+2).MCH=Sensors(n+5).id;
Sensors(n+3).MCH=Sensors(n+6).id;
Sensors(n+4).MCH=Sensors(n+6).id;
Sensors(n+5).MCH=Sensors(n+7).id;
Sensors(n+6).MCH=Sensors(n+7).id;
Sensors(n+7).MCH=Sensors(n+7).id;
end