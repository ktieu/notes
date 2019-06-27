numLandmarks=20;
landmarks=5*randn(2,numLandmarks);

truePath=zeros(2,1);
odoPath=zeros(2,1);
control=[];
measurements={};
motionNoise=0.5;
sensorNoise=0.25;
zthresh=5;

numSteps=50;
for t=1:numSteps
  pose=truePath(:,end);
  dist=sqrt(sum((landmarks - repmat(pose,1,size(landmarks,2))).^2));
  z=[];
  for i=1:length(dist)
    if dist(i) <= zthresh
      p=landmarks(:,i)-pose+sensorNoise*randn(2,1);
      z=[z,[i;p]];
    end
  end
  measurements(t)=z;
  u=randn(2,1);
  control=[control,u];
  desiredPose=truePath(:,end)+u;
  pose=desiredPose+motionNoise*randn(2,1);
  truePath=[truePath,pose];
  odoPath=[odoPath,desiredPose];
 
end

N=size(control,2)+1;
dim=2*(N+numLandmarks);
A=zeros(dim);
A(1,1)=1;
A(2,2)=1;
c=zeros(dim,1);
for k=1:size(control,2)
  n=2*k-1;
  z=measurements{k};
  for i=1:size(z,2)
    m=2*(N+z(1,i))-1;
    for b=0:1
      A(n+b,n+b)=A(n+b,n+b)+1/sensorNoise;
      A(m+b,m+b)=A(m+b,m+b)+1/sensorNoise;
      A(n+b,m+b)=A(n+b,m+b)-1/sensorNoise;
      A(m+b,n+b)=A(m+b,n+b)-1/sensorNoise;
      c(n+b)=c(n+b)-z(2+b,i)/sensorNoise;
      c(m+b)=c(m+b)+z(2+b,i)/sensorNoise;
    end
  end
  u=control(:,k);
  for b=0:3
    A(n+b,n+b)=A(n+b,n+b)+1/motionNoise;
  end
  for b=0:1
    A(n+b,n+b+2)=A(n+b,n+b+2)-1/motionNoise;
    A(n+b+2,n+b)=A(n+b+2,n+b)-1/motionNoise;
    c(n+b)=c(n+b)-u(1+b)/motionNoise;
    c(n+b+2)=c(n+b+2)+u(1+b)/motionNoise;
  end
end

lambda=0.00001;
x=(A+lambda*eye(size(A)))\c;
slamPath=reshape(x(1:2*N),2,N);
slamLandmarks=reshape(x(2*N+1:end),2,numLandmarks);

clf;
hold on;
plot(landmarks(1,:),landmarks(2,:),'b*','markersize',10);
plot(truePath(1,:),truePath(2,:),'bo--','linewidth',2);
plot(odoPath(1,:),odoPath(2,:),'r:','linewidth',2);
plot(slamLandmarks(1,:),slamLandmarks(2,:),'gs','markersize',10);
plot(slamPath(1,:),slamPath(2,:),'g','linewidth',2);
hold off;
axis equal;
legend('Landmarks','True Path','Odometry', 'SLAM map','SLAM');
title('GraphSLAM linear robot and sensor');
print('graphslamlinear.png','-dpng');