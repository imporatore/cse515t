% Define the number of trials and successes
n = 1000; % Total number of trials
x = 900;  % Number of successes
theta = linspace(0, 1, 1000); % Range of theta values (from 0 to 1)

%% (a) Uniform prior: Beta(1, 1)
alpha_a = 1;
beta_a = 1;

% Prior distribution
prior_a = betapdf(theta, alpha_a, beta_a);

% Posterior distribution
posterior_a = betapdf(theta, alpha_a + x, beta_a + n - x);

% Posterior mean (Beta distribution mean: alpha / (alpha + beta))
posterior_mean_a = (alpha_a + x) / (alpha_a + beta_a + n);

%% (b) Prior with extreme bias towards small theta: Beta(1, 100)
alpha_b = 1;
beta_b = 100;

% Prior distribution
prior_b = betapdf(theta, alpha_b, beta_b);

% Posterior distribution
posterior_b = betapdf(theta, alpha_b + x, beta_b + n - x);

% Posterior mean
posterior_mean_b = (alpha_b + x) / (alpha_b + beta_b + n);

%% (c) Custom prior with no support for theta > 1/2
% Define the custom prior
prior_c = 2 * (theta < 0.5); % Prior is 2 for theta < 0.5, 0 otherwise

% Posterior (only update for theta < 0.5, so beta function only applies there)
posterior_c = zeros(size(theta));
posterior_c(theta < 0.5) = betapdf(theta(theta < 0.5), x + 1, n - x + 1);

% Posterior mean (for theta < 0.5 only)
posterior_mean_c = trapz(theta(theta < 0.5), theta(theta < 0.5) .* posterior_c(theta < 0.5)) / ...
                   trapz(theta(theta < 0.5), posterior_c(theta < 0.5));

%% Plotting

% Plot (a) Uniform prior and posterior
figure;
subplot(3,2,1);
plot(theta, prior_a, 'r', 'LineWidth', 2);
title('Prior (a): Uniform');
xlabel('\theta');
ylabel('p(\theta)');

subplot(3,2,2);
plot(theta, posterior_a, 'b', 'LineWidth', 2);
title('Posterior (a)');
xlabel('\theta');
ylabel('p(\theta | D)');

% Plot (b) Prior with extreme bias toward small theta
subplot(3,2,3);
plot(theta, prior_b, 'r', 'LineWidth', 2);
title('Prior (b): Beta');
xlabel('\theta');
ylabel('p(\theta)');

subplot(3,2,4);
plot(theta, posterior_b, 'b', 'LineWidth', 2);
title('Posterior (b)');
xlabel('\theta');
ylabel('p(\theta | D)');

% Plot (c) Custom prior and posterior
subplot(3,2,5);
plot(theta, prior_c, 'r', 'LineWidth', 2);
title('Prior (c): Capped Uniform');
xlabel('\theta');
ylabel('p(\theta)');

subplot(3,2,6);
plot(theta, posterior_c, 'b', 'LineWidth', 2);
title('Posterior (c)');
xlabel('\theta');
ylabel('p(\theta | D)');

