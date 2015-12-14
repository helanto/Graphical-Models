function num = getIndexFirst(name)
    switch(name(1))
        case 'd', num = 1;
        case 'a', num = 2;
        case 'f', num = 3;
        case 'j', num = 4;
        case 'b', num = 5;
        otherwise, num = 0;
    end;
end