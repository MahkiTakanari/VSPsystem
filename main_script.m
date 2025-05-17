% === 初期化 ===

deviceID = "Dev1";
maxduration = 180; % 1試行の測定にかかる最大時間
visaAddress = "USB0::0x0D4A::0x000E::9113588::INSTR";

numTrials = 3; % 必要なら input() で変更可
rate = 8192; % サンプリング周波数
freqHz = 100;     % 周波数 [Hz]
initAmp = 0.0;    % 初期振幅 [Vpp]

initDaq(deviceID, rate, "daqObj", maxduration);
initFG(visaAddress, "fg");

setupFG(fg, freqHz, initAmp);


% === 試行ループ ===
for trial = 1:numTrials
    fprintf("\n=== Trial %d ===\n", trial);

    % FG出力開始（0.5V/sで上昇）
    startFG(fg);

    % データ計測・トリガ監視
    [data, triggerTime] = monitorAndRecord(daqSession, 180, 8192, 1.5);

    % FGの振幅をキープ（印加停止せず、現在値保持）
    holdVoltageFG(fg);

    % データ保存
    saveTrialCSV(trial, data);
    saveTriggerTime(trial, triggerTime);

    % FG停止
    stopFG(fg);

    pause(2); % 次試行まで少し休止
end

disp("✅ All trials completed.");
