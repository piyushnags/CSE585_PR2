%--------------------------------------------------------------------------
% Module: classify.m
% Usage: classify(input, target)
% Purpose: Match the images in input to the images in the target
%
% Input Variables:
%   input      File name for input image
%   target     File name for target image
%
% Returned Results:
%   None, prints predictions to console
%
% Processing Flow:
%   1. Calculating the pattern spectrum for each connected component in the
%   target graph.
%   2. Calculating the pattern spectrum for each connected component in the
%   input graph.
%   3. Determine the difference between the input pattern spectrum and
%   target spectrum.
%   4. The minimum MSE of two spectrum will be return as the correct match
%
% Author: Piyush Nagasubramaniam, Siyuan Hong, Jacky Lin
% Date: 02/15/2023
%--------------------------------------------------------------------------

function classify(input, target)
im3 = imread(target);
im3 = round(255*im3);

[L, num_ref_cls] = bwlabel(im3);
% Make 3x3 Structuring Element
B = ones(3,3);
ref = {};
for i = 1:4
    % Get connected components from
    if i == 1
        c = 255*(L == i);
    else
        c = 255*(L == 3*(i-1));
    end
    % Generate size distribution
    sd = size_dist(c, B);
    % Get pecstrum from size distribution
    pec = pecstrum(sd);
    ref{i} = pec(2,:);
end 

% Read match3
im4 = imread(input);
im4 = round(255*im4);

% Get objects into new images
[L, num_c] = bwlabel(im4);
idx = [8 3 2 6];
for i = 1:4
    % Get connected components from
    c = 255*(L == idx(i));
    % Generate size distribution
    sd = size_dist(c, B);
    % Get pecstrum from size distribution
    pec = pecstrum(sd);
    se_size = pec(1,:);
    pec = pec(2,:);

    % Select Weights
    %weight = flip(se_size(1,:)).^2;
    weight = se_size(1,:);
    weight(1:7) = 1;
    weight(8:10) = 2;
    weight(11) = 25;

    % Find the best match image
    score = Inf;
    class = 0;
    for y = 1:4
        % Current reference image to compare
        cur_ref = ref{y};
        % Match the spectrum size
        max_size = max(size(pec, 2), size(cur_ref, 2));
        pec(end+1:max_size+1) = 0;
        cur_ref(end+1:max_size+1) = 0;
        weight(end+1:max_size+1) = 25;
        % Calculate the difference using MSE
        tmp = sqrt(sum(weight.*(pec - cur_ref).^2, 'all'));
        % Record the smaller score representing the smallest difference
        if tmp < score
            score = tmp;
            class = y;
        end
    end
    fprintf('Ground Truth Object: %d Predicted Object: %d.\n',i,class);
end
fprintf('--------------------------------------------------------------\n')
end