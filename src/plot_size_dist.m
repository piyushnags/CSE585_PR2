%--------------------------------------------------------------------------
% Module: plot_size_dist.m
% Usage: plot_size_dist(size_dist, fname)
% Purpose: Plot the size distribution
%
% Input Variables:
%   size_dist   Size distribution of a image as 2d array
%   fname       File name for saving
%
% Returned Results:
%   None
%
% Processing Flow:
%   1. Plot the size distribution as step funcion
%   2. Save as given file
%
% Author: Piyush Nagasubramaniam, Siyuan Hong, Jacky Lin
% Date: 02/15/2023
%--------------------------------------------------------------------------

function plot_size_dist(size_dist, fname)
    figure()
    st = 0;
    hold on
    r = size_dist(1,1:end);
    u = size_dist(2,1:end);
    for i = 1:numel(r) - 1
        stp = r(i);
        plot([st stp], [u(i) u(i)], 'k-', 'LineWidth', 2);
        plot(stp, u(i), 'ok', 'MarkerSize', 6, 'MarkerFaceColor','k');
        plot(stp, u(i+1), 'ok', 'MarkerSize', 6, 'LineWidth', 2);
        st = stp;
    end
    plot(st, u(end), 'ok');
    plot([st r(end)], [u(end) u(end)], 'k-', 'LineWidth', 2);
    hold off
    xlabel('r');
    ylabel('u(r)');
    saveas(gcf,fname);
    close all
end