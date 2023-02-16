%--------------------------------------------------------------------------
% Module: erode.m
% Usage: erode(f, sel)
% Purpose: Erode function to be used as part of a close filter
%          and for performing the hit/miss transform
%
% Input Variables:
%   f       input image array
%   sel     structuring element (logical array)
%
% Returned Results:
%   out     output image array
%
% Processing Flow:
%   1. Initialize BG of output since all locations won't be operated on
%   2. Determine valid bounds of the image when iterating using the
%      structuring element.
%   3. Perform logical AND with the filter iteratively at all valid 
%      locations. Track valid pixel hits.
%   4. For a given location, if the number of hits is same as the sum 
%      of the structuring element, set corresponding output value to
%      FG (0 in this case)
%   5. Convert output to uint8
%
% Author: Piyush Nagasubramaniam, Siyuan Hong, Jacky Lin
% Date: 01/25/2023
%--------------------------------------------------------------------------

% TODO: Add support for asymmetric structuring elements
% Note: Implementation for non-standard structuring elements already
% implemented. Just need to write a function to reflect the logical
% array.

function [out] = erode(f, sel)

[M, N] = size(f);

% Set background value to WHITE (255)
for x = 1:M
    for y = 1:N
        out(x,y) = 255;
    end
end

% Get size of structuring element
[P, Q] = size(sel);

% Choose valid bounds when iterating
% through the image
xlo = 1 + (P-1)/2;
xhi = M - (P-1)/2;
ylo = 1 + (Q-1)/2;
yhi = N - (Q-1)/2;

% Iterate through the image
for x = xlo:xhi
    for y = ylo:yhi
        s = 0;
        
%       If input is FG at all relevant locations of structuring element 
%       (based on where structuring element is a logical 1), increase temp
%       counter s by 1.
        for i = -((P-1)/2):((P-1)/2)
            for j = -((Q-1)/2):((Q-1)/2)
                if ~(f(x+i, y+j)/255)*sel(i+1+((P-1)/2), j+1+((Q-1)/2))==1
                    s = s + 1;
                end
            end
        end

%       If sum of structuring element is same as counter, then set output
%       to FG, else set output to BG
        if s == sum(sel, 'all')
            out(x,y) = 0;
        else
            out(x,y) = 255;
        end

    end
end

out = uint8(out);
