clear; clc; close all;

load gong.mat;
load chirp.mat;


% define the normalization constants and image dimensions
normalization_constant_mag = 1.296028235294118e+04;
normalization_constant_phase = pi;
original_width = 362;
original_height = 362; 

% read in the magnitude and phase .wav files
fprintf("Unpacking waveforms...");
[image_dtft_mag, Fs] = audioread('diamond_helmet_mag.wav');
[image_dtft_phase, Fs] = audioread('diamond_helmet_phase.wav');

% introduce some gaussian noise (similar to how it is done in the EEG Lab
% example
image_dtft_mag = transpose((image_dtft_mag + randn(size(image_dtft_mag))/100));
image_dtft_phase = transpose((image_dtft_phase + randn(size(image_dtft_phase))/100));

% un-normalize the code with the provided constants above
% combine magnitude and phase into one matrix
image_dtft_mag = image_dtft_mag' * normalization_constant_mag;
image_dtft_phase = image_dtft_phase' * normalization_constant_phase;
image_dtft = image_dtft_mag .* exp(1j * image_dtft_phase);

fprintf("\nWaveforms recovered.");


% perform inverse discrete-time Fourier transform
fprintf("\nCalculating discrete-time Fourier transform...\n");
tic;
image_vec = ifft(image_dtft);
toc;
fprintf("Completed IDTFT.");
image_vec = abs(image_vec);

% reshaping waveform into matrix
original_noisy = reshape(image_vec, [original_width, original_height]);
fprintf("\nReshaped waveform into matrix.");

% display original image (noisy)
figure(1);
imshow(original_noisy);
title('Original Noisy Image');

% filter the noisy image with weiner filter
filtered_image = wiener2(original_noisy, [10,10]);

% display filtered image -- hooray!
figure(2);
imshow(filtered_image);
title('Filtered Original Image');

% save the reconstructed image as a .png
imwrite(filtered_image, 'diamond_helmet_reconstructed.png');
fprintf("\nSaved reconstructed image as a .png file.\n\nHooray!\n");

% comparison with original
figure(3)
imshow('diamond_helmet.png');
title('Original Sent Image');
