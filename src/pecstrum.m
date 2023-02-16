function [out] = pecstrum(sd)

    out(1,:) = sd(1, 1:end-1);
    out(2,:) = sd(2, 2:end) - sd(2,1:end-1);
    
    out(2,:) = -out(2,:)/sd(2,1);
end