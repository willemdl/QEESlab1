clear all
close all
%% loading of files 
%give the folder containing the .txt files
folder = "resultsQ2";
Files=dir(folder);
NoFiles= length(Files);
FileOffset = 2; %how many files are in the map that are useless

info.data = zeros(121,NoFiles-FileOffset);
multi = 1000; %used to multiply input data 1000 means converting seconds to ms
for k=1:(NoFiles-FileOffset)
    FileNames = Files(k+FileOffset).name;
    info.Fname(k) = convertCharsToStrings(FileNames);%.Fname = File name
    FilePlace = [Files(k+FileOffset).folder '/' Files(k+FileOffset).name];
    info.data(:,k) = importdata(FilePlace) * multi;
end
%% calculate the intervall

data = info.data;
conf_interval80 = prctile(data,[10 90]);
conf_interval98 = prctile(data,[1 99]);

%% generate a boxplot

figure();
boxplot(info.data);
set(gca,'XTickLabel','Question 2');
ylabel('Latency [ms]')
title('Boxplot of transport times.')
Figname =['Figures/Q2/Boxplot1.jpg'];
saveas(gcf, Figname);
