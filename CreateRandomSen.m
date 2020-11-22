function CreateRandomSen(Model,Area)
    n=Model.n;
    x=Area.x;
    y=Area.y;
    z=Area.z; 
    X=zeros(1,n);
    Y=X;
    Z=zeros(1,n);
    for i = 1:n
        if i<n/4
            X(i) = (40)*rand() + 0;
           
        else
            if i>=n/4 && i<2*n/4
                X(i) = (40)*rand() + 40;
     
            else
                if i>=2*n/4 && i<3*n/4
                    X(i) = (40)*rand() + 80;
        
                else
                    X(i) = (40)*rand() + 120;
         
                end
            end
        end
        
        Z(i) = (40)*rand();    
        Y(i) = (100)*rand();
    end
    save ('Locations','X','Y','Z');

end