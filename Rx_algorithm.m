clear; clc; close all;

load gong.mat;
load chirp.mat;

[chirp_convolution, Fs] = audioread('diamond_helmet.wav');
chirp_convolution = chirp_convolution*(1.2*1.324384322502659e+04);
[image_dtft, rem] = deconv(chirp_convolution, y);

image_vec = ifft(image_dtft);