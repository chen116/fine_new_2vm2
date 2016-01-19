
%% individual figures for Schedulability of Task Sets
%figure 1 -> bimo but with task long period (not used in paper becuase it is long period)
%figure 2 -> figure 1(b) Schedulability of Task Sets (Heavy Distribution)
%figure 3 -> figure 1(c) Schedulability of Task Sets (Medium Distribution)
%figure 4 -> figure 1(d) Schedulability of Task Sets (Light Distribution)

%close all

clc
clear

% make sure they have same length in char counts
% gives vm folder names

vms = cellstr([
                'med  ';
                'med2 ';
                'med3 ';
                'med4 ';
                'med5 ';
                'med6 ';
                'med7 ';
                'med8 ';
                'med9 ';
                'med10';    
                'med11';
                'med12';
                'med13'; 
                %'med ';

                 
                 ]);
%                'rtxen-459-0.2-4.2  ';
                 %'xen-480-0.2-4.2    ';
                 %'kvm-485-0.2-4.2    ']);

dists = cellstr([
                 'uni-medium_uni-moderate_ratio     ';...
                 %'uni-light_uni-moderate_ratio      ';...
                 ]);
file_dists = cellstr([
                      'medium-moderate-tasksets ';...
                    %  ' light-moderate-tasksets ';...
                 ]);
dists_title = cellstr([                          
                       'Medium Task Utilization (0.1, 0.4)                            ';
                    %   'Light Task Utilization (0.001, 0.1)                           '
                    ]);

xaxis=[0.2 0.4 0.6 0.8 1 1.2 1.4 1.6 1.8 2 2.2 2.4 2.6 2.8 3 3.2 3.4 3.6 3.8 4 4.2 4.4 4.6];
%xaxis=[1 2 3 4 4.2];
lw=[8,6,4,3,3,3,3,3,3,3,3,3,3,3];
ms=[8,8,6,4,6,6,6,6,6,6,6,6,6,6,6];
colors = distinguishable_colors(length(vms));
%ls=cellstr(['-ob';'-og';'-om';'-^k';'-or';'-oc';'-oy';'-xb';'-^r';'--k']);
ls=cellstr(['-o';'-^';'-o';'-^';'-o';...
    '-o';'-o';'-o';'-^';...
    '-o';'-o';'-^';'-o';]);

for j=1:length(dists)

    schdublilty=[];
    %h=figure
    h=gcf;
    for i=1:length(vms)

       fid = fopen(strcat(strtrim(vms{i}),'/',dists{j}));

        tline = fgets(fid);
        suc = zeros(1,length(xaxis));
        sum = zeros(1,length(xaxis));
        util = 1;

        while ischar(tline)

            if(1==(isspace(tline)))
                util=util+1;

            elseif(ischar(tline))

                oline = strsplit(strtrim(tline));
                if (size(oline,2)>2)
                    sum(util)=sum(util)+1;
                    if(str2double(oline(3))>0)
                        suc(util)=suc(util)+1;
                    end
                end
            end
            tline = fgets(fid);
        end
        fclose(fid);

        schdublilty(i,:) = (suc./sum)';
        %subplot(2,2,j);
        plot(xaxis,schdublilty(i,:),ls{i},'Color', colors(i,:),'LineWidth',lw(8),'MarkerSize',ms(8));
        %ls{i},'LineWidth',lw(i),'MarkerSize',ms(i))

        hold on

    end
    ylim([0 1.1])
     h_title=title(strtrim(dists_title{j}),'Interpreter', 'none');
     set(h_title,'FontSize',18);
    % update the line below correspond to the vms list above
    %h_legend=legend('Xen-RTDS', 'Xen-credit','WR-KVM','Bare-Metal','Location','ne');
%    h_legend=legend(
     h_legend=legend(...
      'Xen-RTDS1-old', 'Xen-RTDS2-old','Xen-RTDS3-old*','Xen-RTDS4-old','Xen-RTDS5-old*','Xen-RTDS6-old*',...    
    'Xen-RTDS1', 'Xen-RTDS2*','Xen-RTDS3','Xen-RTDS4*','Xen-RTDS5','Xen-RTDS6'...
        ,'Xen-RTDS7','Xen-RTDS8','Xen-RTDS9*','Xen-RTDS10','Xen-RTDS11',...
        'Xen-RTDS12*','Xen-RTDS13','Location','sw');

    set(h_legend,'FontSize',15);
    set(gca,'fontsize',15)
    xlabel('Normalized Task Set Utilization','FontSize',15)
    ylabel('Fraction of Schedulable Task Sets','FontSize',15)
    grid on
    hold off
   
   
    %save to pdf
    set(h,'Units','Inches');
    pos = get(h,'Position');
    set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
    print(h,strcat(strtrim(file_dists{j}),''),'-dpdf','-r0')

end

%% individual figures for Schedulability of Task Sets
%figure 1 -> bimo but with task long period (not used in paper becuase it is long period)
%figure 2 -> figure 1(b) Schedulability of Task Sets (Heavy Distribution)
%figure 3 -> figure 1(c) Schedulability of Task Sets (Medium Distribution)
%figure 4 -> figure 1(d) Schedulability of Task Sets (Light Distribution)

%close all

clc
clear

% make sure they have same length in char counts
% gives vm folder names

vms = cellstr([
                'light  ';
                'light2 ';
                'light3 ';
                'light4 ';
                'light5 ';
                'light6 ';
                'light7 ';
                'light8 ';
                'light9 ';
                'light10';
                'light11';
                'light12';
                'light13';
                %'med ';

                 
                 ]);
%                'rtxen-459-0.2-4.2  ';
                 %'xen-480-0.2-4.2    ';
                 %'kvm-485-0.2-4.2    ']);

