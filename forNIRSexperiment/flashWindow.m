t_start = tic;

fig = figure('Color', 'black', 'MenuBar', 'none', ...
             'ToolBar', 'none', 'NumberTitle', 'off', ...
             'Name', 'Flash', 'Position', [25, 25, 200, 200]);
t1 = toc(t_start);
fprintf("figure表示まで: %.4f sec\n", t1);

drawnow;
t2 = toc(t_start);
fprintf("drawnowまで: %.4f sec\n", t2);

pause(0.1);
t3 = toc(t_start);
fprintf("⏸ pause終了まで: %.4f sec\n", t3);

close(fig);
t4 = toc(t_start);
fprintf("❌ closeまで: %.4f sec\n", t4);