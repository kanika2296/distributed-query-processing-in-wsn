
parpool(2)
spmd
    t = getCurrentTask();
    
    conn = database('test','root','root');
    if t.ID==1
        initStore(conn);
    else
        LEACH1(conn);
    end
end
