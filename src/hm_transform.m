%--------------------------------------------------------------------------
% Module: hm_transform.m
% Usage: hm_transform(f, A, B)
% Purpose: Hit/miss implementation to detect shapes of varying sizes
%
% Input Variables:
%   f       input image array
%   A       Structuring element for hit
%   B       Structuring element for miss
%
% Returned Results:
%   out     output image array
%
% Processing Flow:
%   1. Call invert and store copy of inverted image
%   2. Erode input with A and erode inverted input with B
%   3. Perform logical AND of both intermediate outputs ('hit' and 
%      'miss')
%   4. Iterate through output and set to FG if the corresponding location
%      is FG in the 'hit' and 'miss' result.
%   5. Convert result to uint8
%
% Author: Piyush Nagasubramaniam, Siyuan Hong, Jacky Lin
% Date: 01/25/2023
%--------------------------------------------------------------------------
function [out] = hm_transform(f, A, B)

% Get the image background i.e. X complement
f_ = invert(f);

% Apply erosion on X and X' to get the 'hit'
% and the 'miss' intermediate results.
h = erode(f, A);
m = erode(f_, B);

% Perform logical AND of the 'hit' and 'miss' 
% outputs

[M, N] = size(h);
for x = 1:M
    for y = 1:N
%       If both are FG, then set output to FG.
%       Else, set to BG
        if (h(x,y) == 0) && (m(x,y) == 0)
            out(x,y) = 0;
        else
            out(x,y) = 255;
        end
    end
end
out = uint8(out);

