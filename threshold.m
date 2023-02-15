%--------------------------------------------------------------------------
% Module: threshold.m
% Usage: threshold(f, lambda)
% Purpose: Function for preprocessing prior to morphologial operations.
%          Converts a single channel grayscale image to a binary image.
%
% Input Variables:
%   f       input image array
%
% Returned Results:
%   out     output image array
%
% Processing Flow:
% < FILL IN PROCESSING FLOW >
%
% Author: Piyush Nagasubramaniam, Siyuan Hong, Jacky Lin
% Date: 01/25/2023
%--------------------------------------------------------------------------
function [out] = threshold(f, lambda)

[M, N] = size(f);

for x = 1:M
    for y = 1:N
        if f(x,y) < lambda
            out(x,y) = 0;
        else
            out(x,y) = 255;
        end
    end
end

out = uint8(out);
