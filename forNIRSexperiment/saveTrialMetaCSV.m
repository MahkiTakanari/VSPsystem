function saveTrialMetaCSV(trial, triggerTime, ampWhenTriggered, stimDelay, folder)
% saveTriggerTime - トリガ関連情報をCSVで保存（1行3列）
% trial: 試行番号
% triggerTime: トリガ時刻 [s]
% ampWhenTriggered: トリガ時の振幅 [V]
% stimDelay: フラッシュから刺激開始までの遅延 [s]
% folder: 保存フォルダ

    if nargin < 5
        folder = ".";
    end
    if ~exist(folder, "dir")
        mkdir(folder);
    end

    filename = fullfile(folder, sprintf("trial%d_meta.csv", trial));

    % ヘッダ付き1行CSVとして保存
    fid = fopen(filename, "w");
    fprintf(fid, "triggerTime_s,ampWhenTriggered_V,stimDelay_s\n");
    fprintf(fid, "%.6f,%.6f,%.6f\n", triggerTime, ampWhenTriggered, stimDelay);
    fclose(fid);

    fprintf("META SAVED (CSV): %s\n", filename);
end
