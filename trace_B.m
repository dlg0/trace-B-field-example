% routine to demonstrate the calculation of the anisotropy line segments
% for along the background magnetic field (B)

% plot B vector to sanity check for correctness

box_size = 0.5;
xmin=-box_size;
xmax=+box_size;
ymin=-box_size;
ymax=+box_size;

n=32;
x=linspace(xmin,xmax,n);
y=linspace(ymin,ymax,n);
[x2,y2]=meshgrid(x,y);
[Bx,By] = B_field(x2,y2);

quiver(x,y,Bx,By);
hold on

% trace a few magnetice field (B) line / anisotropy direction and plot

tspan = [0 0.5];
icx = linspace(0,0.49,5);
icy = zeros(size(icx));

for k=1:numel(icx)
    ic = [icx(k);icy(k)];
    [t,line] = ode45(@rhs,tspan,ic);
    plot(line(:,1),line(:,2),'LineWidth',2)
end
hold off
disp('done');

function B = rhs(t,pos)
x=pos(1);
y=pos(2);
[Bx,By] = B_field(x,y);
B=[Bx;By];
end

% define B field 2D function

function [Bx,By] = B_field(x,y)
Bx = +pi .* cos(pi.*x).* sin(pi.*y);
By = -pi .* cos(pi.*y).* sin(pi.*x);
end


