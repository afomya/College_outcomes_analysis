# ==================================================
# College Earnings Analysis - Exploratory Data Analysis
# ==================================================

library(tidyverse)
library(corrplot)

college_clean <- read_csv("data/processed/college_clean.csv")

glimpse(college_clean)

college_clean %>%
  summarize(across(everything(), ~sum(is.na(.))))

college_clean <- college_clean %>%
  mutate(
    CONTROL = factor(CONTROL),
    REGION = factor(REGION)
  )

ggplot(college_clean, aes(x = earnings)) +
  geom_histogram(bins = 30) +
  labs(
    title = "Distribution of Median Earnings",
    x = "Median Earnings",
    y = "Count"
  ) +
  theme_minimal()

ggplot(college_clean, aes(x = log_earnings)) +
  geom_histogram(bins = 30) +
  labs(
    title = "Distribution of Log-Transformed Earnings",
    x = "Log Earnings",
    y = "Count"
  ) +
  theme_minimal()
# Log transform reduced skewness


numeric_vars <- college_clean %>%
  select(where(is.numeric))

par(mar = c(2,1,3,5))
cor_matrix <- cor(numeric_vars, use = "complete.obs")
corrplot(cor_matrix, method = "color",type = "lower",tl.cex = 0.8)


ggplot(
  college_clean,
  aes(x = enrollment, y = earnings)
) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "lm") +
  theme_minimal() +
  labs(
    title = "Enrollment vs Earnings",
    x= "Enrollment",
    y= "Median Earnings"
  )

ggplot(
  college_clean,
  aes(x = log_enrollment, y = log_earnings)
) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "lm") +
  theme_minimal() +
  labs(
    title = "Log Enrollment vs Earnings",
    x= "Log Enrollment",
    y= "Median Earnings"
  )


ggplot(college_clean, aes(x = insitution_type, y = earnings)
) +geom_boxplot() +
  scale_fill_discrete(
    labels = c(
      "Public",
      "Private Nonprofit",
      "Private For-Profit"
    )
  ) +
  labs(
    title = "Earnings by Institution Type",
    x="",
    y="Median Earnings"
    ) +
  theme_minimal()

