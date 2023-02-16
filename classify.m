function classify(input, target)
im3 = imread(target);
im3 = round(255*im3);

[L, num_ref_cls] = bwlabel(im3);
B = ones(3,3);
ref = {};
for i = 1:num_ref_cls
    % Get connected components from
    c = 255*(L == i);
    % Make 3x3 Structuring Element
    % and generate size distribution
    sd = size_dist(c, B);
    % Get pecstrum from size distribution
    pec = pecstrum(sd);
    ref{i} = pec(2,:);
end 

% plot_size_dist(sd1);

% Read match3
im4 = imread(input);
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
    pec = pec(2,:);
    score = Inf;
    class = 0;
    for y = 1:num_ref_cls
        cur_ref = ref{y};
        max_size = max(size(pec, 2), size(cur_ref, 2));
        
        pec(end+1:max_size+1) = 0;
        cur_ref(end+1:max_size+1) = 0;

%         weight = pec(1,:)/max(pec(1,:));
%         weight(end+1:max_size+1) = 1;
        weight = ones('like', pec);
        tmp = sqrt(sum(weight.*(pec - cur_ref).^2, 'all'));
        if tmp < score
            score = tmp;
            class = y;
        end
    end
    i
    class
end 
end