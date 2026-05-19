# ==================================================
# College Earnings Analysis - Data Cleaning
# ==================================================

library(tidyverse)

college <- read_csv("data/raw/Most-Recent-Cohorts-Institution.csv")


# Select and rename institutional variables related to earnings outcomes
college_clean <- college %>%
  select(
    MD_EARN_WNE_P10,
    UGDS,
    ADM_RATE,
    SAT_AVG,
    COSTT4_A,
    PCTPELL,
    C150_4,
    DEBT_MDN,
    CONTROL,
    REGION
  ) %>%
  rename(
    earnings = MD_EARN_WNE_P10,
    enrollment = UGDS,
    admission_rate = ADM_RATE,
    sat_avg = SAT_AVG,
    avg_cost = COSTT4_A,
    pell_pct = PCTPELL,
    completion_rate = C150_4,
    median_debt = DEBT_MDN
  )


# Convert selected variables to numeric and remove rows with missing values
college_clean <- college_clean %>%
  mutate(
    across(
      c(
        earnings,
        enrollment,
        admission_rate,
        sat_avg,
        avg_cost,
        pell_pct,
        completion_rate,
        median_debt
      ),
      as.numeric
    )
  ) %>%
  drop_na(earnings, enrollment)

# Create transformed variables to reduce skewness
# Previous analysis showed the earnings and enrollment were heavily right skewed
college_clean <- college_clean %>%
  mutate(
    log_earnings = log(earnings),
    log_enrollment = log(enrollment + 1)
  )

# Convert categorical variables to factors
college_clean <- college_clean %>%
  mutate(
    CONTROL = factor(CONTROL),
    REGION = factor(REGION)
  )


write_csv(college_clean, "data/processed/college_clean.csv")
