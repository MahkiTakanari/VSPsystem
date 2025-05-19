function [data, triggerTime, ampWhenTriggered] = ...
    stepFGAmplitudeUntilTrigger(fg, daqObj, initAmp, ampStep, ampMax)
% stepFGAmplitudeUntilTrigger - 振幅を1秒ごとに変化させ、スイッチ反応で停止
%
% 入力:
%   fg       : visadev オブジェクト
%   daqObj   : DAQ セッションオブジェクト
%   initAmp  : 初期振幅 [V]（0なら上昇、1以上なら下降）
%   ampStep  : 振幅変化ステップ [V]
%   ampMax   : 上昇時の最大振幅 [V]
%
% 出力:
%   data              : Nx3 行列 [time, acc, sw]
%   triggerTime       : スイッチが押された時刻 [s]（NaN なら未反応）
%   ampWhenTriggered  : トリガ時の振幅 [V]

    threshold = 1.5;  % スイッチしきい値 [V]
    % 記録用バッファ
    accAll = [];
    swAll  = [];
    tAll   = [];

    tStart = tic;
    triggered = false;

    % シーケンス生成：上昇 or 下降
    if initAmp == 0
        ampSeq = initAmp : ampStep : ampMax;
    else
        ampSeq = initAmp : -ampStep : 0;
    end

    for amp = ampSeq
        % 振幅設定
        writeline(fg, ":PHAS 90");
        writeline(fg, sprintf(":VOLT:AMPL %.3f", amp));
        fprintf("AMPLITUDE SET: %.3f V\n", amp);

        % 1秒間データ取得
        d = read(daqObj, seconds(1.0), "OutputFormat", "Matrix"); % Nx2行列
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
            fprintf("\nTRIGGER DETECTED: %.3f s @ %.2f V\n", triggerTime, amp);
            triggered = true;
            break;
        end

        % 下降終了条件（未トリガで0V到達）
        if initAmp >= 1.0 && amp <= 0
            triggerTime = NaN;
            ampWhenTriggered = amp;
            fprintf("⚠[WARN] DESCENDING seq.: reached 0 V without trigger.\n");
            break;
        end
    end

    % 上昇系列でトリガ未検出だった場合
    if ~triggered && initAmp == 0
        triggerTime = NaN;
        ampWhenTriggered = amp;
        fprintf("⚠[WARN] ASCENDING seq.: no trigger detected (final amplitude: %.2f V)\n", ampWhenTriggered);
    end

    data = [tAll, accAll, swAll];
end
