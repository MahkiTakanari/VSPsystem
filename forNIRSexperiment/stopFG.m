function stopFG(fg, initAmp)
% stopFG - WF1974の出力をOFFにする（SCPI制御）

    writeline(fg, ":OUTP OFF");
    writeline(fg, sprintf(":VOLT:AMPL %.3f", initAmp));

    fprintf("\n▶ [stop] FG output OFF\n\n");
end
