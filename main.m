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

% Get connected components from
% match1
c1 = 255*(L == 1);
c2 = 255*(L == 2);
c3 = 255*(L == 3);
c4 = 255*(L == 4);

% imtool(c1)
% imtool(c2)
% imtool(c3)
% imtool(c4)

% Make 3x3 Structuring Element
% and generate size distribution
B = ones(3,3);
sd1 = size_dist(c1, B);
sd2 = size_dist(c2, B);
sd3 = size_dist(c3, B);
sd4 = size_dist(c4, B);

plot_size_dist(sd1);

% Get pecstrum from size distribution
pec1 = pecstrum(sd1);
pec2 = pecstrum(sd2);
pec3 = pecstrum(sd3);
pec4 = pecstrum(sd4);

[M, N] = zeros(pec1);
ref = zeros(M, N, 4);
ref(:,:,1) = pec1;
ref(:,:,2) = pec2;
ref(:,:,3) = pec3;
ref(:,:,4) = pec4;

% Get shape complexities for objects
sh1 = shape_complexity(pec1);
sh2 = shape_complexity(pec2);
sh3 = shape_complexity(pec3);
sh4 = shape_complexity(pec4);

% Read match3
im4 = imread('match3.gif');
im4 = round(255*im4);

% Get objects into new images
[L, num_c] = bwlabel(im4);
c1_ = (L == 1);
c2_ = (L == 2);
c3_ = (L == 3);
c4_ = (L == 4);

% imtool(c1_)
% imtool(c2_)
% imtool(c3_)
% imtool(c4_)

% Make 3x3 Structuring Element
% and generate size distribution
B = ones(3,3);
sd1_ = size_dist(c1_, B);
sd2_ = size_dist(c2_, B);
sd3_ = size_dist(c3_, B);
sd4_ = size_dist(c4_, B);

% Get pecstrum from size distribution
pec1_ = pecstrum(sd1_);
[M,N] = size(pec1_);
pec_list = zeros(M,N,4);
pec_list(:,:,1) = pec1_;
pec_list(:,:,2) = pec2_;
pec_list(:,:,3) = pec3_;
pec_list(:,:,4) = pec4_;

% Find matching object from pecstrum
for x = 1:4
    curr = pec_list(:,:,x);
    score = Inf;
    class = 0;
    
    for y = 1:4
        tmp = sqrt(sum((curr - ref(:,:,y)).^2, 'all'));
        if tmp < score
            score = tmp;
            class = y;
        end
    end
end
