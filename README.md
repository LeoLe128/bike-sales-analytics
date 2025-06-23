# Gamezone Sales Analysis
## Project Background
Gamezone is an e-commerce company founded in 2018, specializing in new and refurbishsed gaming products all around the world. 
Their primary selling channel is their online website but they also have a mobile app and they use various other marketing channels to find their potential customers.
I conduct this analysis due to the Business Development Department to extract insights and deliver recommendations to improve performance across sales, product and marketing teams.
## Executive Summary
Gamezone experienced strong sales growth from 2019 to 2020, with annual revenue surging by 163% amid the pandemic. The U.S. market alone contributed approximately 50% of total revenue. Gaming Monitors, Nintendo Switch, and PlayStation Bundles consistently accounted for 85% of revenue. While both unique and repeat customer counts doubled in 2020, the repeat purchase rate declined slightly from 2.1% to 1.9%, indicating difficulty driving second purchases. The direct marketing channel remained the primary revenue driver, generating 85% of total sales, while the website dominated as the main purchase platform with 97% of total revenue.
## Objectives
The objective of this analysis is to examine online order data from January 2019 to December 2020. The analysis aims to uncover key trends in sales, customer behavior, and performance across regions, countries, marketing channels, and purchase platforms, as well as identify data quality issues.
## Data overview
<p align="center">
  <img src="https://github.com/user-attachments/assets/48b30b7e-0265-4653-9d93-17f03d8733b9" alt="Dataset ERD"/>
</p>

**Data Sources:** This data comes from our online ordering system, which captures transaction-level details of customer purchases.
**Time Period:** The dataset spans from January 1, 2019, to February 28, 2021. However, for this analysis, only records between January 1, 2019, and December 31, 2020 are included to ensure consistency and completeness.

**Key Tables/Entities:**
- **Orders Table:** Includes order ID, user ID, purchase timestamp, ship timestamp, product name, product ID, price in USD, purchase platform, marketing channel and country code. Over 21,000 transactions were recorded in this dataset.
- **Region Table:** Lists all country codes (e.g.,VN, UK) and region accordingly (e.g., NA, EMEA)

**Data Quality Notes:** Several data quality issues were identified and addressed during the preprocessing stage (e.g., missing values, inconsistent product names). All issues, transformations and fixes (if possible) are documented in the issue log for full transparency.
<p align="center">
  <img src="https://github.com/user-attachments/assets/dcc3033a-b617-4518-9f42-da6127101191"/>
</p>

## Sales trend and growth rates
- Between 2019 and 2020, Gamezone generated an average annual revenue of $2.8 million with approximately 10,000 orders per year.
- In 2020, sales experienced a significant 163% increase compared to 2019, largely driven by the surge in online shopping during the pandemic.
- Seasonality patterns were observed:
    - Stable performance from March through August.
    - Volatile sales from September to December:
        - Sharp increase in September
        - Noticeable dip in October
        - Peak sales in November and December, likely driven by Black Friday, Cyber Monday, and holiday promotions.
- North America and EMEA jointly contribute over 80% of total sales. The US market dominates, accounting for approximately 50% of total revenue. Meanwhile the UK - the second-largest market contributes just 7.6%, highlighting a significant gap between the top market and all others. This concentration underscores the importance of safeguarding U.S. market performance, while also prioritizing growth in underdeveloped but promising regions.
- All regions saw strong year-over-year growth in 2020 across key metrics. Among them:
    - APAC emerged as a high-potential market, with ~200% growth in sales and a ~50% increase in Average Order Value (AOV).
    - LATAM led in order volume growth, with ~140% more orders and ~190% growth in annual revenue.
## Key product performance
- In 2020, the Sony PlayStation Bundle saw a dramatic surge in performance, with nearly 400% year-over-year growth in both revenue and order volume.
- Across 2019 - 2020, three products (Gaming Monitor, Nintendo Switch, and PlayStation Bundle) consistently accounted for 85% of total revenue. Notably, the Sony PlayStation Bundle saw a significant decline in revenue share, dropping from 35% in 2019 to 23% in 2020. In contrast, the Nintendo Switch’s revenue share doubled from 12% to 25%, overtaking the PS5 Bundle as the second strongest revenue driver in 2020.
- The Gaming Monitor remained the top-performing product, generating $1.9 million, which equals 32% of total revenue over the two-year period.
- The Nintendo Switch led in order volume, representing 48% of all orders and contributing $1.5 million in revenue, making it the second-highest revenue generator.
- The JBL Quantum 100 Gaming Headset accounted for approximately 20% of total orders, yet contributed less than 2% of revenue, likely due to its low unit price or promotional bundling

