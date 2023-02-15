clear;

% Read image
im1 = imread("penn256.gif");
im1 = round(im1*255);
imtool(im1)

% Homotopic Skeletonization
load('elem.mat');

fn = fieldnames(elem);
[M, N] = size(im1);
im1_ = thin(im1, elem.(fn{2}), elem.(fn{1}));
next = im1;

while ~isequal(im1_, next)
    next = im1_;
    for k=3:2:numel(fn)-1
        im1_ = thin(im1_, elem.(fn{k+1}), elem.(fn{k}));
    end
end

imtool(im1_)