%--------------------------------------------------------------------------
% Module: invert.m
% Usage: invert(f)
% Purpose: Helper function to invert binary image
%
% Input Variables:
%   f       input image array
%
% Returned Results:
%   out     output image array
%
% Processing Flow:
%   1. Convert input to logical array
%   2. Complement all values
%   3. Scale back to uint8 values
%
% Author: Piyush Nagasubramaniam, Siyuan Hong, Jacky Lin
% Date: 01/25/2023
%--------------------------------------------------------------------------
function [out] = invert(f)

% Convert to logical, invert, and scale back to uint8
out = ~(f/255)*255;