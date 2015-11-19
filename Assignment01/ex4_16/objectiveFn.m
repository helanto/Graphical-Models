function objectiveFn = objectiveFn(x,y)
% calculate objective function value = Summation of w*instruction Function
% for each pixel in restored image + summation of 2*pixel value of noisy
% image * pixel value of restored image

% weight for neighbour defined as 10
w = 10;
% initialize objective function value
objectiveFn = 0;

for index = 1:85065
    pixel = x(index);
    noisyPixel = y(index);
    
    if index > 256
        pixelUp = x(index-256);
    else
        pixelUp = 0;
    end
    
    if index == 1
        pixelLeft = 0;
    else
        pixelLeft = x(index-1);
    end
    
    if index > (85065-256)
        pixelDown = 0;
    else
        pixelDown = x(index+256);
    end
    
    if index == 85065
        pixelRight = 0;
    else
        pixelRight = x(index+1);    
    end
    
    objectiveFn = objectiveFn + w * instruction(pixel,pixelUp) ...
            + w * instruction(pixel,pixelDown)...
            + w * instruction(pixel,pixelLeft)...
            + w * instruction(pixel,pixelRight)...
            + 2 * noisyPixel * pixel;
end





