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
w = linspace(-1000, 1000, 2001);
w = w * (pi()/1000);
image_dtft = fft(image_vec);
%image_dtft = dtft(image_vec, w); % 1x2001 double
image_dtft_mag = abs(image_dtft);
image_dtft_phase = angle(image_dtft);
toc;
fprintf("Completed DTFT.");

% convolve with chirp signal
fprintf("\n\nBeginning convolution of image with chirp signal...");
chirp_convolution_mag = conv(image_dtft_mag, y);
chirp_convolution_mag = chirp_convolution_mag';
chirp_convolution_phase = conv(image_dtft_phase, y);
chirp_convolution_phase = chirp_convolution_phase';

% Normalize the output to [-1, 1] (as required by the
% audio functions in MATLAB) by dividing by the maximum absolute value
% in chirp_convolution scaled slightly to ensure that the values in the
% vector are not equal to -1 or 1.
max_abs_chirp_mag = max(abs(chirp_convolution_mag));
chirp_convolution_mag = chirp_convolution_mag/(max_abs_chirp_mag*1.2);
max_abs_chirp_phase = max(abs(chirp_convolution_phase));
chirp_convolution_phase = chirp_convolution_phase/(max_abs_chirp_phase*1.2);

fprintf("\nCompleted convolution.");

% play the audio
%sound(chirp_convolution);

fprintf('\n\n');
disp(str_h);
disp(str_w);
fprintf('\n');

% save the file as a .wav
%filename = 'strawberry.wav';
filename_mag = 'diamond_helmet_mag.wav';
filename_phase = 'diamond_helmet_phase.wav';
audiowrite(filename_mag, chirp_convolution_mag, 4 * Fs);
audiowrite(filename_phase, chirp_convolution_phase, 4 * Fs);

