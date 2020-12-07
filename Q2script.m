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

%% Histogram
figure();
data = info.data;
Xprctlines = prctile(data,[25 50 75]);

histogram(data, 100);
xline(conf_interval98(1),'--r', "1% = " + num2str(round(conf_interval98(1),3)));
xline(conf_interval98(2),'--r', "99% = " + num2str(round(conf_interval98(2),3)));
xline(conf_interval80(1),'--r', "10% = " + num2str(round(conf_interval80(1),3)));
xline(conf_interval80(2),'--r', "90% = " + num2str(round(conf_interval80(2),3)));
ylabel('Bin Count');
xlabel('Latency [ms]');
title(['Confidence intervals of dataset.']);
Figname =['Figures/Q2/Histogram.eps'];
saveas(gcf, Figname, 'epsc');

