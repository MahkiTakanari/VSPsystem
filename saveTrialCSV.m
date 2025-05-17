function saveTrialCSV(trial, data)
% saveTrialCSV - [time, acc, sw] のデータをCSVで保存（列名付き）
% trial: 試行番号（整数）
% data : Nx3 行列 [time, acc, switch]

    filename = sprintf("trial%d.csv", trial);
    T = array2table(data, "VariableNames", {"Time_s", "Accel_V", "Switch_V"});
    writetable(T, filename);
    fprintf("データ保存: %s\n", filename);
end
