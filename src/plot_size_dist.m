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