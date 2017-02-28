function json = importJson(path)
    fid = fopen(path);
    raw = fread(fid,inf);
    str = char(raw');
    fclose(fid);
    json = loadjson(str);
end