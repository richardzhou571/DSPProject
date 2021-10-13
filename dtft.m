%2D DTFT Function:
function output = dtft(input)
    out_arr = zeros(201,201);
    % Create an array to hold w values for the x axis that are normalized
    % so the max and min are plus or minus pi
    u_arr = linspace(-100, 100, 201);
    u_arr = u_arr * (pi()/100);
    v_arr = linspace(-100, 100, 201);
    v_arr = v_arr * (pi()/100);
    %Loop throughfrequencies
    for u = 1:length(u_arr)
        for v = 1:length(v_arr)
            s = 0;
            %Loop through n values for summing in the dtft
            for m = 1:length(input(:,1))
                for n = 1:length(input(1,:))
                    s = s + (input(m, n) * exp(-((u_arr(u)*(m-1)) + (v_arr(v)*(n-1))) * 1j));
                end
            end
            out_arr(u, v) = s;
        end
    end
    output = out_arr;
end

