img = snapshot(cam);
% img = imread('3.jpg');
I = rgb2gray(img);
corners = detectHarrisFeatures(I);
corners = corners.selectStrongest(20);
corners = corners.Location;
X = corners(:,1); Y = corners(:,2);
imshow(img); hold on;

% Left Line
xL = [min(X) min(X)];
yL = [min(Y) max(Y)];
plot(xL, yL, 'Color', 'r'), hold on;
% Bottom Line
xd = [min(X) max(X)];
yd = [max(Y) max(Y)];
plot(xd, yd, 'Color', 'r'), hold on;
% Top Line
xu = [min(X) max(X)];
yu = [min(Y) min(Y)];
plot(xu, yu, 'Color', 'r')
% Right Line
xR = [max(X) max(X)];
yR = [min(Y) max(Y)];
plot(xR, yR, 'Color', 'g')

length = abs(max(Y) - min(Y));

% h = imdistline(gca,[max(X) max(X)],[min(Y) max(Y)]);
% a = max(X), b = min(Y), c = max(Y)