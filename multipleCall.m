files = dir('./input/*.mat');
for file = files' 
    nameWithoutExt = regexprep(file.name,'m.mat','');
    Detector(nameWithoutExt);
end