function xy = coords2( im,step,PatchSize )
    [y, x] = find(im>=0);
    xxyy = [x y];
    ind = mod(xxyy(:,2),step)==0|xxyy(:,2)==1;
    xxyy1 = xxyy(ind,:);
    ind2 = mod(xxyy1(:,1),step)==0|xxyy1(:,1)==1;
    xxyy1 = xxyy1(ind2,:);
    ind3 = xxyy1(:,1)>(size(im,2)-PatchSize);
    xxyy1(ind3,:) = [];
    ind4 = xxyy1(:,2)>(size(im,1)-PatchSize);
    xxyy1(ind4,:) = [];
    xxyy1(xxyy1==1)=0;
    xy = xxyy1;
end