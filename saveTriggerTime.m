function saveTriggerTime(trial, triggerTime, folder)
% saveTriggerTime - トリガ時刻 [s] をテキストで保存（数値のみ）
% trial: 試行番号（整数）
% triggerTime: トリガ時刻（秒）
% folder: 保存先フォルダ（存在しなければ作成）

    if nargin < 3
        folder = ".";
    end
    if ~exist(folder, "dir")
        mkdir(folder);
    end

    filename = fullfile(folder, sprintf("trial%d_meta.txt", trial));
    fid = fopen(filename, "w");
    fprintf(fid, "%.6f\n", triggerTime);  % 数値のみ
    fclose(fid);
    fprintf("トリガ時刻保存: %s\n", filename);
end
