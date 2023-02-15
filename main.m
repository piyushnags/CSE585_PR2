clear;

% Read image
im1 = imread("penn256.gif");
im1 = round(im1*255);
imtool(im1)

% Homotopic Skeletonization
load('elem.mat');
out = thin(im1, elem.b1f, elem.b1b);
imtool(out)
sum(im1/255, 'all')
sum(out/255, 'all')

% fn = fieldnames(elem);
% im1_ = im1;
% 
% for i = 1:10
%     for k=1:2:numel(fn)-1
%         im1_ = thin(im1_, elem.(fn{k+1}), elem.(fn{k}));
%     end
% end
% 
% imtool(im1_)