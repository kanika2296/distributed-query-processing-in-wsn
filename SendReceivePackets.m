function Sensors=SendReceivePackets(conn, Sensors,Model,Sender,PacketType,Receiver)
   global srp rrp sdp rdp x1 flag
   sap=0;      % Send a packet
   rap=0;      % Receive a packet
   if (strcmp(PacketType,'Hello'))
       PacketSize=Model.HpacketLen;
   else
       % data packet, notify query
       PacketSize=Model.DpacketLen;
   end
   %Sender 
   %Receiver
   packets = zeros(length(Sender), length(Receiver));
    if (strcmp(PacketType,'Data'))
        %disp("packet type data!!!!!!!!!!!!!!!");
        for i=1:length( Sender)
          if Sensors(Sender(i)).type=='C' || Sender(i)>Model.n
             data_read = Skyline(Model.Vars,conn, Sender(i), 0); %for accessing data from global file, for sink nodes 
          else
             data_read = Skyline(Model.Vars,conn, Sender(i), 1); %for accessing data from local file, for sensors
          end
          
          
          %disp("Skyline ended!!!!!!!!!!!!!!!");
          for j=1:length( Receiver)
            %fprintf("sender = %d , Receiver = %d\n", Sender(i), Receiver(j));
             
             for l = 1: size(data_read,1)
                 if size(data_read,2)>1
                     if l==1
                         %disp("Skyline data RECEIVED!!!!!!!!!!!!!!!");
                     end
                     vals = zeros(length(Model.Vars),1);
                     for h = 1 : length(Model.Vars)
                         vals(h) = cell2mat(data_read(l,h+2));
                     end
                     InsertToDB_global(Model.Vars, conn, Receiver(j), data_read(l,2), vals);
                     %disp("Insert to global called..........................................................");
                 end
             end
             packets(i, j) = PacketSize*length(data_read);
          end
        end
    else
       for i=1:length( Sender)
          for j=1:length( Receiver)
              packets(i,j)= PacketSize;
          end
       end
   end

  %Energy dissipated from Sensors for Send a packet  
   for i=1:length( Sender)
      for j=1:length( Receiver)
            distance=sqrt((Sensors(Sender(i)).xd-Sensors(Receiver(j)).xd)^2 + ...
               (Sensors(Sender(i)).yd-Sensors(Receiver(j)).yd)^2  + (Sensors(Sender(i)).zd-Sensors(Receiver(j)).zd)^2 );

            if (distance>Model.do)
                Sensors(Sender(i)).E= Sensors(Sender(i)).E- ...
                    (Model.ETX*packets(i,j) + Model.Emp*packets(i,j)*(distance^4));
                % Sent a packet
                if(Sensors(Sender(i)).E>0)
                    sap=sap+1;                 
                end
            else
                Sensors(Sender(i)).E= Sensors(Sender(i)).E- ...
                    (Model.ETX*packets(i,j) + Model.Efs*packets(i,j)*(distance^2));
                % Sent a packet
                if(Sensors(Sender(i)).E>0)
                    sap=sap+1;                 
                end
            end 
          
      end
      
   end
   % internal transfer and Energy dissipated from sensors for Receive a packet
   for j=1:length( Receiver)
       
        if (strcmp(PacketType,'Data') ) && Receiver(j)<=Model.n
            data_read = Skyline(Model.Vars,conn, Receiver(j), 1);
             for l = 1: size(data_read,1)
                 if size(data_read,2)>1
                     vals = zeros(length(Model.Vars),1);
                     for h = 1 : length(Model.Vars)
                         vals(h) = cell2mat(data_read(l,h+2));
                     end
                     InsertToDB_global(Model.Vars,conn, Receiver(j), data_read(l,2), vals);
                 end
             end
        end
         
   end   
   
  %Energy dissipated from sensors for Receive a packet
   for i=1:length(Sender)  
       for j=1:length(Receiver)
            Sensors(Receiver(j)).E =Sensors(Receiver(j)).E-((Model.ERX + Model.EDA)*packets(i,j));
            
            if(Sensors(Sender(i)).E>0 && Sensors(Receiver(j)).E>0)
                rap=rap+1;

            end
       end
   end 

   
    if (strcmp(PacketType,'Hello'))
        srp=srp+sap;
        rrp=rrp+rap;
        %{
if(Sender(1)== Model.n+7)
            Sensors=SendReceivePackets(conn, Sensors,Model,[Model.n+5],'Hello',[Model.n+1 Model.n+2]);
            Sensors=SendReceivePackets(conn, Sensors,Model,[Model.n+6],'Hello',[Model.n+3 Model.n+4]);
        end
        %}
    else       
        sdp=sdp+sap;
        rdp=rdp+rap;
    end
   
end

