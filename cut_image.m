function im = cut_image(xy, image)
    x = xy(2)+1;
    y = xy(1)+1;
    im = image(y:y+63, x:x+63);
end