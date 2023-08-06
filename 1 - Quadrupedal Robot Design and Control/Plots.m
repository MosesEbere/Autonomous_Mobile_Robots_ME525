% Plots
% -------------------------

figure
plot(Leftarray)
hold on
plot(Rightarray, 'r')
title('Forward Motion on the Ground; Left Motor Speed = Right Motor Speed = -80')
ylabel('Rotation')
xlabel('Counter, i')
legend('Left Motor','Right Motor')
grid