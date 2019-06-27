y=linspace(0,20,1000);
s=15;
mu=s;
sigmasq=1;
u=-1;
r=0.2;
T=10;
for t=1:T
  s=s+u+randn*r; % actual position
  qt=s*0.15;
  z=s+randn*qt; % range measurement
  muhat=mu+u; % predicted mean
  sigmasqhat=sigmasq+r*r; % predicted variance
  k=sigmasqhat/(sigmasqhat+qt*qt); % kalman gain
  mu=muhat+k*(z-muhat); % posterior mean
  sigmasq=(1-k)*sigmasqhat; % posterior variance
  p=normpdf(y,mu,sqrt(sigmasq));
  plot(y,p,'linewidth',2);xlabel('Position');ylabel('Probability Density');axis([0 20 0 1.5]);grid;
  hold on;
  plot(s,0,'r.','markersize',10);
  hold off;
  legend('Posterior','Robot');
  title(sprintf('Kalman Filter t = %d',t));
  set(gcf,'position',[1 452 800 400]);
  drawnow;
  print(sprintf('kalman%d.png',t),'-dpng');
end
