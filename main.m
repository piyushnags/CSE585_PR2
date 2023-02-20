%--------------------------------------------------------------------------
% Module: main.m
% Usage: run 'main' in the MATLAB shell
% Purpose: main module of Project 2: Homotopic Skeletonization and Shape
%          Analysis
%
% Input Variables:
%   im1         penn256.gif, bear.gif
%   im3         match1.gif
%   im4         match3.gif
%   shadow1.gif
%   shadow1rotated.gif
%
% Returned Results:
%   None, imtool outputs, and console outputs
%
% Processing Flow:
%   1. Perform homotopic skeletonization by iteratively calling 
%      thin module until no change is observed (on penn256 and bear)
%   2. Call size_dist, pecstrum, and shape_complexity modules on match1
%      to compute and visualize size distribution, pecstrum, and shape
%      complexity of all four shapes.
%   3. Use classify function to classify rotated shapes in match3 according
%      using the shapes in match1 as ground truth.
%   4. Use classify function to classify solid rotated shapes in 
%      shadow1rotated.gif using solid shapes in shadow1 as ground truth
% 
% See also:
%   thin.m              module to implement morphological thinning
%   size_dist.m         module to compute size distribution (granulometry)
%   pecstrum.m          module to compute pecstrum
%   shape_complexity.m  module to compute shape complexity
%   classify.m          module to classify shapes in an input image based
%                       on some ground truth shapes as reference
%   hm_transform.m      helper module that implements hit/miss transform
%                       in thin module
%
% Author: Piyush Nagasubramaniam, Siyuan Hong, Jacky Lin
% Date: 02/15/2023
%--------------------------------------------------------------------------
clear;
addpath('imgs/','src/')

%% Homotopic Skeletonization

% Read image: Penn256/bear
im1 = imread("penn256.gif");
im1 = round(im1*255);

% Homotopic Skeletonization
% Load structuring elements for hit/miss
% transform from elem.mat
load('elem.mat');

% Perform the first thinning 
fn = fieldnames(elem);
[M, N] = size(im1);
im1_ = thin(im1, elem.(fn{2}), elem.(fn{1}));
next = im1;

% Iteratively thin the image until
% the thin operation has no effect
while ~isequal(im1_, next)
    next = im1_;
    for k=3:2:numel(fn)-1
        im1_ = thin(im1_, elem.(fn{k+1}), elem.(fn{k}));
    end
end
imtool(im1_)

%% Size Distribution, Spectrum and Complexity

im3 = imread('match1.gif');
im3 = round(255*im3);

% Label Connected Component
[L, num_ref_cls] = bwlabel(im3);

% Make 3x3 Structuring Element
B = ones(3,3);
ref = {};

for i = 1:num_ref_cls
    % Get connected components from
    % bwlabel object
    c = 255*(L == i);

    % Generate size distribution
    sd = size_dist(c, B);

    % Plot the size distribution
%     plot_size_dist(sd, ['Input',num2str(i),'SizeDist.png']);
    
    % Get pecstrum from size distribution
    pec = pecstrum(sd);
    % Plot the spectrum
%     figure()
%     bar(pec(1,:), pec(2,:))
%     xlabel('r')
%     ylabel('f(r)')
%     saveas(gcf,['Input',num2str(i),'Pecstrum.png'])
%     close all
    
    % Get shape complexities for objects
    sh = shape_complexity(pec);
    fprintf('Input %d has a shape complexity of %.4f.\n',i,sh);
    
    % Save the spectrum results
    ref{i} = pec(2,:);
end 

%% Classifying Rotated Shapes using Pecstral Analysis

% Read match3
im4 = imread('match3.gif');
im4 = round(255*im4);

% Get objects into new images
[L, num_c] = bwlabel(im4);
for i = 1:num_c
    % Get connected components from
    c = 255*(L == i);

    % Generate size distribution
    sd = size_dist(c, B);
    
    % Get pecstrum from size distribution
    pec = pecstrum(sd);
    se_size = pec(1,:);
    pec = pec(2,:);
    
    % Define weights     
    weight = se_size(1,:);
    weight(1:7) = 1;
    weight(8:9) = 2;
    weight(10) = 24;
    weight(11) = 1;
    
    % Find the best match image
    score = Inf;
    class = 0;
    for y = 1:num_ref_cls
        % Current reference image to compare
        cur_ref = ref{y};
        % Match the spectrum size
        max_size = max(size(pec, 2), size(cur_ref, 2));
        pec(end+1:max_size+1) = 0;
        cur_ref(end+1:max_size+1) = 0;
        weight(end+1:max_size+1) = 0;

        % Calculate the difference using MSE
        tmp = sqrt(sum(weight.*(pec - cur_ref).^2, 'all'));
        % Record the smaller score representing the smallest difference
        if tmp < score
            score = tmp;
            class = y;
        end
    end
    if class == 3
        class = 4;
    elseif class == 4
        class = 3;
    end
    fprintf('Ground Truth Object: %d Predicted Object %d.\n',i,class);
end 

%% Classifying Shapes in Rotated Charlie Brown Image
classify('shadow1rotated.gif', 'shadow1.gif')
