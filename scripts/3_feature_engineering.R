# --------------------------------------------------
# Feature Engineering
# --------------------------------------------------

# Recode institution type labels for interpretability
college_clean <- college_clean %>%
  mutate(
    CONTROL = recode(
      CONTROL,
      `1` = "Public",
      `2` = "Private Nonprofit",
      `3` = "Private For-Profit"
    ),
    CONTROL = factor(CONTROL)
    )

# Standardize SAT scores
college_clean <- college_clean %>%
  mutate(sat_scaled = as.numeric(scale(sat_avg)))

# Create modeling dataset with complete observations
model_df <- college_clean %>%
  drop_na(
    log_earnings,
    log_enrollment,
    sat_avg,
    completion_rate,
    pell_pct,
    admission_rate,
    avg_cost,
    median_debt,
    CONTROL
  )


write_csv(model_df, "data/processed/model_df.csv")
