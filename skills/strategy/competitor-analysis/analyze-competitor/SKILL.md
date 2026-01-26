# Skill: Analyze Competitor

## Description

This skill performs a detailed analysis of a single competitor. It gathers information from the competitor's website, news articles, and review sites to produce a comprehensive overview. This skill is the logical next step after identifying a list of competitors.

## Prerequisites

- The name of the competitor to analyze.

## Instructions

### 1. Get Competitor Name

Prompt the user for the competitor's name.

- *Example prompt:* "Which competitor would you like me to analyze? Please provide their name."

### 2. Find Competitor Website

Use the `google_web_search` tool to find the official website for the competitor. A good query is `"[Competitor Name] official website"`. Select the most likely URL from the top results. If the search is ambiguous, confirm with the user.

- *Example prompt (if needed):* "I found a few possible websites for [Competitor Name]. Is the correct one `[URL]`?"

### 3. Analyze Core Website Content

Use the `web_fetch` tool to scrape and analyze key pages from the competitor's website. Focus on the following:

- **Homepage:** Identify the main value proposition, target audience, and key marketing messages.
- **Pricing Page:** Document the pricing tiers, features per tier, and overall pricing strategy (e.g., freemium, subscription, enterprise).
- **About Us Page:** Look for company mission, history, team size, and any stated values.
- **Blog/Resources:** Skim recent headlines to understand their content marketing strategy and focus topics.

### 3. Conduct External Research

Use the `google_web_search` tool to find external information and validate the findings from the website.

- **News and Press:**
  - `"([Competitor Name])" news`
  - `"([Competitor Name])" funding`
  - `"([Competitor Name])" press release`
- **Customer Reviews and Perception:**
  - `site:g2.com "([Competitor Name])"`
  - `site:capterra.com "([Competitor Name])"`
  - `site:reddit.com "([Competitor Name])" review`
- **Documentation (if applicable for software):**
  - `site:([competitor_url]) documentation` to understand the product's technical depth and features.

### 4. Synthesize the Analysis

Consolidate all the gathered information into a structured report. Organize the findings into the following sections:

- **Company Overview:**
  - Mission and Vision.
  - Publicly available information on size, funding, or history.
- **Product/Service Offering:**
  - Core features and functionality.
  - Unique Selling Proposition (USP).
- **Pricing Strategy:**
  - Summary of pricing tiers and models.
- **Marketing & Messaging:**
  - Primary target audience.
  - Key messages from their website.
- **Market Perception (Strengths & Weaknesses):**
  - Common praises from customers (Strengths).
  - Common complaints or missing features (Weaknesses).

### 5. Present the Findings

Deliver the structured report to the user.

- *Example Response:* "Here is a detailed analysis of [Competitor Name]:

  **Company Overview:**
  *   **Mission:** ...
  *   **Funding:** ...

  **Product/Service Offering:**
  *   **Core Features:** ...
  *   **Unique Selling Proposition:** ...

  **Pricing Strategy:**
  *   ...

  **Marketing & Messaging:**
  *   ...

  **Market Perception:**
  *   **Strengths:** ...
  *   **Weaknesses:** ...

  I can investigate any of these areas further if you wish."

## Success Criteria

- A structured report containing at least 4 of the 5 synthesis sections is delivered to the user.
- The user confirms the report is a helpful overview of the competitor.

## Failure Criteria

- Inability to find significant information on the competitor through web searches.
- The provided URL is invalid or inaccessible.
