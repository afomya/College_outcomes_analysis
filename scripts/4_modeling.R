library(tidyverse)
library(broom)

model_df <- read_csv("data/processed/model_df.csv")

model_df <- model_df %>%
  mutate(CONTROL = factor(CONTROL))

# --------------------------------------------------
# Baseline Model: Enrollment Only
# --------------------------------------------------

# Baseline model tests whether enrollment alone predicts earnings
baseline_model <- lm(log_earnings ~ log_enrollment,data = model_df)

# print(tidy(baseline_model))

# print(glance(baseline_model))


# --------------------------------------------------
# Multiple Regression Model
# --------------------------------------------------

# Main model includes institutional size, selectivity,
# completion rate, student socioeconomic composition,
# cost, debt, and institution type
main_model <- lm(
  log_earnings ~
    log_enrollment +
    sat_avg +
    completion_rate +
    pell_pct +
    admission_rate +
    avg_cost +
    median_debt +
    CONTROL,
  data = model_df
)

# print(tidy(main_model))

# print(glance(main_model))

# --------------------------------------------------
# Model Comparison
# --------------------------------------------------

# Compare baseline and main model performance
model_comparison <- bind_rows(
  glance(baseline_model) %>%
    mutate(model = "Baseline: Enrollment Only"),

  glance(main_model) %>%
    mutate(model = "Main: Institutional Characteristics")
) %>%
  select(
    model,
    r.squared,
    adj.r.squared,
    sigma,
    AIC,
    BIC,
    p.value
  )

model_comparison

write_csv(model_comparison,"outputs/model_comparison.csv")

# --------------------------------------------------
# Predictions and Residuals
# --------------------------------------------------

# Adding fitted values and residuals from the main model
model_diagnostics <- model_df %>%
  mutate(
    predicted_log_earnings = predict(main_model, newdata = model_df),
    residuals = residuals(main_model)
  )


write_csv(model_diagnostics,"outputs/model_diagnostics.csv")


# --------------------------------------------------
# Diagnostic Plots
# --------------------------------------------------

# Residuals vs fitted values
ggplot(model_diagnostics, aes(x = predicted_log_earnings, y = residuals)) +
  geom_point(alpha = 0.4) +
  geom_hline(yintercept = 0) +
  labs(
    title = "Residuals vs Fitted Values",
    x = "Predicted Log Earnings",
    y = "Residuals"
  ) +
  theme_minimal()



# Q-Q plot
ggplot(model_diagnostics,aes(sample = residuals)) +
  geom_qq(alpha = 0.4) +
  geom_qq_line() +
  labs(
    title = "Q-Q Plot of Residuals",
    x = "Theoretical Quantiles",
    y = "Sample Quantiles"
  ) +
  theme_minimal()


# Observed vs predicted plot
ggplot(model_diagnostics, aes(x = predicted_log_earnings, y = log_earnings)) +
  geom_point(alpha = 0.4) +
  geom_abline(slope = 1, intercept = 0) +
  labs(
    title = "Observed vs Predicted Log Earnings",
    x = "Predicted Log Earnings",
    y = "Observed Log Earnings"
  ) +
  theme_minimal()

# --------------------------------------------------
# Coefficient Plot
# --------------------------------------------------

# Visualizing main model coefficients except intercept
coefficient_plot <- tidy(main_model) %>%
  filter(term != "(Intercept)") %>%
  mutate(term = reorder(term, estimate))

ggplot(coefficient_plot,aes(x = estimate, y = term)) +
  geom_col() +
  labs(
    title = "Main Model Coefficient Estimates",
    x = "Coefficient Estimate",
    y = ""
  ) +
  theme_minimal()


write_csv(tidy(main_model),"outputs/main_model_coefficients.csv")

write_csv(glance(main_model),"outputs/main_model_summary.csv")
