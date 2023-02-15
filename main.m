clear;

% Read image 1: Penn256
% im1 = imread("penn256.gif");
% im1 = round(im1*255);
% imtool(im1)

% Homotopic Skeletonization
% load('elem.mat');
% 
% fn = fieldnames(elem);
% [M, N] = size(im1);
% im1_ = thin(im1, elem.(fn{2}), elem.(fn{1}));
% next = im1;

% while ~isequal(im1_, next)
%     next = im1_;
%     for k=3:2:numel(fn)-1
%         im1_ = thin(im1_, elem.(fn{k+1}), elem.(fn{k}));
%     end
% end
% 
% imtool(im1_)

im3 = imread('match1.gif');
im3 = round(255*im3);
imtool(im3)

[L, num_c] = bwlabel(im3);

c1 = 255*(L == 1);
c2 = 255*(L == 2);
c3 = 255*(L == 3);
c4 = 255*(L == 4);

% imtool(c1)
% imtool(c2)
% imtool(c3)
% imtool(c4)

B = ones(3,3);
sd = size_dist(c1, B);
