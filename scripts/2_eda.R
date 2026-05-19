# ==================================================
# College Earnings Analysis - Exploratory Data Analysis
# ==================================================

library(tidyverse)
library(corrplot)

college_clean <- read_csv("data/processed/college_clean.csv")

glimpse(college_clean)

# Count remaining missing values across variables
college_clean %>%
  summarize(across(everything(), ~sum(is.na(.))))


# Convert institution type and region into categorical variables
college_clean <- college_clean %>%
  mutate(
    CONTROL = factor(CONTROL),
    REGION = factor(REGION)
  )


# --------------------------------------------------
# Distribution Analysis
# --------------------------------------------------

# Visualize raw earnings distribution to assess skewness
ggplot(college_clean, aes(x = earnings)) +
  geom_histogram(bins = 30) +
  labs(
    title = "Distribution of Median Earnings",
    x = "Median Earnings",
    y = "Count"
  ) +
  theme_minimal()


# Visualize log-transformed earnings distribution
# to evaluate whether skewness improves

ggplot(college_clean, aes(x = log_earnings)) +
  geom_histogram(bins = 30) +
  labs(
    title = "Distribution of Log-Transformed Earnings",
    x = "Log Earnings",
    y = "Count"
  ) +
  theme_minimal()


# --------------------------------------------------
# Correlation Analysis
# --------------------------------------------------

# Select numeric variables for correlation analysis

numeric_vars <- college_clean %>%
  select(where(is.numeric))

# Compute pairwise correlations
# between numeric variables and visualize
par(mar = c(2,1,3,5))
cor_matrix <- cor(numeric_vars, use = "complete.obs")
corrplot(cor_matrix, method = "color",type = "lower",tl.cex = 0.8)

# --------------------------------------------------
# Relationship Analysis
# --------------------------------------------------

# Explore relationship between enrollment and earnings
ggplot(college_clean,aes(x = enrollment, y = earnings)) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "lm") +
  theme_minimal() +
  labs(
    title = "Enrollment vs Earnings",
    x= "Enrollment",
    y= "Median Earnings"
  )

# Explore relationship after log transformations
ggplot(college_clean, aes(x = log_enrollment, y = log_earnings)) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "lm") +
  theme_minimal() +
  labs(
    title = "Log Enrollment vs Earnings",
    x= "Log Enrollment",
    y= "Median Earnings"
  )

# --------------------------------------------------
# Categorical Comparisons
# --------------------------------------------------

# Compare earnings distributions across institution types
ggplot(college_clean, aes(x = CONTROL, y = earnings)) +
  geom_boxplot() +
  scale_x_discrete(labels = c("Public","Private Nonprofit","Private For-Profit")) +
  labs(
    title = "Earnings by Institution Type",
    y="Median Earnings",
    x=""
    ) +
  theme_minimal()

