function saveTrialCSV(trial, data, folder)
% saveTrialCSV - [time, acc, sw] のデータをCSVで保存（列名付き）
% trial: 試行番号（整数）
% data : Nx3 行列 [time, acc, switch]
% folder: 保存先フォルダ（存在しなければ作成）

    if nargin < 3
        folder = ".";  % デフォルトはカレントフォルダ
    end
    if ~exist(folder, "dir")
        mkdir(folder);
    end

    filename = fullfile(folder, sprintf("trial%d.csv", trial));
    T = array2table(data, 'VariableNames', {'Time_s', 'Accel_V', 'Switch_V'});
    writetable(T, filename);
    fprintf("SAVED: %s\n", filename);
end