dists = cellstr([
                 %'uni-medium_uni-moderate_ratio     ';...
                 'uni-light_uni-moderate_ratio      ';...
                 ]);
file_dists = cellstr([
                    %  'medium-moderate-tasksets ';...
                      ' light-moderate-tasksets ';...
                 ]);
dists_title = cellstr([                          
                    %   'Medium Task Utilization (0.1, 0.4)                            ';
                       'Light Task Utilization (0.001, 0.1)                           '
                    ]);
xaxis=[0.2 0.4 0.6 0.8 1 1.2 1.4 1.6 1.8 2 2.2 2.4 2.6 2.8 3 3.2 3.4 3.6 3.8 4 4.2 4.4 4.6];
%xaxis=[1 2 3 4 4.2];
lw=[8,6,4,3,3,3,3,3,3,3,3,3,3,3];
ms=[8,8,6,4,6,6,6,6,6,6,6,6,6,6,6];
colors = distinguishable_colors(length(vms));
ls=cellstr(['-o';'-o';'-o';'-^';'-^';...
    '-o';'-^';'-^';'-o';...
    '-o';'-o';'-^';'-o';]);
%ls=cellstr(['-ob';'-og';'-om';'-^k';'-or';'-oc';'-oy';'-xb';'-^r';'--k']);
for j=1:length(dists)

    schdublilty=[];
    %h=figure
    h=gcf;
    for i=1:length(vms)

       fid = fopen(strcat(strtrim(vms{i}),'/',dists{j}));

        tline = fgets(fid);
        suc = zeros(1,length(xaxis));
        sum = zeros(1,length(xaxis));
        util = 1;

        while ischar(tline)

            if(1==(isspace(tline)))
                util=util+1;

            elseif(ischar(tline))

                oline = strsplit(strtrim(tline));
                if (size(oline,2)>2)
                    sum(util)=sum(util)+1;
                    if(str2double(oline(3))>0)
                        suc(util)=suc(util)+1;
                    end
                end
            end
            tline = fgets(fid);
        end
        fclose(fid);

        schdublilty(i,:) = (suc./sum)';
        %subplot(2,2,j);
        plot(xaxis,schdublilty(i,:),ls{i},'Color', colors(i,:),'LineWidth',lw(8),'MarkerSize',ms(8));
       %ls{i},'LineWidth',lw(i),'MarkerSize',ms(i))

        hold on

    end
    ylim([0 1.1])
     h_title=title(strtrim(dists_title{j}),'Interpreter', 'none');
     set(h_title,'FontSize',18);
    % update the line below correspond to the vms list above
    %h_legend=legend('Xen-RTDS', 'Xen-credit','WR-KVM','Bare-Metal','Location','ne');

    h_legend=legend(...
      'Xen-RTDS1-old', 'Xen-RTDS2-old','Xen-RTDS3-old*','Xen-RTDS4-old','Xen-RTDS5-old*','Xen-RTDS6-old*',...
      'Xen-RTDS1', 'Xen-RTDS2','Xen-RTDS3','Xen-RTDS4*','Xen-RTDS5*','Xen-RTDS6'...
         ,'Xen-RTDS7*','Xen-RTDS8*','Xen-RTDS9','Xen-RTDS10','Xen-RTDS11',...
         'Xen-RTDS12*','Xen-RTDS13','Location','sw');
    set(h_legend,'FontSize',15);
    set(gca,'fontsize',15)
    xlabel('Normalized Task Set Utilization','FontSize',15)
    ylabel('Fraction of Schedulable Task Sets','FontSize',15)
     grid on
    hold off
   
   
    %save to pdf
    set(h,'Units','Inches');
    pos = get(h,'Position');
    set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
    print(h,strcat(strtrim(file_dists{j}),''),'-dpdf','-r0')

end




