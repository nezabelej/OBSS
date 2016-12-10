files = dir('./input/*.mat');
for file = files' 
    nameWithourExt = regexprep(file.name,'m.mat','');
    Detector(nameWithourExt, 5, 10);
end