
%% individual figures for Schedulability of Task Sets
%figure 1 -> bimo but with task long period (not used in paper becuase it is long period)
%figure 2 -> figure 1(b) Schedulability of Task Sets (Heavy Distribution)
%figure 3 -> figure 1(c) Schedulability of Task Sets (Medium Distribution)
%figure 4 -> figure 1(d) Schedulability of Task Sets (Light Distribution)

close all

clc
clear

% make sure they have same length in char counts
% gives vm folder names

vms = cellstr([

                 %'paper_dec_2_3_ratio   ';
                 'paper_dec_0.8_1.4_ratio';

                 ]);


dists = cellstr([
                 'uni-medium_uni-moderate_ratio     ';...
                 'uni-light_uni-moderate_ratio      ';...
                 ]);
file_dists = cellstr([
                      'medium-moderate-tasksets ';...
                      ' light-moderate-tasksets ';...
                 ]);
dists_title = cellstr([                          
                       'Medium Task Utilization (0.1, 0.4)                            ';
                       'Light Task Utilization (0.001, 0.1)                           ']);

%xaxis=[0.2 0.4 0.6 0.8 1 1.2 1.4 1.6 1.8 2 2.2 2.4 2.6 2.8 3 3.2 3.4 3.6 3.8 4 4.2];
xaxis=[1 2];
lw=[8,6,4,3,3,3,3,3,3];
ms=[8,8,6,4,6,6,6,6,6];
ls=cellstr(['-ob';'-og';'-om';'-^k';'-or';'-oc';'-oy';'-xb';'-^r']);
   schdublilty=[];
for j=1:9

 

    for i=1:length(vms)
        file_name = strcat(strtrim(vms{i}),'/myapp');
        file_name = strcat(file_name,num2str(j));
        file_name = strcat(file_name,'/uni-medium_uni-moderate_ratio');

       fid = fopen(file_name);
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
        schdublilty(:,:,j) = (suc./sum)';
        %subplot(2,2,j);
%        plot(xaxis,schdublilty(i,:),ls{i},'LineWidth',lw(i),'MarkerSize',ms(i))

 %       hold on

    end

%    ylim([0 1.1])
%      h_title=title(strtrim(dists_title{j}),'Interpreter', 'none');
%      set(h_title,'FontSize',18);
%     % update the line below correspond to the vms list above
%     h_legend=legend('Xen-RTDS', 'Xen-credit','WR-KVM','Bare-Metal','Location','ne');
%     set(h_legend,'FontSize',15);
%     set(gca,'fontsize',15)
%     xlabel('Normalized Task Set Utilization','FontSize',15)
%     ylabel('Fraction of Schedulable Task Sets','FontSize',15)
%     grid on
%     hold off
%    
%    
%     %save to pdf
%     set(h,'Units','Inches');
%     pos = get(h,'Position');
%     set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
%     print(h,strcat(strtrim(file_dists{j}),''),'-dpdf','-r0')

end
    h=figure
for i=1:2

     squeeze(schdublilty(i,1,:))
     plot(1:9,squeeze(schdublilty(i,1,:)),ls{i},'LineWidth',lw(i),'MarkerSize',ms(i));
    h_legend=legend('utila rate: 2', 'util rate: 3','Location','sw');
        xlabel('Trials','FontSize',15)
    ylabel('Fraction of Schedulable Task Sets','FontSize',15)

hold on    
end
hold off
    %save to pdf
    set(h,'Units','Inches');
    pos = get(h,'Position');
    set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
    print(h,strcat('2-3',''),'-dpdf','-r0')

