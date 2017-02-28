pathologiesFolder = 'Infiltration';
pathologiesNumber = HowManyDcms(dir(strcat('dataset/',pathologiesFolder)));
pathologiesChoosen = 1:pathologiesNumber;
patches_result = patches(pathologiesFolder, pathologiesChoosen, 'train',patches_res);