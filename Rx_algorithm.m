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
original_grayscale = reshape(image_vec, [original_width, original_height]);
fprintf("\nReshaped waveform into matrix.\n\nHooray!\n");

% display original image -- hooray!
imshow(original_grayscale);