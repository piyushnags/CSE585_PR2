%--------------------------------------------------------------------------
% Module: pecstrum.m
% Usage: pecstrum(sd)
% Purpose: Determine the pecstrum of a shape based on a size distribution
%
% Input Variables:
%   sd     size distribution of a shape
%
% Returned Results:
%   out     pecstrum of the shape
%
% Processing Flow:
%   1. Remove last n value
%   2. Compute output as difference between every pair of consecutive
%      elements.
%   3. Normalize by dividing by negative of max area
%
% Author: Piyush Nagasubramaniam, Siyuan Hong, Jacky Lin
% Date: 02/15/2023
%--------------------------------------------------------------------------
function [out] = pecstrum(sd)

    out(1,:) = sd(1, 1:end-1);
    out(2,:) = sd(2, 2:end) - sd(2,1:end-1);
    
    out(2,:) = -out(2,:)/sd(2,1);
end