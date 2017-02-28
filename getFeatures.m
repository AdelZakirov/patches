function featuresVector = getFeatures(xy, image)
    x = xy(2)+1;
    y = xy(1)+1;
    try
%         if(y+63>
    im = image(y:y+63, x:x+63);
    catch
       x
       y
    end
%     GLCM2 = graycomatrix(im,'Offset',[2 0;0 2]);
%     stats = GLCM_Features1(GLCM2,1);
%     stats = cell2mat(struct2cell(stats));
%     featuresVector = stats';
    featuresVector = [mean2(im) std2(im) skewness(im(:)) kurtosis(im(:)) x y];
end