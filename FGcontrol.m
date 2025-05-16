% VISAリソース名（NI MAXで確認したものに合わせて書き換え）
visaAddress = "USB0::0x0D4A::0x000E::9113588::INSTR";  % 例：WF1974

% visadevオブジェクト作成
dev = visadev(visaAddress);

% 終端文字の設定（WF1974はLFが必要）
configureTerminator(dev, "LF");

% 通信確認（IDN確認）
writeline(dev, "*IDN?");
idn = readline(dev);
disp("識別応答: " + idn);

% 出力ON
writeline(dev, ":OUTP ON");

% 一時停止（1秒）
pause(1);

% 出力OFF
writeline(dev, ":OUTP OFF");

% オブジェクト削除（明示的に）
clear dev
