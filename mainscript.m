%dit is het hoofdscript.
clear all
close all


Files=dir('Q1_results_rik/transport_time');
NoFiles= length(Files);

data = zeros(120,NoFiles-3);
for k=4:NoFiles
   FileNames = Files(k).name;
   name(k-3).name = FileNames;
   data(:,k-3) = importdata(name(k-3).name);
end


boxplot(data);

