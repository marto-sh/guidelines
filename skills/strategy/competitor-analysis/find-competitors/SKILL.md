# Skill: Find Main Competitors

## Description

This skill identifies the main competitors for a product, company, or business idea within a specific market. It focuses on discovering _who_ the competitors are, rather than conducting a deep-dive analysis of their strengths and weaknesses. The output is a clear, consolidated list of competitor names.

## Prerequisites

A clear and concise description of the product, service, or company to be analyzed. This should include:

- The core problem it solves.
- The target audience or customer segment.
- Any known competitors.

## Instructions

### 1. Understand the Domain

Prompt the user for the necessary information listed in the prerequisites. If the user's input is vague, ask clarifying questions to get a better understanding of the market segment.

Example prompt: "Please describe the product, service, or company you want me to analyze. What problem does it solve, who is the target audience, and do you know of any existing competitors?"

### 2. Generate Search Keywords

Based on the user's input, generate a list of keywords and search phrases. Combine the problem, audience, and product category to create effective queries.

- **Product Category Keywords:** "customer relationship management", "project management tool", "food delivery service"
- **Problem-based Keywords:** "how to track sales leads", "share files with team", "order food online"
- **Audience-based Keywords:** "CRM for small business", "project management for developers"

### 3. Execute Systematic Search Queries

Use the `google_web_search` tool to perform a series of searches. Vary the queries to uncover competitors from different angles.

1. **Direct and Alternative Searches:**
    - `"[product category] software/tools/services"`
    - `"alternatives to [known competitor]"`
    - `"top [product category] companies"`
    - `"[main keyword] vs"`

2. **Review and Comparison Site Searches:**
    - `site:g2.com [product category]`
    - `site:capterra.com [product category]`
    - `site:trustradius.com [product category]`

3. **Community and Forum Searches:**
    - `site:reddit.com "any good alternatives to [known competitor]"`
    - `site:quora.com "what is the best [product category] tool"`

### 4. Consolidate and Refine the List

- Gather all the company and product names from the search results.
- Create a single list and remove any duplicates.
- For each name, perform a quick "sniff test" by searching for the name plus the product category (e.g., "Asana project management"). This helps verify that it's a relevant competitor and not a different type of business.
- Group competitors into categories if a clear distinction appears:
  - **Direct:** Offer a very similar product to the same audience.
  - **Indirect:** Solve the same core problem but with a different type of solution.

### 5. Present the Findings and Gather Feedback

Deliver the final, curated list to the user. Present it as a simple, bulleted list and explicitly ask for feedback to determine if the results meet the success criteria.

Example response: "Based on my analysis, here is a list of potential competitors in the [product category] space:

**Direct Competitors:**
*   [Competitor A]
*   [Competitor B]

**Indirect Competitors:**
*   [Competitor C]
*   [Competitor D]

How does this list look? Are these the types of competitors you had in mind?"

### 6. Iterate Based on Feedback

Analyze the user's feedback to determine the next steps.

- **If the user confirms the list is relevant (Success Criteria met):** The skill is complete. You can now offer to perform a more detailed analysis on one or more of the identified competitors.
  - *Example prompt:* "Great! I can now perform a more detailed analysis on any of these competitors. Which one would you like to focus on?"

- **If the user finds the list irrelevant or incomplete (Failure Criteria met):**
  - Ask for more specific information. What's missing? Are there keywords or concepts that were overlooked?
  - *Example prompt:* "I understand this isn't quite right. Could you provide more details about your specific niche? Are there any other keywords or example companies that could help me refine the search?"
  - Return to Step 2 (Generate Search Keywords) with the new information to perform another iteration of the search.

## Success Criteria

- A list of 3 or more relevant competitors is presented to the user.
- The user confirms that the list is relevant to their domain.

## Failure Criteria

- The user finds the list irrelevant or incomplete.
- Fewer than 3 relevant competitors can be found after executing the search steps.
