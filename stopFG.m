function stopFG(fg)
% stopFG - WF1974の出力をOFFにする（SCPI制御）

    writeline(fg, ":OUTP OFF");
    fprintf("⏹️ FG出力OFF\n");
end
