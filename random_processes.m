% setup an ar(1) process
alpha = 0.8; 
numerator = [1-alpha^2 0];
denominator = [-alpha 1+alpha^2 -alpha];
autocorrelation = alpha.^(abs(linspace(-25,25,50)));

% create noise data and filter them 
data = filter(denominator, numerator, randn(1,1000));

% compare theoretical autocorrelation to the real one
[acf,lags] = autocorr(data);
MAX = length(autocorrelation);

from = randi([1 MAX]); % boundaries
diff = randi([1 MAX-from]); % random distance of boundaries
to = from + diff;
depth = randi([1 MAX-to]); % random prediction depth
boundaries = [from to;...
              from+depth to+depth]
Ry = autocorrelation(from:to); % input of wiener filter
Rdy = autocorrelation(from+depth:to+depth); % desired output 
Ry = autocormatrix(Ry); % autocorrelation matrix of input
wiener = Ry\transpose(Rdy) % coefficients of wiener filter

output = conv(data(1:50),wiener);
pred = prediction(data(length(wiener)+1:2*length(wiener)+1),wiener,length(wiener)+1)
data(depth)

function result = prediction(input,coeffs,from)
    result = 0;
    counter = length(coeffs);
    while (counter>0)
        result = result + coeffs(counter)*input(from-counter);
        counter = counter-1;
    end
end
