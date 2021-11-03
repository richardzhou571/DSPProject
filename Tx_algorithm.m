clear; clc; close all;

load gong.mat;
load chirp.mat;

fprintf("Loading RGB image and converting to grayscale row vector...");

% read in RGB image
color_image = imread('diamond_helmet.png');
%color_image = imread('strawberry.jpg');
imshow(color_image)

% convert RGB image to grayscale using rgb2gray()
grayscale_image = rgb2gray(color_image);
figure
imshow(grayscale_image)
img_height = size(grayscale_image, 1);
img_width = size(grayscale_image, 2);
str_h = sprintf('Image height: %d', img_height);
str_w = sprintf('Image width: %d', img_width);

% push all image values to a row vector (MxN image to 1xM*N vector)
image_vec = reshape(grayscale_image, 1, []);

% sanity check for image vector
expected_dims = [1 img_height*img_width];
actual_dims = [1 size(image_vec, 1)*size(image_vec, 2)];
assert(isequal(expected_dims,actual_dims), "Image vector conversion failed!");

% convert image_vec from uint8 to doubles to work with gong.mat library to
% play sounds
image_vec = im2double(image_vec); % 1x131044 double

fprintf("\nCompleted image loading and conversion.");

% use discrete-time Fourier transform, then convolve with the Chirp signal
fprintf("\n\nCalculating discrete-time Fourier transform...\n");
tic;
image_dtft = fft(image_vec); % 1x2001 double
image_dtft_mag = abs(image_dtft);
image_dtft_phase = angle(image_dtft);
filename_mag = 'diamond_helmet_mag.wav';
filename_phase = 'diamond_helmet_phase.wav';
toc;
fprintf("Completed DTFT.");

% normalize DTFTs
max_dtft_mag = max(abs(image_dtft_mag));
image_dtft_mag = image_dtft_mag/max(abs(image_dtft_mag));
max_dtft_phase = max(abs(image_dtft_phase));
image_dtft_phase = image_dtft_phase/max(abs(image_dtft_phase));

audiowrite(filename_mag, image_dtft_mag, Fs);
audiowrite(filename_phase, image_dtft_phase, Fs);

fprintf('\n\n');
disp(str_h);
disp(str_w);
fprintf('\n');