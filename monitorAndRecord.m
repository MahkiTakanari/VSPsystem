function [data, triggerTime] = monitorAndRecord(daqObj, maxDuration, fs)
% monitorAndRecord - DAQでバッファリング → 一括read() → スイッチ入力で終了
%
% 入力:
%   daqObj       : DAQセッションオブジェクト（BufferSizeは外で設定）
%   maxDuration  : 最大計測時間 [s]
%   fs           : サンプリング周波数 [Hz]
%
% 出力:
%   data         : Nx3行列 [time, acc, switch]
%   triggerTime  : スイッチがONになった時刻（秒）

    % 固定のスイッチ判定しきい値
    threshold = 1.5;  % [V]

    fprintf("▶ Recording (up to %.1f s)...\n", maxDuration);

    % 測定スタート
    start(daqObj, "Duration", seconds(maxDuration));
    tStart = tic;

    % 計測終了まで待機（同期実行）
    wait(daqObj, seconds(maxDuration) + seconds(1));  % 余裕を1秒取る
    elapsedTime = toc(tStart);

    % データ取得
    raw = read(daqObj, "OutputFormat", "Matrix");  % Nx2行列
    n = size(raw, 1);
    time = (0:n-1)' / fs;

    % トリガ検出
    sw = raw(:,2);
    idx = find(sw > threshold, 1);

    if isempty(idx)
        triggerTime = NaN;
        fprintf("⚠ No trigger detected (%.1f s)\n", elapsedTime);
    else
        triggerTime = time(idx);
        fprintf("⏱ Trigger detected at %.3f s\n", triggerTime);
    end

    data = [time, raw];  % [time, acc, sw]
end
