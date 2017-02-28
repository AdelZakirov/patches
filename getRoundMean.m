function featuresVector = getRoundMean(xy, image)
    x = xy(2)+1;
    y = xy(1)+1;
    try
%         if(y+63>
    im = image(y:y+63, x:x+63);
    catch
       x
       y
    end
    featuresVector = round(mean2(im));
end