%--------------------------------------------------------------------------
% Module: thin.m
% Usage: thin(f, A, B)
% Purpose: Homotopy preserving skeletonization
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
%   
%
% Author: Piyush Nagasubramaniam, Siyuan Hong, Jacky Lin
% Date: 02/15/2023
%--------------------------------------------------------------------------
function [out] = thin(f, A, B)

f_hm = hm_transform(uint8(invert(f)), A, B);
f_hm = uint8(invert(f_hm));

out = f - f_hm;
