function setupFG(fg, freqHz, initAmp)
% setupFG - WF1974の出力条件を設定（SCPI制御）
%
% fg       : visadevオブジェクト
% freqHz   : 設定する周波数 [Hz]
% initAmp  : 初期振幅 [Vpp]

    % リセット
    writeline(fg, '*RST');
    fprintf("設定をリセット\n");

    % 波形とスケーリングの設定
    writeline(fg, ':OUTP:SCAL SIN,PFS');
    fprintf("+FSのSIN波に設定\n");

    % 周波数設定
    writeline(fg, sprintf(':FREQ %.3f', freqHz));
    fprintf("周波数を %.3f Hz に設定\n", freqHz);

    % 初期振幅設定
    writeline(fg, sprintf(':VOLT:AMPL %.3f', initAmp));
    fprintf("初期振幅を %.3f V に設定\n", initAmp);
end
