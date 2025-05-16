function initDaq(deviceID, rate, label, duration)
% initDaq - 呼び出し元にDAQオブジェクトを作成（再利用可）
% deviceID: 例 "Dev1"
% rate: 例 8192
% label: 例 "daqObj"
% durationa: BuuferSize を指定するのに使用

    if evalin("caller", sprintf("exist('%s', 'var') && isvalid(%s)", label, label))
        fprintf("REUSE: %s (device: %s)\n", label, deviceID);
        return;
    end

    % 新規作成
    daqObj = daq("ni");
    daqObj.Rate = rate;
    daqObj.BufferSize = rate * duration; % Buffersizeを明示的に指定
    addinput(daqObj, deviceID, "ai0", "Voltage");
    addinput(daqObj, deviceID, "ai1", "Voltage");

    assignin("caller", label, daqObj);
    fprintf("SET: %s (device: %s)\n", label, deviceID);
end
