function varargout = patches(folder, range, trainOrtest, patches_res)
cutted_patches_res = [];
% patches_on_one_image = [];
    for i = range
        ImagePath = strcat('dataset\', folder, '\image', int2str(i));
        [lungContourLocal, Image, pathologiesContour] = imagePreProcessing2(ImagePath, folder, i);
        if(~isempty(pathologiesContour))
            roiPathology = roipoly(Image,round(pathologiesContour{1}.XCoordinates),round(pathologiesContour{1}.YCoordinates));
        end
        roiLeftLung = roipoly(Image,round(lungContourLocal(1).XCoordinates),round(lungContourLocal(1).YCoordinates));
        roiRightLung = roipoly(Image,round(lungContourLocal(2).XCoordinates),round(lungContourLocal(2).YCoordinates));
        roiLung = roiLeftLung + roiRightLung;
        roi = roiLung;
        if(~isempty(pathologiesContour))
            roi = roiLung + roiPathology;
        end
%         Image = image_normalization2(Image, energyReference, 6);
        patchCoordinates = coords2(Image, 32, 64);
        patchCoordinates = num2cell(patchCoordinates, 2);
        class = cellfun(@(coords) getRoundMean(coords, roi), patchCoordinates, 'UniformOutput', false);
        class = cell2mat(class);
        %% for pathology
%         if(~isempty(pathologiesContour))
%             if(strcmp(trainOrtest, 'train'))
%                 roiIndex = class == 2;
%             else
%                 roiIndex = class > 0;
%             end
%         else
%             roiIndex = class == 1;
%         end
%         Image(~roiPathology) = 0;
        %% for norms
        roiIndex = class == 1;
        Image(roiPathology) = 0;
        Image(~roiLung) = 0;
        %%
        
        patchCoordinatesClassification = patchCoordinates(roiIndex);
%         ImageFiltered = {Image};
        cutted_patches = cellfun(@(coords) cut_image(coords, Image), patchCoordinatesClassification, 'UniformOutput', false);
        kk = 0;
        for k = 1:length(cutted_patches)
            if( sum(cutted_patches{k,1}(:)>0) == 64*64 ) % for norms
                kk = kk + 1; % for norms
                name = strcat('patches\norms_infiltration\',int2str(i),'_',int2str(kk),'.png');
                imwrite(cutted_patches{k,1},name)
            end
            if(kk == patches_res(i))
                break
            end
        end
%         patches_on_one_image = [patches_on_one_image, kk];
        cutted_patches = [];
    end
    varargout{1} = patches_on_one_image';
end