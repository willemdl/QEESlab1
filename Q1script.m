clear all
close all
%% loading of files 
%give the folder containing the .txt files
folder = "results12-03/Q1_results_rik/transport_time";
Files=dir(folder);
NoFiles= length(Files);
FileOffset = 3; %how many files are in the map that are useless

info.data = zeros(999,NoFiles-FileOffset);
multi = 1000; %used to multiply input data 1000 means converting seconds to ms
for k=1:(NoFiles-FileOffset)
    FileNames = Files(k+FileOffset).name;
    info.Fname(k) = convertCharsToStrings(FileNames);%.Fname = File name
    FilePlace = [Files(k+FileOffset).folder '/' Files(k+FileOffset).name];
    info.data(:,k) = importdata(FilePlace) * multi;
end
%% adjusting data 

expression = '(?<size>\d+)(?<byte>\D+)....';
for k=1:(NoFiles-FileOffset)
    temp(k)= regexp(info.Fname(k),expression,'names');
    info.label(k) = upper(extractBetween(info.Fname(k),"time_","yte"));
    info.size(k) = str2double(temp(k).size);
    info.byte(k) = temp(k).byte;
end
for k=1:(NoFiles-FileOffset)
    
    if((contains(info.Fname(k), "Mbyte"))==1)
        info.rsize(k) = 1000000 * info.size(k);
    elseif(contains(info.Fname(k),"Kbyte")==1)
        info.rsize(k) = 1000*info.size(k);
    elseif(contains(info.Fname(k),"byte")==1)
        info.rsize(k) =1*info.size(k);
    else
        warning("the namefield in size structure was not correct");
    end
end

%% ordering of all info data by size of the packets
[rsizesorted,ordering] = sort(info.rsize(:));
info.Fname = info.Fname(ordering);
info.label = info.label(ordering);
info.size = info.size(ordering);
info.byte = info.byte(ordering);
info.rsize = info.rsize;
info.data = info.data(:,ordering);
% test = natsort(newStr); %https://nl.mathworks.com/matlabcentral/answers/229757-sorting-an-array-of-strings-based-on-number-pattern


%% boxplot
figure();
boxplot(info.data);
ylim([0 5.5]);
set(gca,'XTickLabel',info.label);
xlabel('Transfersize')
ylabel('Latency [ms]')
title('Boxplot of the end to end latency with different packetsizes.')
saveas(gcf,'Figures/Q1/Q1Boxplot1.eps','epsc')

figure();
boxplot(info.data);
ylim([0.1 0.6]);
set(gca,'XTickLabel',info.label);
xlabel('Transfersize')
ylabel('Latency [ms]')
title('Boxplot of the end to end latency with different packetsizes zoomed in.')
saveas(gcf,'Figures/Q1/Q1Boxplotzoomed.eps','epsc')