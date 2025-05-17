function initFG(visaAddress, label)
% initFG - visadev を使って WF1974 に接続し、呼び出し元にオブジェクトを作成
% visaAddress: 例 "USB0::0x0D4A::0x000E::1234567::INSTR"
% label: 呼び出し元で使いたい変数名（例："fg"）

    % すでに有効な接続があれば再利用
    if evalin("caller", sprintf("exist('%s', 'var') && isvalid(%s)", label, label))
        fprintf("REUSE: %s (VISA: %s)\n", label, visaAddress);
        return;
    end

    % シリアルポートオブジェクトを作成
    fg = visadev(visaAddress);
    configureTerminator(fg, "LF");
    flush(fg);  % バッファクリア

    assignin("caller", label, fg);
    fprintf("SET: %s (VISA: %s)\n", label, visaAddress);
end
