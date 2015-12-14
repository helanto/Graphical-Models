function num = getIndexLast(name)
    switch(name(2))
        case 'a', num = 1;
        case 'l', num = 2;
        case 'o', num = 3;
        case 'h', num = 4;
        case 'i', num = 5;
        case 'u', num = 6;
        case 'r', num = 7;
        otherwise, num = 0;
    end;
end