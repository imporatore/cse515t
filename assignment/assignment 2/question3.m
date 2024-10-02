% Define the range for c (0 < c < 10, excluding 0 and 10)
c_vals = linspace(0.01, 9.99, 999);

% Initialize array for theta_hat
theta_hat_vals = zeros(size(c_vals));

% Loop to compute theta_hat for each value of c
for i = 1:length(c_vals)
    c = c_vals(i);
    
    if abs(c - 2) < 1e-6
        % When c is approximately 2, set theta_hat to 0
        theta_hat_vals(i) = 0;
    elseif c < 2
        % Define the function to solve (equation 1 from the image)
        f = @(theta_hat) theta_hat - theta_hat * erf(theta_hat / sqrt(2)) - ...
            (2 - c) / sqrt(2*pi) * exp(-theta_hat^2 / 2);
        
        % Solve for theta_hat using fzero (find root of the equation)
        theta_hat_vals(i) = fzero(f, 0);  % restrict solution range based on condition 0 < theta_hat < sqrt((2-c)/c)
    else
        % Define the function to solve (equation 1 from the image)
        f = @(theta_hat) theta_hat - theta_hat * erf(theta_hat / sqrt(2)) - ...
            (2 - c) / sqrt(2*pi) * exp(-theta_hat^2 / 2);
        
        % Solve for theta_hat using fzero (find root of the equation)
        theta_hat_vals(i) = fzero(f, 0); 
    end
end

% Plot the result
figure;
plot(c_vals, theta_hat_vals, 'LineWidth', 2);
xlabel('c');
ylabel('\theta');
grid on;
