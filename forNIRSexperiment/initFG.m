function initFG(visaAddress, label)
% initFG - visadev を使って WF1974 に接続し、呼び出し元にオブジェクトを作成
% visaAddress: 例 "USB0::0x0D4A::0x000E::1234567::INSTR"
% label: 呼び出し元で使いたい変数名（例："fg"）

    % すでに有効な接続があれば再利用
    if evalin("caller", sprintf("exist('%s', 'var') && isvalid(%s)", label, label))
        fprintf("[REUSE] FG object '%s' (VISA: %s)\n\n", label, visaAddress);
        return;
    end

    % FGオブジェクトの作成
    fprintf("[CONNECTING] Establishing VISA connection to FG...\n");
    % if ~isempty(visadevfind)
    %     delete(visadevfind);
    % end
    fg = visadev(visaAddress);
    configureTerminator(fg, "LF");
    flush(fg);  % バッファクリア

    assignin("caller", label, fg);
    fprintf("[SET] FG object '%s' (VISA: %s) created and ready.\n\n", label, visaAddress);
end
