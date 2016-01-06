%% individual figures: Schedulability of Jobs
%individual figures: jobs suc/fail
%figure 1 -> bimo but with task long period (not used in paper becuase it is long period)
%figure 2 -> figure 2(b) Schedulability of Jobs (Heavy Distribution)
%figure 3 -> figure 3(a) Schedulability of Jobs (Medium Distribution)
%figure 4 -> figure 3(b) Schedulability of Jobs (Light Distribution)

close all

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
               ]);

dists = cellstr([
                 'uni-medium_uni-moderate_ratio     ';...
                % 'uni-light_uni-moderate_ratio      ';...
                 ]);
file_dists = cellstr([
                      'medium-moderate-jobs ';...
                 %     ' light-moderate-jobs ';...
                 ]);
dists_title = cellstr([                          
                       'Medium Task Utilization (0.1, 0.4)                            ';
                  %     'Light Task Utilization (0.001, 0.1)      
                  ]);

xaxis=[0.2 0.4 0.6 0.8 1 1.2 1.4 1.6 1.8 2 2.2 2.4 2.6 2.8 3 3.2 3.4 3.6 3.8 4 4.2];
%xaxis=[1 2 3 4 4.2];

% line, maker style
lw=[8,6,4,3];
ms=[8,8,6];
ls=cellstr(['-ob';'-og';'-om';'-^k';]);


%figure
for j=1:length(dists)

    schdublilty=[];
    h = figure
    % h=figure('position', [0, 0, 1275, 400])
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
                    sum(util)=sum(util)+str2double(oline(2));
                    suc(util)=suc(util)+str2double(oline(1));

                end
            end
            tline = fgets(fid);
        end
        fclose(fid);

        schdublilty(i,:) = (suc./sum)';
        plot(xaxis,schdublilty(i,:));%,ls{i},'LineWidth',lw(i),'MarkerSize',ms(i))
        ylim([0 1.1])
        h_legend=legend('Xen-RTDS', 'Xen-credit','KVM','Bare-Metal','Location','sw');
        set(h_legend,'FontSize',15);
        set(gca,'fontsize',15)
        xlabel('Normalized Task Set Utilization','FontSize',15)
        ylabel('Fraction of Schedulable Jobs','FontSize',15)
        grid on
        hold on
        

    end
    
    % save to pdf
    [ax4,h3]=suplabel(strtrim(dists_title{j}),'t');
    set(h3,'FontSize',20)  
    set(h,'Units','Inches');
    pos = get(h,'Position');
    %set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3)-2.8, pos(4)])
    set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
    print(h,strtrim(file_dists{j}),'-dpdf','-r0')
   
end


