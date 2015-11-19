%% Exercise 4.16

% set up an empty array for the restored values of x
xnew = reshape(xnoisy,[1,85065]);
xnoisyVector = reshape(xnoisy,[1,85065]);

% First, determine how many time(s) you would to run this clean up
iteration = 1;

% Second, create a vector to denote the sequence of pixel flipping
sequence = randperm(85065);

% flip pixel value, check whether objective function value has increased.
% Flip back the pixel if it has not.
% Initialize objective function value

ObjVal = objectiveFn(xnew,xnoisyVector);
ObjValtest = objectiveFn(xnoisyVector, xnoisyVector);
disp(ObjVal);

for iteractionCount = 1:iteration
    for index = 1:length(sequence)
%         disp(sequence(index));
%         disp(xnew(sequence(index)));
%         disp(ObjVal);
        xnew(sequence(index)) = ~xnew(sequence(index));
        newObjVal = objectiveFn(xnew,xnoisyVector);
        if newObjVal < ObjVal
            xnew(sequence(index)) = ~xnew(sequence(index));
        else
            ObjVal = newObjVal;
        end
        disp(index);
%         disp(newObjVal);
%         disp(ObjVal)
%         disp(sequence(index));
%         disp(xnew(sequence(index)));
%         disp(['B ' num2str(xnoisyVector(sequence(index)))]);
    end
end

disp(ObjVal);
image(xnew)










% %% *No Longer iterating per rows and columns but, in above, over a row vector
% % iterate through each row of matrix xnoisy, skipping first and last row
% for i = 2:320
%     % iterate through each column of matrix xnoisy, skipping first and last
%     % column
%     for j = 2:264
%         
%         % get values of the noisy pixel and its neighbours
%         noisypixel = xnoisy(i,j);
%         pixelUp = xnoisy(i-1,j);
%         pixelDown = xnoisy(i+1,j);
%         pixelLeft = xnoisy(i,j-1);
%         pixelRight = xnoisy(i,j+1);
%         Check = [noisypixel,pixelUp,pixelDown,pixelLeft,pixelRight];
%         disp(Check);
%         % calculate objective function value based on xi = 0
%         hypopixelzero = 0;
%         objifzero = w*instruction(hypopixelzero,pixelUp) ...
%             + w*instruction(hypopixelzero,pixelDown)...
%             + w*instruction(hypopixelzero,pixelLeft)...
%             + w*instruction(hypopixelzero,pixelRight)...
%             + 2*noisypixel*hypopixelzero;
%         disp(objifzero);
%         % calculate objective function value based on xi = 1
%         hypopixelone = 1;
%         objifone = w*instruction(hypopixelone,pixelUp) ...
%             + w*instruction(hypopixelone,pixelDown)...
%             + w*instruction(hypopixelone,pixelLeft)...
%             + w*instruction(hypopixelone,pixelRight)...
%             + 2*noisypixel*hypopixelone;
%         disp(objifone);
%         disp(instruction(hypopixelone,pixelUp))
%         
%         % check for the larger of the two, then append the hypothesized
%         % pixel value to xnew array
%         if objifzero > objifone
%             xnew((i-1)*264+j) = hypopixelzero;
%             objfnFound = objfnFound + objifzero;
%         else
%             xnew((i-1)*264+j) = hypopixelone;
%             objfnFound = objfnFound + objifone;
%         end
%     end
% end
% 
% % to-do is to add back the borderline cells - top and bottom rows and
% % rightmost and leftmost columns.

        