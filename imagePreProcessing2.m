function varargout = imagePreProcessing2(originalImagePath, folder,ImageNumber)
    originalImage = im2double(dicomread(strcat(originalImagePath, '.dcm')));
    lungContour = RkbDataset.getLungContours(originalImagePath);
    pathologiesContour = RkbDataset.getPathologiesContour(folder,ImageNumber,ImageNumber);
    [leftUpXY, croppedImage] = cropImage(originalImage, lungContour);
    lungContourLocal(1).XCoordinates = lungContour(1).XCoordinates - leftUpXY(1);
    lungContourLocal(2).XCoordinates = lungContour(2).XCoordinates - leftUpXY(1);
    lungContourLocal(1).YCoordinates = lungContour(1).YCoordinates - leftUpXY(2);
    lungContourLocal(2).YCoordinates = lungContour(2).YCoordinates - leftUpXY(2);
    if(~isempty(pathologiesContour))
        for i = 1:length(pathologiesContour)
            pathologiesContour{i}.XCoordinates = pathologiesContour{i}.XCoordinates - leftUpXY(1);
            pathologiesContour{i}.YCoordinates = pathologiesContour{i}.YCoordinates - leftUpXY(2);
        end
    end
    [H,W] = size(croppedImage);
    croppedImage = imresize(croppedImage, [1024 1024]);
    lungContourLocal(1).XCoordinates = lungContourLocal(1).XCoordinates*1024/W;
    lungContourLocal(2).XCoordinates = lungContourLocal(2).XCoordinates*1024/W;
    lungContourLocal(1).YCoordinates = lungContourLocal(1).YCoordinates*1024/H;
    lungContourLocal(2).YCoordinates = lungContourLocal(2).YCoordinates*1024/H;
    if(~isempty(pathologiesContour))
        for i = 1:length(pathologiesContour)
            pathologiesContour{i}.XCoordinates = pathologiesContour{i}.XCoordinates*1024/W;
            pathologiesContour{i}.YCoordinates = pathologiesContour{i}.YCoordinates*1024/H;
        end
    end
    processedImage = histeq(croppedImage);     
    varargout{1} = lungContourLocal;
    varargout{2} = processedImage;
    varargout{3} = pathologiesContour;
end

