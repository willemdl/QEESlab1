clear all
close all

SelectedSizes = [3 9 14];
fontsize = 32;

[info1] = Q5function('non_real_time_no_load', SelectedSizes);
[info2] = Q5function('non_real_time_with_load', SelectedSizes);
[info3] = Q5function('real_time_no_load', SelectedSizes);
[info4] = Q5function('real_time_with_load', SelectedSizes);

nbins = 100;
[~, NoResults] = size(SelectedSizes);

labels = [{'Case 1'},{ 'Case 2'},{ 'Case 3'},{ 'Case 4'}];

%% Boxplot 
for k=1:NoResults
    Selected = SelectedSizes(k);
    data = [info1.data(:,Selected) info2.data(:,Selected) info3.data(:,Selected) info4.data(:,Selected)];
    
    foldername = info1.label(Selected);
    figure();
%     data = info.data(:,SelectedSizes);
    boxplot(data);
    set(gca,'fontsize',fontsize);
    grid on
    Ymax = max(prctile(data, 99))+0.1;
    Ymin = min(prctile(data, 1));
%     if (k==2)
%         ylim([.2 1]);
%     end
%     if (k==3)
%         ylim([1.8 2.7]);
%     end
    set(gca,'XTickLabel',labels);
    xlabel('Transfersize');
    ylabel('Latency [ms]');
    temp =["Box plot of different cases with packet size of " foldername];
    title(temp);
    Figname =append('Figures/Q5/', foldername, '_Boxplot.eps');
    saveas(gcf,Figname, 'epsc')
end

    Selected = SelectedSizes(k);
    data = [info1.data(:,Selected) info2.data(:,Selected) info3.data(:,Selected) info4.data(:,Selected)];
    
    foldername = info1.label(Selected);
    figure();
%     data = info.data(:,SelectedSizes);
    boxplot(data);
    set(gca,'fontsize',fontsize);
    grid on


    Ymax = max(prctile(data, 99))+0.1;
    Ymin = min(prctile(data, 1));
    ylim([1 14]);
%     if (k==2)
%         ylim([.2 1]);
%     end
%     if (k==3)
%         ylim([1.8 2.7]);
%     end
    set(gca,'XTickLabel',labels);
    xlabel('Transfersize');
    ylabel('Latency [ms]');
    temp =["Zoomed in box plot of different cases with packet size of " foldername];
    title(temp);
    Figname =append('Figures/Q5/zoomed', foldername, '_Boxplot.eps');
    saveas(gcf,Figname, 'epsc')


% Histograms

%nonreal no load
for k=1:NoResults
    foldername = "non real time without load";
    Selected = SelectedSizes(k);
    data = info1.data(:,Selected);
    temptitle = append(foldername,' ', info1.label(Selected));
    
    figure();
    
    Xprctlines = prctile(data,[25 50 75]);
    
    xlimits = prctile(data,[1 99]);
    left = xlimits(1);
    right = xlimits(2);
    edges = linspace(left, right, nbins);
    histogram(data, edges);
    set(gca,'fontsize',fontsize);
    xlim([left right]);
    xline(Xprctlines(1),'--r', "Q1 = " + num2str(round(Xprctlines(1),3)));
    xline(Xprctlines(2),'--r', "Q2 = " + num2str(round(Xprctlines(2),3)));
    xline(Xprctlines(3),'--r', "Q3 = " + num2str(round(Xprctlines(3),3)));
    ylabel('Bin Count');
    xlabel('Latency [ms]');
    title(temptitle);
    foldername = "non_real_time_without_load";
    Figname = append('Figures/Q5/', foldername ,'Histogram' ,info1.label(Selected) ,'.eps');
    saveas(gcf,Figname,'epsc');
end

%nonreal with load
for k=1:NoResults
    foldername = "non real time with load";
    Selected = SelectedSizes(k);

    data = info2.data(:,Selected);
    temptitle = append(foldername,' ', info2.label(Selected));
    figure();
    
    Xprctlines = prctile(data,[25 50 75]);
    
    xlimits = prctile(data,[1 99]);
    left = xlimits(1);
    right = xlimits(2);
    edges = linspace(left, right, nbins);
    histogram(data, edges);
    set(gca,'fontsize',fontsize);
    xlim([left right]);
    xline(Xprctlines(1),'--r', "Q1 = " + num2str(round(Xprctlines(1),3)));
    xline(Xprctlines(2),'--r', "Q2 = " + num2str(round(Xprctlines(2),3)));
    xline(Xprctlines(3),'--r', "Q3 = " + num2str(round(Xprctlines(3),3)));
    ylabel('Bin Count');
    xlabel('Latency [ms]');
    title(temptitle);
    foldername = "non_real_time_with_load";
    Figname = append('Figures/Q5/', foldername ,'Histogram' ,info2.label(Selected) ,'.eps');
    saveas(gcf,Figname,'epsc');
end
%real no load

for k=1:NoResults
    Selected = SelectedSizes(k);
    foldername = "real time without load";
    data = info3.data(:,Selected);
    temptitle = append(foldername,' ', info3.label(Selected));
    figure();
    
    Xprctlines = prctile(data,[25 50 75]);
    
    xlimits = prctile(data,[1 99]);
    left = xlimits(1);
    right = xlimits(2);
    edges = linspace(left, right, nbins);
    histogram(data, edges);
    set(gca,'fontsize',fontsize);
    xlim([left right]);
    xline(Xprctlines(1),'--r', "Q1 = " + num2str(round(Xprctlines(1),3)));
    xline(Xprctlines(2),'--r', "Q2 = " + num2str(round(Xprctlines(2),3)));
    xline(Xprctlines(3),'--r', "Q3 = " + num2str(round(Xprctlines(3),3)));
    ylabel('Bin Count');
    xlabel('Latency [ms]');
    title(temptitle);
    foldername = "real_time_without_load";
    Figname = append('Figures/Q5/', foldername ,'Histogram' ,info3.label(Selected) ,'.eps');
    saveas(gcf,Figname,'epsc');
end
%real  load

for k=1:NoResults
    foldername = "real time with load";
    Selected = SelectedSizes(k);
    data = info4.data(:,Selected);
    temptitle = append(foldername,' ', info4.label(Selected));
    figure();
    
    Xprctlines = prctile(data,[25 50 75]);
    
    xlimits = prctile(data,[1 99]);
    left = xlimits(1);
    right = xlimits(2);
    if info4.label()
    edges = linspace(left, right, nbins);
    histogram(data, edges);
    set(gca,'fontsize',fontsize);

    xlim([left right]);
    xline(Xprctlines(1),'--r', "Q1 = " + num2str(round(Xprctlines(1),3)));
    xline(Xprctlines(2),'--r', "Q2 = " + num2str(round(Xprctlines(2),3)));
    xline(Xprctlines(3),'--r', "Q3 = " + num2str(round(Xprctlines(3),3)));
    ylabel('Bin Count');
    xlabel('Latency [ms]');
    title(temptitle);
    foldername = "real_time_with_load";
    Figname = append('Figures/Q5/', foldername ,'Histogram' ,info4.label(Selected) ,'.eps');
    saveas(gcf,Figname,'epsc');
end
