function plot_size_dist(size_dist)
    figure()
    st = 0;
    hold on
    r = size_dist(1,1:end);
    u = size_dist(2,1:end);
    for i = 1:numel(r) - 1
        stp = r(i);
        plot([st stp], [u(i) u(i)], 'k-', 'LineWidth', 6);
        plot(stp, u(i), 'ok', 'MarkerSize', 20, 'MarkerFaceColor','k');
        plot(stp, u(i+1), 'ok', 'MarkerSize', 20, 'LineWidth', 6);
        st = stp;
    end
    plot(st, u(end), 'ok');
    plot([st r(end)], [u(end) u(end)], 'k-', 'LineWidth', 6);
    hold off
    xlabel('r');
    ylabel('u(r)');
    fontsize(gca,20,"pixels")
end