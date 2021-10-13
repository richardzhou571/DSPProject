clear; clc; close all;

load gong.mat;
load chirp.mat;

% read in RGB image
color_image = imread('diamond_helmet.png');
imshow(color_image)

% convert RGB image to grayscale using rgb2gray()
grayscale_image = rgb2gray(color_image);
figure
imshow(grayscale_image)
img_height = size(grayscale_image, 1);
img_width = size(grayscale_image, 2);
sprintf('Image height: %d', img_height);
sprintf('Image width: %d', img_width);

% push all image values to a row vector (MxN image to 1xM*N vector)
image_vec = reshape(grayscale_image, 1, []);

% sanity check for image vector
expected_dims = [1 img_height*img_width];
actual_dims = [1 size(image_vec, 1)*size(image_vec, 2)];
assert(isequal(expected_dims,actual_dims), "Image vector conversion failed!");

% convert image_vec from uint8 to doubles to work with gong.mat library to
% play sounds
image_vec = im2double(image_vec);

w = linspace(-1000, 1000, 2001);
w = w * (pi()/1000);
image_dtft = abs(dtft(image_vec, w));
chirp_convolution = conv(image_dtft, y)';

filename = 'diamond_helmet.wav';
audiowrite(filename,chirp_convolution,Fs);
sound(chirp_convolution);



%sound(image_vec);