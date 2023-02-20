%--------------------------------------------------------------------------
% Module: shape_complexity.m
% Usage: shape_complexity(pec)
% Purpose: Determine shape complexity based on a given pecstrum
%
% Input Variables:
%   pec     pecstrum of an image
%
% Returned Results:
%   out     shape complexity (scalar)
%
% Processing Flow:
%   1. Evaluate the shape complexity as the sum of the log probabilities
%      weighted by the respective probabilities.
%
% Author: Piyush Nagasubramaniam, Siyuan Hong, Jacky Lin
% Date: 02/15/2023
%--------------------------------------------------------------------------
function [out] = shape_complexity(pec)

out = sum(-pec(2,:).*log2(pec(2,:)), 'all');