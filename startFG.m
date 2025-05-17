function startFG(fg)
% startFG - WF1974の出力をONにする（SCPI制御）

    writeline(fg, ":OUTP ON");
    fprintf("▶ FG出力ON\n");
end
