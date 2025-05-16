function initFG(portName, label)
% initFG - ファンクションジェネレータ（WF1974）へのシリアル接続を初期化
% portName: 例 "COM5"
% label: 呼び出し元で使用する変数名（例："fg"）

    % すでに有効な接続があれば再利用
    if evalin("caller", sprintf("exist('%s', 'var') && isvalid(%s)", label, label))
        fprintf("REUSE: %s (port: %s)\n", label, portName);
        return;
    end

    % シリアルポートオブジェクトを作成
    fg = serialport(portName, 9600);  % WF1974 のデフォルトボーレート（変更時は調整）
    configureTerminator(fg, "CR/LF");
    flush(fg);  % バッファクリア

    assignin("caller", label, fg);
    fprintf("SET: %s (port: %s)\n", label, portName);
end
