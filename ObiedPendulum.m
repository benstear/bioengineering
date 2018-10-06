

clear; close all
  
 cycs_per_min = 51:65;  
 f = cycs_per_min / 60;  
 w = 2*pi*f;  
 g = 9.8;  
 l = g./w.^2;  
 fs = 45;  
 dt = 1/fs; 
 tmax = 60; 
 t = 0:dt:tmax;

 theta = zeros(length(w),length(t)); 
 theta_i = pi/4;
 for i=1:length(w) 
     theta(i,:) = theta_i * cos(w(i)*t);
 
 end 
 
 ax = [-.3 .3 -0.5 0.1]; 
 fig = figure;
 cla; axis(ax); axis square; set(gca,'visible','off'); 
 t1 = tic;
 clr = jet(length(l)); 
 for i = 1:length(t) 
         x = l' .*  sin(theta(:,i));
         y = l' .* -cos(theta(:,i));
        cla; 
         for j=1:length (x) 
                 cc = clr(j,:);
         plot(x(j),y(j),'o','markerfacecolor',cc,'markeredgecolor','k','markersize',12); hold on; 
         h = line([0 x(j)],[0 y(j)]); 
                  set(h,'color',cc); 
              end 
          set(gca,'visible','off');
          axis(ax); 
         drawnow; 
      end
