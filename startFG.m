function startFG(fg)
% startFG - WF1974の出力をONにする（SCPI制御）

    writeline(fg, ":OUTP ON");
    fprintf("▶ [start] FG output ON\n\n");
end
