% read in RGB image
color_image = imread('bladerunner.jpeg');
imshow(color_image)

% convert RGB image to grayscale using rgb2gray()
grayscale_image = rgb2gray(color_image);
figure
imshow(grayscale_image)

% push all image values to a row vector (MxN image to 1xM*N vector)
image_vec = reshape(grayscale_image, 1, []);
expected_dims = [1 size(grayscale_image,1)*size(grayscale_image,2)];

% sanity check for image vector
assert(expected_dims == size(image_vec), "Image vector conversion failed!");