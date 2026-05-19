# College Outcomes Analysis

## Project Overview

This project analyzes how institutional characteristics are associated with median student earnings 10 years after college entry using data from the U.S. Department of Education’s College Scorecard database. The analysis combines exploratory data analysis, feature engineering, and multiple linear regression to better understand which institutional factors are most strongly related to post-graduation earnings outcomes.

### Main Question

To what extent can undergraduate institutional characteristics predict median student earnings 10 years after college entry?

---

## Dataset Source

The dataset used in this project comes from the U.S. Department of Education’s College Scorecard database, which contains institution-level information on college costs, student demographics, completion outcomes, and post-graduation earnings.

- Source: [College Scorecard Data](https://collegescorecard.ed.gov/data/)
- Provider: U.S. Department of Education

---

## Tools

- **R**
- **tidyverse**
- **ggplot2**
- **broom**
- **R Markdown**

---

## Methods

The project was completed in several stages:

- Cleaned and filtered institutional-level data
- Applied log transformations to highly skewed variables
- Conducted exploratory data analysis and correlation analysis
- Built a baseline linear regression model using enrollment only
- Built a multiple regression model using institutional characteristics
- Evaluated model performance using diagnostic plots and regression metrics

The final model included:
- Log enrollment
- SAT average
- Completion rate
- Pell Grant percentage
- Admission rate
- Average cost
- Median debt
- Institution type

---

## Visualizations

### Earnings Distribution

```{r, out.width="50%", fig.align="center"}
knitr::include_graphics("../outputs/Distribution_of_Median_Earnings.png")
```

```{r, out.width="50%", fig.align="center"}
knitr::include_graphics("../outputs/Distribution_of_Log-Transformed_Earnings.png")
```

### Enrollment and Earnings

```{r, out.width="50%", fig.align="center"}
knitr::include_graphics("../outputs/Enrollment_vs_Earnings.png")
```

```{r, out.width="50%", fig.align="center"}
knitr::include_graphics("../outputs/Log_Enrollment_vs_Earnings.png")
```

### Earnings by Institution Type

```{r, out.width="50%", fig.align="center"}
knitr::include_graphics("../outputs/Earnings_by_Institution_Type.png")
```

### Correlation Matrix

```{r, out.width="60%", fig.align="center"}
knitr::include_graphics("../outputs/Correlation_Matrix.png")
```

### Model Coefficients

```{r, out.width="55%", fig.align="center"}
knitr::include_graphics("../outputs/Main_Model_Coefficient_Estimates.png")
```

### Diagnostic Plots

```{r, out.width="55%", fig.align="center"}
knitr::include_graphics("../outputs/Observed_vs_predicted_plot.png")
```

```{r, out.width="55%", fig.align="center"}
knitr::include_graphics("../outputs/Residuals_vs_Fitted_Values.png")
```

```{r, out.width="55%", fig.align="center"}
knitr::include_graphics("../outputs/Q-Q_plot.png")
```

---

## Results

The multiple regression model substantially outperformed the baseline enrollment-only model, achieving an R-squared of approximately 0.58. The results suggest that institutional earnings outcomes are associated with a combination of selectivity, student demographics, graduation success, and institutional structure rather than school size alone.

Several variables showed strong relationships with earnings:
- Higher completion rates were associated with higher predicted earnings
- More selective institutions tended to have stronger earnings outcomes
- Pell Grant percentage showed a negative relationship with earnings
- Institution type remained important even after controlling for other variables

Diagnostic plots showed that the model performed reasonably well overall, with residuals generally centered around zero and predicted values closely tracking observed earnings outcomes.

---

## Limitations

- The analysis identifies associations rather than causal relationships
- Institutional-level data cannot capture individual student experiences
- External factors such as labor markets and field of study were not included
- Real-world educational and economic data only approximately satisfy linear regression assumptions
