
% === 実験パラメータ ===
visaAddress = "USB0::0x0D4A::0x000E::9113588::INSTR";  % FGのVISAアドレス
daqDevice = "Dev1";      % DAQデバイス名
fs = 8192;               % サンプリング周波数
duration = 180;          % 最大記録時間（上限）
freqHz = 100;            % 出力波の周波数
initAmp = 0.0;           % 初期振幅
ampStep = 0.5;           % 振幅の増加ステップ（V）
ampMax = 5.0;            % 最大振幅（V）
numTrials = 3;           % 試行回数

% === 初期化 ===
initDaq(daqDevice, fs, "daqObj", duration);
initFG(visaAddress, "fg");
setupFG(fg, freqHz, initAmp);

% === 試行ループ ===
for trial = 1:numTrials
    fprintf("\n===== Trial %d =====\n", trial);

    startFG(fg);

    % 振幅上昇＋トリガ検出＋データ取得
    [data, triggerTime, ampWhenTriggered] = ...
        stepFGAmplitudeUntilTrigger(fg, daqObj, fs, threshold, ampStep, ampMax);

    % トリガ後10秒間その振幅で保持
    fprintf("Holding %.1f V for 10 seconds...\n", ampWhenTriggered);
    pause(10);

    % データ保存
    saveTrialCSV(trial, data);
    saveTriggerTime(trial, triggerTime);

    stopFG(fg);

    pause(2);  % 次試行までのインターバル
end

disp("✅ All trials completed.");
