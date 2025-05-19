function setupFG(fg, freqHz, initAmp)
% setupFG - WF1974の出力条件を設定（SCPI制御）
%
% fg       : visadevオブジェクト
% freqHz   : 設定する周波数 [Hz]
% initAmp  : 初期振幅 [Vpp]

    fprintf("\n========== FG SETUP ==========\n");
    % リセット
    writeline(fg, '*RST');
    writeline(fg, ":OUTP OFF");
    fprintf("✔ Reset complete\n");

    % 波形とスケーリングの設定
    writeline(fg, ':OUTP:SCAL SIN,PFS');
    fprintf("✔ Waveform set to SIN with +FS\n");

    % 周波数設定
    writeline(fg, sprintf(':FREQ %.3f', freqHz));
    fprintf("✔ Frequency: %.1f Hz\n", freqHz);

    % 初期振幅設定
    writeline(fg, sprintf(':VOLT:AMPL %.3f', initAmp));
    fprintf("✔ Initial amplitude: %.2f V\n", initAmp);
    fprintf("================================\n\n");
    pause(3)
end
