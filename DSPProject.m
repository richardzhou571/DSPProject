corn_gray = imread('corn.tif', 3);
meanIntensity = mean(corn_gray(:));
corn_binary = corn_gray > meanIntensity;

banana = imread('banana.jpg');
banana_grayscale = banana(:, :, 1)/3 + banana(:, :, 2)/3 + banana(:, :, 3)/3;
banana_binary = banana_grayscale > mean(banana_grayscale(:));

strawberry = imread('strawberry.jpg');
strawberry_grayscale = strawberry(:, :, 1)/3 + strawberry(:, :, 2)/3 + strawberry(:, :, 3)/3;
strawberry_binary = strawberry_grayscale > mean(strawberry_grayscale(:));

a = zeros(300);

a(50:250, 50:250) = 0.25;
a(75:225, 75:225) = 0.50;
a(100:200, 100:200) = 0.75;
a(125:175, 125:175) = 1;

imshow(strawberry_binary)