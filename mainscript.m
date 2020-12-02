%dit is het hoofdscript.
clear all
close all

folder = "Q1_results_rik/transport_time";
Files=dir(folder);
NoFiles= length(Files);

data = zeros(120,NoFiles-3);
for k=4:NoFiles
   FileNames = Files(k).name;
   name(k-3).name = FileNames;
   data(:,k-3) = importdata(name(k-3).name);
   newStr(k-3) = extractBetween(name(k-3).name,"time_","yte");
end

bytes = regexprep(newStr,'[\d"]','');
bytes = sort(bytes);
%expression = '_(\d+)(\D+)';
expression = '(?<size>\d+)(?<byte>\D+)';
for k=1:15
size(k) = regexp(name(k).name,expression,'names');
% if((contains(name(k).name, "Mbyte"))==1)
%     size(k) = 1000000 * size(k);
%     
% elseif(contains(name(k).name,"Kbyte")==1)
%     
%     
%     size(k) = 1000*size(k);
%     
% else
%     size(k) =1*size(k);    
%     
% end
end
%R = cell2mat(regexp(newStr ,'(?<Name>\D+)(?<Nums>\d+)','names'));
%tmp = sortrows([{R.Name}' num2cell(cellfun(@(x)str2double(x),{R.Nums}'))]);
%SortedText = strcat(tmp(:,1) ,cellfun(@(x) num2str(x), tmp(:,2),'unif',0))

data = data*1000;
test = natsort(newStr); %https://nl.mathworks.com/matlabcentral/answers/229757-sorting-an-array-of-strings-based-on-number-pattern

boxplot(data);
set(gca,'XTickLabel',newStr);
xlabel('transfersize')
ylabel('Time [ms]')
title('Miles per Gallon for All Vehicles')

