clear;
addpath('imgs/','src/')
%% Homotopic Skeletonization
% Read image 1: Penn256
im1 = imread("bear.gif");
im1 = round(im1*255);
% imtool(im1)

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

imshow(im1_)
saveas(gcf,'bearSk.png')
%% Size Distribution, Spectrum and Complexity
im3 = imread('match1.gif');
im3 = round(255*im3);
% imtool(im3)

% Label connected Componenet
[L, num_ref_cls] = bwlabel(im3);
% Make 3x3 Structuring Element
B = ones(3,3);
ref = {};

for i = 1:num_ref_cls
    % Get connected components from
    c = 255*(L == i);
    imtool(c)
    % Make 3x3 Structuring Element
    % and generate size distribution
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



%%
% Read match3
im4 = imread('match3.gif');
im4 = round(255*im4);

% Get objects into new images
[L, num_c] = bwlabel(im4);
for i = 1:num_c
    % Get connected components from
    c = 255*(L == i);
%     imtool(c)
    % Generate size distribution
    sd = size_dist(c, B);
    % Get pecstrum from size distribution
    pec = pecstrum(sd);
    se_size = pec(1,:);
    pec = pec(2,:);
%     pec
    
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
    fprintf('Input %d matches %d.\n',i,class);
end 

%%
classify('shadow1.gif', 'shadow1rotated.gif')
