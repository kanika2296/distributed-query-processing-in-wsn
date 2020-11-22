function Sensors=resetSensors(Sensors,Model)
    n=Model.n;
    for i=1:n
        Sensors(i).MCH=[n+1 n+2 n+3 n+4 n+5 n+6 n+7];
        Sensors(i).type='N';
        Sensors(i).dis2ch=inf;
    end
    
end