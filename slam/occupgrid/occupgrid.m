% occupancy grid toy example of robot with range sensor moving towards wall
s=15;
u=-0.5;
T=10;
ogpos=linspace(0,20,21);
ogodds=zeros(1,length(ogpos));
zthresh=1;
Loccup=1.4;
Lempty=-0.8;
for t=1:20
  clf;
  qt=s*.15;
  s=s+u+randn*r; % position
  z=abs(s+randn*qt); % range measurement
  infront=(ogpos-s)<0;
  d=abs(ogpos-s);
  atrange=abs(d-z)<=zthresh;
  beyondrange=d-z>zthresh;
  beforerange=d-z<zthresh;
  ogodds(infront&beforerange) = ogodds(infront&beforerange) + Lempty;
  ogodds(infront&atrange) = ogodds(infront&atrange) + Loccup;
  ogp=1./(1+exp(-ogodds));
  stairs(ogpos,ogp, 'linewidth',2);
  hold on;
  plot(s,0,'r.','markersize',10);
  grid on;
  hold off;
  axis([0 20 0 1]);
  xlabel('Position');
  ylabel('Probability');
  legend('P(occupied)','Robot');
  title(sprintf('Occupancy Grid t = %d',t));
  set(gcf,'position',[1 452 800 400]);
  drawnow;
  print(sprintf('occupgrid%d.png',t),'-dpng');
end
