function saveTriggerTime(trial, triggerTime)
% saveTriggerTime - トリガ時刻（秒）をテキストファイルに保存（数値のみ）
% trial: 試行番号
% triggerTime: トリガ時刻 [s]

    filename = sprintf("trial%d_meta.txt", trial);
    fid = fopen(filename, "w");
    fprintf(fid, "%.6f\n", triggerTime);
    fclose(fid);

    fprintf("トリガ時刻保存（数値のみ）: %s\n", filename);
end
