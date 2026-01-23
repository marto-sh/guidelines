# Reference: Subdomains

A Subdomain is a part of the overall business domain. Classifying your subdomains is a key strategic exercise that helps you decide where to focus your resources and development effort.

## The Three Types of Subdomains

### 1. Core Domain
- **What it is:** This is the heart of your business. It's the area that contains the most complex and unique business logic, and it's where you have a competitive advantage.
- **How to Treat It:**
  - Assign your best developers.
  - Apply DDD principles rigorously.
  - Invest heavily in building custom, high-quality software.
  - The model should be rich, deep, and constantly evolving with the business.
- **Example:** For an e-commerce company, the "pricing engine" or "recommendation algorithm" might be the Core Domain.

### 2. Supporting Subdomain
- **What it is:** A subdomain that is necessary for the business to operate, but it's not a key differentiator. It doesn't contain the "secret sauce" of the business, but it might still have some complex logic.
- **How to Treat It:**
  - The goal is to support the Core Domain, not to be perfect.
  - Can be built in-house or outsourced to another team.
  - A simpler, less complex model is often sufficient. Don't over-engineer it.
- **Example:** For an e-commerce company, a "catalog management" or "content management" system might be a Supporting Subdomain.

### 3. Generic Subdomain
- **What it is:** A "solved problem." This is a part of the business domain for which numerous good solutions already exist.
- **How to Treat It:**
  - **Always prefer to buy an off-the-shelf solution.** Do not build it yourself.
  - The cost and effort of building a custom solution for a generic problem is a waste of resources that could be spent on the Core Domain.
  - Integrate with the purchased solution via an Anti-Corruption Layer.
- **Example:** Authentication, email notifications, payment processing, content delivery networks.

## Relationship to Bounded Contexts

There is often, but not always, a one-to-one mapping between a Bounded Context and a Subdomain. You might have a single Bounded Context that implements your entire Core Subdomain. Or, a very large Core Subdomain might be split into several Bounded Contexts.

The process is typically:
1.  Explore the business domain (the problem space) and identify the **Subdomains**.
2.  Design your software architecture (the solution space) and define the **Bounded Contexts** that will implement the logic for those subdomains.
