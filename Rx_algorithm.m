clear; clc; close all;

load gong.mat;
load chirp.mat;

% % load chirp_convolution for magnitude and phase
% [chirp_convolution_mag, Fs] = audioread('diamond_helmet_mag.wav');
% [chirp_convolution_phase, Fs] = audioread('diamond_helmet_phase.wav');
% chirp_convolution_mag = chirp_convolution_mag'*(1.324384322502659e+04);
% chirp_convolution_phase = chirp_convolution_phase'*(66.9668);
% 
% % deconvolution
% [image_dtft_mag, rem_mag] = deconv(chirp_convolution_mag, y);
% [image_dtft_phase, rem_phase] = deconv(chirp_convolution_phase, y);
% image_dtft = image_dtft_mag .* exp(1j * image_dtft_phase);

[image_dtft_mag, Fs] = audioread('diamond_helmet_mag.wav');
[image_dtft_phase, Fs] = audioread('diamond_helmet_phase.wav');
image_dtft_mag = image_dtft_mag' * 1.296028235294118e+04;
image_dtft_phase = image_dtft_phase' * pi;
image_dtft = image_dtft_mag .* exp(1j * image_dtft_phase);

original_width = 362;
original_height = 362;

% IDTFT
image_vec = ifft(image_dtft);
image_vec = uint8(image_vec);

original_grayscale = reshape(image_vec, original_height, original_width);
imshow(original_grayscale);