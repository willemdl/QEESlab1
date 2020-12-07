function [info] = Q3function(foldername, SelectedSizes)
%Q3FUNCTION Summary of this function goes here
%   Detailed explanation goes here


%% reading data from folder/files

%give the folder containing the .txt files
% folder = "results12-03/Q3_results_rik/transport_time";
folder = ['results12-06/Q3_results_rik/' foldername '/transport_time'];
Files=dir(folder);
NoFiles= length(Files);
FileOffset = 3; %how many files are in the map that are useless

info.data = zeros(999,NoFiles-FileOffset);
multi = 1000; %used to multiply input data 1000 means converting seconds to ms
for k=1:(NoFiles-FileOffset)
    FileNames = Files(k+FileOffset).name;
    info.Fname(k) = convertCharsToStrings(FileNames);%.Fname = File name
    FilePlace = [Files(k+FileOffset).folder '/' Files(k+FileOffset).name];
    info.data(:,k) = importdata(FilePlace) *multi;
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

%% setting the columns to show in the figures
if (SelectedSizes ==0)
    SelectedSizes = 1:(NoFiles-FileOffset);
else
    if(max(SelectedSizes)>(NoFiles-FileOffset) || min(SelectedSizes)<=0)
       error("SelectedSizes vector is incorrect. must be between 1 and number of files.");
    end
end

%% ordering of all info data by size of the packets
[rsizesorted,ordering] = sort(info.rsize(:));
info.Fname = info.Fname(ordering);
info.label = info.label(ordering);
info.size = info.size(ordering);
info.byte = info.byte(ordering);
info.rsize = info.rsize(ordering);
info.data = info.data(:,ordering);
% test = natsort(newStr); %https://nl.mathworks.com/matlabcentral/answers/229757-sorting-an-array-of-strings-based-on-number-pattern



% %% boxplot
% foldername = regexprep(foldername, '_', ' ');
% 
% 
% figure();
% data = info.data(:,SelectedSizes);
% boxplot(data);
% Ymax = max(prctile(data, 99))+0.1;
% Ymin = min(prctile(data, 1));
% ylim([0 Ymax]);
% set(gca,'XTickLabel',info.label(SelectedSizes));
% xlabel('Transfersize')
% ylabel('Latency [ms]')
% title(foldername)
% Figname =['Figures/Q3/' foldername '_Boxplot1.jpg'];
% % saveas(gcf, Figname);
% 
% %% Histogram
% nbins = 100;
% [~, NoHistograms] = size(SelectedSizes);
% for k=1:NoHistograms
%     Selected = SelectedSizes(k);
%     figure();
%     data = info.data(:,Selected);
%     
%     Xprctlines = prctile(data,[25 50 75]);
%     
%     xlimits = prctile(data,[1 99]);
%     left = xlimits(1);
%     right = xlimits(2);
%     edges = linspace(left, right, nbins);
%     histogram(data, edges);
%     xlim([left right]);
%     xline(Xprctlines(1),'--r', "Q1 = " + num2str(round(Xprctlines(1),3)));
%     xline(Xprctlines(2),'--r', "Q2 = " + num2str(round(Xprctlines(2),3)));
%     xline(Xprctlines(3),'--r', "Q3 = " + num2str(round(Xprctlines(3),3)));
%     ylabel('Bin Count');
%     xlabel('Latency [ms]');
%     title(append(foldername,' ', info.label(Selected)));
%     Figname =['Figures/Q4/' foldername 'Histogram' info.label(Selected) '.eps','epsc'];
% end

end

