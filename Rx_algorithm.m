clear; clc; close all;

load gong.mat;

filename = 'rotunda';

% define the normalization constants and image dimensions
normalization_constant_mag = 9.0447e5;
normalization_constant_phase = pi;
original_width = 1000;
original_height = 1500; 

% read in the magnitude and phase .wav files
fprintf("Unpacking waveforms...");
[image_dtft_mag, Fs] = audioread(strcat(filename, '_mag.wav'));
[image_dtft_phase, Fs] = audioread(strcat(filename, '_phase.wav'));

% introduce some gaussian noise (similar to how it is done in the EEG Lab
% example
image_dtft_mag_noise = randn(size(image_dtft_mag))/10000;
image_dtft_phase_noise = randn(size(image_dtft_phase))/10000;
image_dtft_mag = transpose((image_dtft_mag + image_dtft_mag_noise));
image_dtft_phase = transpose((image_dtft_phase + image_dtft_phase_noise));

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
title('Reconstructed Noisy Image');
imwrite(original_noisy, strcat(filename, '_reconstructed_noisy.png'));

% filter the noisy image with weiner filter
filtered_image = wiener2(original_noisy, [5, 5]);

% display filtered image -- hooray!
figure(2);
imshow(filtered_image);
title('Filtered Reconstructed Image');

% save the reconstructed image as a .png
imwrite(filtered_image, strcat(filename, '_reconstructed_filtered.png'));
fprintf("\nSaved reconstructed image as a .png file.\n\nHooray!\n");

% comparison with original
figure(3)
imshow(strcat(filename, '_grayscale.png'));
title('Original Sent Image');
