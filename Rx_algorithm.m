clear; clc; close all;

load gong.mat;
load chirp.mat;



[image_dtft_mag, Fs] = audioread('diamond_helmet_mag.wav');
[image_dtft_phase, Fs] = audioread('diamond_helmet_phase.wav');
image_dtft_mag = image_dtft_mag' * 1.296028235294118e+04;
image_dtft_phase = image_dtft_phase' * pi;
image_dtft = image_dtft_mag .* exp(1j * image_dtft_phase);

original_width = 362;
original_height = 362; 

% IDTFT
image_vec = ifft(image_dtft);
image_vec = abs(image_vec);

original_grayscale = reshape(image_vec, [original_width, original_height]);
imshow(original_grayscale);