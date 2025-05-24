function initDaq(deviceID, rate, label)
% initDaq - 呼び出し元にDAQオブジェクトを作成（再利用可）
% deviceID: 例 "Dev1"
% rate: 例 8192
% label: 例 "daqObj"
% durationa: BuuferSize を指定するのに使用

    if evalin("caller", sprintf("exist('%s', 'var') && isvalid(%s)", label, label))
        fprintf("[REUSE] DAQ object '%s' (device: %s)\n\n", label, deviceID);
        return;
    end

    % 新規作成
    fprintf("[CONNECTING] Initializing DAQ session...\n");
    daqObj = daq("ni");
    daqObj.Rate = rate;
    addinput(daqObj, deviceID, "ai0", "Voltage");
    addinput(daqObj, deviceID, "ai1", "Voltage");

    assignin("caller", label, daqObj);
    fprintf("[SET] DAQ object '%s' (device: %s) created and ready.\n\n", label, deviceID);
end
