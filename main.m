clear;
%% Homotopic Skeletonization
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

%% Size Distribution, Spectrum and Complexity
im3 = imread('match1.gif');
im3 = round(255*im3);
% imtool(im3)
 
[L, num_ref_cls] = bwlabel(im3);
B = ones(3,3);
ref = {};
for i = 1:num_ref_cls
    % Get connected components from
    c = 255*(L == i);
    % Make 3x3 Structuring Element
    % and generate size distribution
    sd = size_dist(c, B);
    % Plot the size distribution
    % plot_size_dist(sd1);
    % Get pecstrum from size distribution
    pec = pecstrum(sd);
    % Plot the spectrum

    % Get shape complexities for objects
    sh = shape_complexity(pec);
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
    % Make 3x3 Structuring Element
    % and generate size distribution
    sd = size_dist(c, B);
    % Get pecstrum from size distribution
    pec = pecstrum(sd);
    se_size = pec(1,:);
    pec = pec(2,:);
    weight = flip(se_size(1,:)).^2;
    x = 1:11;
    weight = -0.3*(x-4).^3 + 2.5*(x-4).^2 + 2;
    if i == 1
        figure()
        plot(weight)
    end
    
    % Find the best match image
    score = Inf;
    class = 0;
    for y = 1:num_ref_cls
        cur_ref = ref{y};
        max_size = max(size(pec, 2), size(cur_ref, 2));
        min_size = min(size(pec, 2), size(cur_ref, 2));
        
        pec(end+1:max_size+1) = 0;
        cur_ref(end+1:max_size+1) = 0;
        weight(end+1:max_size+1) = 0;

        tmp = sqrt(sum(weight.*(pec - cur_ref).^2, 'all'));
        % Record the smaller score representing the smallest difference
        if tmp < score
            score = tmp;
            class = y;
        end
    end
    i
    class
end 

%%
classify('shadow1.gif', 'shadow1rotated.gif')
