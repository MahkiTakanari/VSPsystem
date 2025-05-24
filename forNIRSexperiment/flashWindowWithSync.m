function tStart = flashWindowWithSync()

    % フラッシュ用ウィンドウ作成（黒背景、枠なし、画面左下に表示）
    fig = figure('Color', 'black', ...
                 'MenuBar', 'none', ...
                 'ToolBar', 'none', ...
                 'NumberTitle', 'off', ...
                 'Name', 'Flash', ...
                 'Position', [0, 0, 500, 500]); 
    drawnow;
    pause(0.2);  % 黒背景状態（基準）

    fig.Color = 'white';
    drawnow;
    pause(0.2); 


    fig.Color = 'black';
    drawnow;
    pause(0.2);

    tStart = tic; % 同期点

    fig.Color = 'white';
    drawnow;
    pause(0.2);  % 白表示（明転がここで動画に記録される）

    close(fig);
end
