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