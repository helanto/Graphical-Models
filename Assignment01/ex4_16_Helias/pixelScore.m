function objectiveFn = pixelScore(x,y,pos)
% calculate objective function value = Summation of w*instruction Function
% for each pixel in restored image + summation of 2*pixel value of noisy
% image * pixel value of restored image

% weight for neighbour defined as 10
w = 10;

[row, col] =ind2sub([321,265],pos);


pixel = x(pos);
noisyPixel = y(pos);
    
if row > 1
    pixelUp = x(row-1,col);
else
    pixelUp = 0;
end;
    
if col>1
    pixelLeft = x(row,col-1);
else
    pixelLeft = 0;
end;
    
if row<321
    pixelDown = x(row+1,col);
else
    pixelDown = 0;
end;
    
if col<265
    pixelRight = x(row,col+1);
else
    pixelRight = 0;
end;
    
objectiveFn = w * instruction(pixel,pixelUp) ...
            + w * instruction(pixel,pixelDown)...
            + w * instruction(pixel,pixelLeft)...
            + w * instruction(pixel,pixelRight)...
            + 2 * instruction(noisyPixel,pixel);
end