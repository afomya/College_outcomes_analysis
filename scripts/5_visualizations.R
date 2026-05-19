# --------------------------------------------------
# Visualization Script
# --------------------------------------------------
# This script creates the final visualizations used
# throughout the project report and README.
# The plots focus on model performance, residual diagnostics,
# and coefficient interpretation.
# --------------------------------------------------

library(tidyverse)

# --------------------------------------------------
# Load model outputs
# --------------------------------------------------

model_diagnostics <- read_csv("outputs/model_diagnostics.csv")
model_comparison <- read_csv("outputs/model_comparison.csv")
main_coefficients <- read_csv("outputs/main_model_coefficients.csv")


# --------------------------------------------------
# Observed vs Predicted Plot
# --------------------------------------------------
# Comparing actual log earnings to model predictions.
# A stronger linear pattern suggests better model fit.

observed_vs_predicted <- ggplot(
  model_diagnostics,
  aes(x = predicted_log_earnings, y = log_earnings)
) +
  geom_point(alpha = 0.4) +
  geom_abline(
    slope = 1,
    intercept = 0,
    linewidth = 1
  ) +
  labs(
    title = "Observed vs Predicted Log Earnings",
    x = "Predicted Log Earnings",
    y = "Observed Log Earnings"
  ) +
  theme_minimal(base_size = 14)

observed_vs_predicted



# --------------------------------------------------
# Residuals vs Fitted Plot
# --------------------------------------------------
# Checking whether residuals are randomly spread around zero.
# Clear patterns could suggest the model is missing structure.

residuals_vs_fitted <- ggplot(
  model_diagnostics,
  aes(x = predicted_log_earnings, y = residuals)
) +
  geom_point(alpha = 0.4) +
  geom_hline(
    yintercept = 0,
    linewidth = 1
  ) +
  labs(
    title = "Residuals vs Fitted Values",
    x = "Predicted Log Earnings",
    y = "Residuals"
  ) +
  theme_minimal(base_size = 14)

residuals_vs_fitted



# --------------------------------------------------
# Q-Q Plot
# --------------------------------------------------
# Used to check whether residuals are approximately normal.
# Points close to the line suggest better normality.

qq_plot_residuals <- ggplot(
  model_diagnostics,
  aes(sample = residuals)
) +
  geom_qq(alpha = 0.4) +
  geom_qq_line(linewidth = 1) +
  labs(
    title = "Q-Q Plot of Residuals",
    x = "Theoretical Quantiles",
    y = "Sample Quantiles"
  ) +
  theme_minimal(base_size = 14)

qq_plot_residuals



# --------------------------------------------------
# Coefficient Plot
# --------------------------------------------------
# Visualizing how each variable affects predicted earnings.
# Positive coefficients increase predicted earnings while
# negative coefficients decrease them.

coefficient_plot_data <- main_coefficients %>%
  filter(term != "(Intercept)") %>%
  mutate(term = reorder(term, estimate))

coefficient_plot <- ggplot(
  coefficient_plot_data,
  aes(x = estimate, y = term)
) +
  geom_col() +
  geom_vline(
    xintercept = 0,
    linewidth = 1
  ) +
  labs(
    title = "Main Model Coefficient Estimates",
    x = "Coefficient Estimate",
    y = ""
  ) +
  theme_minimal(base_size = 14)

coefficient_plot


# --------------------------------------------------
# Model Comparison Plot
# --------------------------------------------------
# Comparing baseline and full model performance using R-squared.
# Higher R-squared values indicate better explanatory power.

model_comparison_plot <- model_comparison %>%
  ggplot(aes(x = reorder(model, r.squared), y = r.squared)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Model Comparison by R-Squared",
    x = "",
    y = "R-Squared"
  ) +
  theme_minimal(base_size = 14)

model_comparison_plot



