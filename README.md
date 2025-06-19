# Gamezone Sales Analysis
## Project Background
Gamezone is an e-commerce company founded in 2018, specializing in new and refurbishsed gaming products all around the world. 
Their primary selling channel is their online website but they also have a mobile app and they use various other marketing channels to find their potential customers.
I conduct this analysis due to the Business Development Department to extract insights and deliver recommendations to improve performance across sales, product and marketing teams.
## Executive Summary
Gamezone experienced strong sales growth from 2019 to 2020, with annual revenue surging by 163% amid the pandemic. The U.S. market alone contributed approximately 50% of total revenue. Gaming Monitors, Nintendo Switch, and PlayStation Bundles consistently accounted for 85% of revenue. While both unique and repeat customer counts doubled in 2020, the repeat purchase rate declined slightly from 2.1% to 1.9%, indicating difficulty driving second purchases. The direct marketing channel remained the primary revenue driver, generating 85% of total sales, while the website dominated as the main purchase platform with 97% of total revenue.
## Objectives
## Data overview
![gamezone erd drawio](https://github.com/user-attachments/assets/24e834e0-66fb-4299-8808-6308a14f0a1e)

**Data Sources:** This data comes from our online ordering system, which captures transaction-level details of customer purchases.
**Time Period:** The dataset spans from January 1, 2019, to February 28, 2021. However, for this analysis, only records between January 1, 2019, and December 31, 2020 are included to ensure consistency and completeness.
**Key Tables/Entities:**
- **Orders Table:** Includes order ID, user ID, purchase timestamp, ship timestamp, product name, product ID, price in USD, purchase platform, marketing channel and country code. Over 21,000 transactions were recorded in this dataset.
- **Region Table:** Lists all country codes (e.g.,VN, UK) and region accordingly (e.g., NA, EMEA)
**Data Quality Notes:** Several data quality issues were identified and addressed during the preprocessing stage (e.g., missing values, inconsistent product names). All issues, transformations and fixes (if possible) are documented in the issue log for full transparency.
