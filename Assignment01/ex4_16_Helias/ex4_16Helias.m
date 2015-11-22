%% Exercise 4.16

load('C:\Users\helia\Desktop\UCL\Graphical Models\Matlab\BRMLtoolkit\data\xnoisy.mat');

xnew = xnoisy;
imshow(xnew)

beg = input('Start Iterations?');
changes = 1;
% Iterate as long pixel changes are made
while changes>0
    changes = 0;
    % random sequence
    sequence = randperm(85065);
    for index = sequence
        pix = xnew(index);  %old pixel
        %try both 0 and 1
        xnew(index) = 0;
        obj_minus = pixelScore(xnew,xnoisy,index);
        xnew(index) = 1;
        obj_plus = pixelScore(xnew,xnoisy,index);
        % pick the best choise
        if obj_plus < obj_minus
            xnew(index) = 0;
        end;
        % If a change is made increase the counter
        if (xnew(index) ~= pix)
            changes = changes +1;
        end;
    end;
    disp(['Num of Changes :', num2str(changes)]);
end;

%calculate total score
total_score = 0;
for i=1:85065
    total_score = total_score +pixelScore(xnew,xnoisy,i);
end;
disp(['Score function:' num2str(total_score)]);

imshow(xnew);
print('image_processed','-dpng')
clear all;