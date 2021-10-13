function X = dtft(a,b)
    output = zeros(1,2001);
    for m = 1:length(b)
        output(m) = 0; % assigning to zero
        for k = 1:length(a)
            output(m) = output(m) + a(k).*exp(1j*b(m)*-(k-1));
        end
    end
    X = output;
end

