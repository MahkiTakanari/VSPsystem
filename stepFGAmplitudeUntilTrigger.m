function [data, triggerTime, ampWhenTriggered] = ...
    stepFGAmplitudeUntilTrigger(fg, daqObj, initAmp, ampStep, ampMax)
% stepFGAmplitudeUntilTrigger - 振幅を1秒ごとに増加し、スイッチ反応で停止
%
% 入力:
%   fg       : visadev オブジェクト
%   daqObj   : DAQ セッションオブジェクト
%   fs       : サンプリング周波数 [Hz]
%   ampStep  : 振幅増加ステップ [V]
%   ampMax   : 最大振幅 [V]
%
% 出力:
%   data              : Nx3 行列 [time, acc, sw]
%   triggerTime       : スイッチが押された時刻 [s]（NaN なら未反応）
%   ampWhenTriggered  : トリガ時の振幅 [V]

    % 固定しきい値
    threshold = 1.5;  % [V]

    % 記録用バッファ
    accAll = [];
    swAll  = [];
    tAll   = [];

    tStart = tic;
    triggered = false;

    for amp = initAmp : ampStep : ampMax
        % 振幅を更新
        writeline(fg, sprintf(":PHAS 90"));  % 中心からスタート
        writeline(fg, sprintf(":VOLT:AMPL %.3f", amp));
        fprintf("振幅設定: %.3f V\n", amp);

        % 1秒間データ取得
        d = read(daqObj, seconds(1.0), "OutputFormat", "Matrix");  % Nx2
        n = size(d,1);
        tNow = toc(tStart);
        tSegment = linspace(tNow - 1, tNow, n)';

        accAll = [accAll; d(:,1)];
        swAll  = [swAll;  d(:,2)];
        tAll   = [tAll;   tSegment];

        % トリガ検出
        trigIdx = find(d(:,2) > threshold, 1);
        if ~isempty(trigIdx)
            absIdx = length(swAll) - n + trigIdx;
            triggerTime = tAll(absIdx);
            ampWhenTriggered = amp;
            fprintf("トリガ検出: %.3f s @ %.2f V\n", triggerTime, amp);
            triggered = true;
            break;
        end
    end

    if ~triggered
        triggerTime = NaN;
        ampWhenTriggered = amp;  % 最終振幅
        fprintf("トリガ未検出（最大振幅 %.1f V）\n", ampWhenTriggered);
    end

    data = [tAll, accAll, swAll];
end
