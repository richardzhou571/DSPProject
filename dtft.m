%Part a - DTFT Function:
function output = dtft(input)
    out_arr = zeros(1,2001);
    % Create an array to hold w values for the x access that are normalized
    % so the max and min are plus or minus pi
    w_arr = linspace(-1000, 1000, 2001);
    w_arr = w_arr * (pi()/1000);
    %Loop throughfrequencies
    for a = 1:length(w_arr)
        s = 0;
        %Loop through n values for summing in the dtft
        for n = 1:length(input)
            s = s + (input(n) * exp(-(n-1) * w_arr(a) * 1j));
        end
        out_arr(a) = s;
    end
    output = out_arr;
end

