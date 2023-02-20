%--------------------------------------------------------------------------
% Module: size_dist.m
% Usage: size_dist(f, B)
% Purpose: Compute granulometry given a structuring element
%
% Input Variables:
%   f       input image array
%   B       Structuring element 
%
% Returned Results:
%   out     output image array
%
% Processing Flow:
%   1. Compute opening of input shape by B until sum of all pixels in input
%      is 0.
%   2. Store the sum of all FG pixels during each iteration and update
%      u vector that stores u(n) for each n.
%
% Author: Piyush Nagasubramaniam, Siyuan Hong, Jacky Lin
% Date: 02/15/2023
%--------------------------------------------------------------------------
function [out] = size_dist(f, B)

f_ = uint8(invert(f));
tmp = zeros('like', f);

[P, Q] = size(B);
r = [P];
s = sum(f/255,'all');

u = [s];

i = 1;
while u(end) ~= 0
    f_ = erode(f_, B);
    f_ = dilate(f_,B);
    
    s = sum(f_ == 0, 'all');
    B = ones(P + i*(P-1), Q + i*(Q-1));

    r(end+1) = P + i*(P-1);
    u(end+1) = s;
    
    i = i + 1;

end

out = [r; u];