function [out] = shape_complexity(pec)

out = sum(-pec(2,:).*log2(pec(2,:)), 'all');