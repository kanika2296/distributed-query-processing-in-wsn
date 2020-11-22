function [Area,Model]=setParameters(n)

%%%%%%%%%%%%%%%%%%%%%%%%% Set Inital PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%
%Field Dimensions - x and y maximum (in meters)
Area.x=n;
Area.y=n;
Area.z=n; 

%Sink Motion pattern 
Sinkx=[15 50 110 175 33 130 100 ];
Sinky=[rand()*100 rand()*100 rand()*100 rand()*100 rand()*100 rand()*100 rand()*100];
Sinkz=[(20)*rand()+100 (20)*rand()+100 (20)*rand()+100 (20)*rand()+100 (20)*rand()+200 (20)*rand()+200 300];


%Query flag
queryStarted = false;


%Optimal Election Probability of a node to become cluster head
p=0.1;

%%%%%%%%%%%%%%%%%%%%%%%%% Energy Model (all values in Joules)%%%%%%%%%%%
%Initial Energy 
Eo=0.5;

%Eelec=Etx  -> transmission energy
%Erx  -> receiving energy
ETX=50*0.000000001;
ERX=50*0.000000001;

%Transmit Amplifier types
Efs=10*0.000000000001;
Emp=0.0013*0.000000000001;

%Data Aggregation Energy for cluster head
EDA=5*0.000000001;

%Computation of do
do=sqrt(Efs/Emp);


%%%%%%%%%%%%%%%%%%%%%%%%% Run Time Parameters %%%%%%%%%%%%%%%%%%%%%%%%%
%maximum number of rounds
rmax=2;

%Data packet size in bits
DpacketLen=480;

%Hello packet size in bits
HpacketLen=100;

%Number of Packets sended in steady-state phase
NumPacket=10;

%Redio Range
RR=sqrt((80*80)+(100*100)+(40*40));

%fields in dataset
Vars = ["CO", "TinOxide", "NonMetanicHydroCarbons", "Benzene", "Titania", "NOx", "TungstenOxide_3", "NO2", "TungstenOxide_4", "IndiumOxide", "Temperature", "RelativeHumidity", "AbsoluteHumidity"];
%%%%%%%%%%%%%%%%%%%%%%%%% END OF PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%% Save in Model %%%%%%%%%%%%%%%%%%%%%%%%%%%%
Model.n=n;
Model.Sinkx=Sinkx;
Model.Sinky=Sinky;
Model.Sinkz=Sinkz;
Model.p=p;
Model.Eo=Eo;
Model.ETX=ETX;
Model.ERX=ERX;
Model.Efs=Efs;
Model.Emp=Emp;
Model.EDA=EDA;
Model.do=do;
Model.rmax=rmax;
Model.DpacketLen=DpacketLen;
Model.HpacketLen=HpacketLen;
Model.NumPacket=NumPacket;
Model.RR=RR;
Model.QueryStarted = queryStarted;
Model.QueryStartTime = "0";
Model.QueryEndTime = "0";
Model.QueryDelta = "0";
Model.Vars = Vars;

end