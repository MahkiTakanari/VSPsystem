% === 初期化 ===
numTrials = 3; % 必要なら input() で変更可
deviceID = "Dev1";
rate = 8192;
initDaq(deviceID, rate, "daqObj");
fg = initializeFG("COM5");          % FGのシリアルポートを指定

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
