function [leftUpXY, W, H] = getBoundingBox(lungContour, imageSize)
    if(length(lungContour)>1)
        leftUpXY(1) = max([1, floor(min([min(lungContour(1).XCoordinates) min(lungContour(2).XCoordinates)]))]);
        leftUpXY(2) = max([1, floor(min([min(lungContour(1).YCoordinates) min(lungContour(2).YCoordinates)]))]);
        rightDownXY(1) = min([imageSize(2), floor(max([max(lungContour(1).XCoordinates) max(lungContour(2).XCoordinates)]))]);
        rightDownXY(2) = min([imageSize(1), floor(max([max(lungContour(1).YCoordinates) max(lungContour(2).YCoordinates)]))]);
    else
        leftUpXY(1) = max([1, floor(min(lungContour.XCoordinates))]);
        leftUpXY(2) = max([1, floor(min(lungContour.YCoordinates))]);
        rightDownXY(1) = min([imageSize(2), floor(max(lungContour.XCoordinates))]);
        rightDownXY(2) = min([imageSize(1), floor(max(lungContour.YCoordinates))]);
    end
    W = rightDownXY(1) - leftUpXY(1);
    H = rightDownXY(2) - leftUpXY(2);
end