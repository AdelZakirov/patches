function dcm_number = HowManyDcms(d)
    d = struct2cell(d);
    d = d(1,:);
    ind1 = cellfun(@(cc) length(cc)<3,d,'UniformOutput', false);
    ind1 = cell2mat(ind1);
    ind2 = find(~ind1);
    d1 = d(ind2);
    ind3 = cellfun(@(cell) strcmp(cell(end-2:end),'dcm'),d1,'UniformOutput', false);
    dcm_number = sum(cell2mat(ind3));
end