## Customers Growth and Repeat Purchase Trends
- Gamezone’s unique customer base more than doubled from 2019 to 2020, reflecting strong acquisition growth.
- While the number of repeat customers also doubled, increasing from 116 to 214, the repeat purchase rate declined from 2.1% in 2019 to 1.9% in 2020, signaling significant challenges in customer retention.

## Sales by Marketing Channel and Purchase Platform
- The direct channel is the dominant sales driver, accounting for 85% of total revenue ($4.8M).
- Despite generating just 3.4% of total orders, affiliate channels deliver the highest Average Order Value (AOV) at $309, highlighting their value in high-ticket conversions. In contrast, email campaigns have the lowest AOV at $185, suggesting smaller or more promotional transactions.
- Excluding unknown channels, social media is the weakest-performing channel, contributing only ~1.2% of revenue and ~1.5% of orders across 2019–2020.
- Affiliate channels have the highest average order value (AOV) at $309 while only account for only 3.4% of total orders, while email campaigns have the lowest AOV at $185.
- By purchase platform: The website is the primary sales channel, contributing 97% of total revenue ($5.5M) with an AOV of $300. Meanwhile, the mobile app underperforms, bringing in only $138K in sales and an AOV of $80.

## Recommendations
#### Maximizing Product Potential

- Double Down on High-Performers
    - **Expand winning categories** (e.g., Gaming Monitors, Nintendo Switch, PS5 Bundles) by introducing more variety (new colors, premium editions, or limited bundles) to attract repeat buyers and strengthen market presence.
    - On both platforms, highlight these with badges like “#1 Best Seller” or “Most Loved” and feature top-rated customer reviews to boost conversion.
- **Monetize Low-Price Volume Drivers**: Products like the JBL Quantum 100 Gaming Headset, which generate high order volume but low revenue, can be repositioned to drive higher AOV:
    - Bundle it with high-value items or complementary accessories (e.g., chargers, cases, cables).
    - Utilize dynamic bundling by offering bundle discount such as *"Buy together and save X%".*
    - Suggest upgrades (upsell) or complementary items (cross-sell) during the purchase journey
    - Encourage bulk purchase (e.g., “Buy 2, get 10% off” or free shipping over a set threshold)

#### Drive Repeat Purchase and Customer Retention

- **Loyalty & Lifecycle Marketing**
    - Launch a point-based or tiered loyalty program that rewards spending with perks like exclusive discounts, early access to new drops, free shipping, or VIP offers.
    - Encourage retention with “Welcome Back” incentives (e.g., 10% off second purchase) and free shipping for returning customers.
- **Smart Follow-Ups Based on Behavior**
    - Use post-purchase recommendations: e.g., follow up a laptop purchase with offers on gaming mice or cooling stands.
    - Identify repeat buyers and analyze their behavior to refine targeting, timing, and product mix.
- **Engagement Tactics**
    - Build community engagement through user-generated content, social contests, and milestone celebrations (e.g., birthdays or order anniversaries).
    - Introduce referral rewards to activate word-of-mouth acquisition.

#### Optimizing Marketing Channels and Purchase Platforms

- **Expand Affiliate Partnerships**: Increase reach and AOV by partnering with tech influencers and deal platforms. Tailor commission tiers and creative assets to partner type.
- Utilize both purchase platforms to get use of their strength.
    - Website - Acquisition Engine: Enhance discoverability of the website through search engine optimization and top-funnel content. Use the website’s strength in SEO and product research to attract first-time buyers, especially for high-consideration items like laptops.
    - Mobile App - Retention and Engagement Engine: Invest in app-specific perks (e.g., exclusive offers, flash deals, and in-app loyalty rewards) and improve personalization via behavioral tracking and push notifications.

#### Regional Growth Strategies

- **Focus on High-Performing Regions - North America and EMEA**
    - Continue allocating marketing and fulfillment resources to these high-performing regions.
    - Use region-specific campaigns and optimize inventory based on local buying behavior
- **Accelerate Growth in APAC and LATAM**
    - Leverage local influencers, payment methods, and promotions tailored to cultural and pricing sensitivities.
    - Launch micro-pilot campaigns in priority markets of each region before scaling.

## Clarifying Questions, Assumptions, and Caveats
### Questions for Stakeholders Prior to Project Advancement
- Types of marketing channels clarification: How is the direct marketing channel distinguished from the email channel and social media channel?

### Assumptions 
- I assumed that one product can have different product IDs and prices across different sales channels, countries and regions
- I will assume that when a single user places two orders for identical products at the exact same time, these should be treated as a single logical purchase event representing multiple units of that product. Therefore, for analytical purposes, I will combine these into one logical order, counting the quantity of the product as 2.

### Caveats
- 145 seperate orders are generated by 2 different customers with 2 distinct user_id at the same time. For the purpose of this analysis, the first encountered user_id is assigned to for the problematic order_ids, the other is dropped.
