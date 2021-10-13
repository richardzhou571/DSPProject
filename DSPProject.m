% Testing Sound library in MATLAB
load gong.mat;
%sound([1, 2, 3, -4, -3, -2, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5]/5);

% Testing image library in MATLAB
corn_gray = imread('corn.tif', 3);
meanIntensity = mean(corn_gray(:));
corn_binary = corn_gray > meanIntensity;

banana = imread('banana.jpg');
banana_grayscale = banana(:, :, 1)/3 + banana(:, :, 2)/3 + banana(:, :, 3)/3;
banana_binary = banana_grayscale > mean(banana_grayscale(:));

strawberry = imread('strawberry.jpg');
strawberry_grayscale = strawberry(:, :, 1)/3 + strawberry(:, :, 2)/3 + strawberry(:, :, 3)/3;
strawberry_binary = strawberry_grayscale > mean(strawberry_grayscale(:));

% Image a
a = zeros(20);
a(5:15, 5:15) = 1;

% Image b
b = ones(20);

dtft_a = abs(dtft(a));
for i=1:length(dtft_a(:,1))
    sound(dtft_a(i, :));
end

dtft_b = abs(dtft(b));
for i=1:length(dtft_b(:,1))
    sound(dtft_b(i, :));
end
imshow(a)
imshow(b)