# Search Methodology v1

This document defines the systematic search methodology for literature reviews. It is referenced by the `methodology_version` field in review frontmatter — reviews produced using this methodology set `methodology_version: 1`.

## Search Strategy

### Mandatory Source Categories

Every literature review must consult **all** of the following source categories. No category may be skipped entirely.

| Category | Description | Example Sources |
|----------|-------------|-----------------|
| **Official documentation** | Primary sources from tool/framework/standard authors | Docs sites, specs, RFCs, official blogs |
| **Academic & research papers** | Peer-reviewed or pre-print research | arXiv, Google Scholar, ACM DL, IEEE, conference proceedings |
| **Practitioner blogs & talks** | Experience reports from practitioners | Engineering blogs, conference talks, podcasts, tutorials |
| **Community discussions** | Collective practitioner experience | Reddit, Hacker News, Stack Overflow, GitHub Discussions |
| **Vendor & industry reports** | Market analysis and industry perspectives | Analyst reports, vendor comparisons, surveys |

### Adaptive Depth Allocation

While all source categories are mandatory, **depth allocation is adaptive** based on topic nature:

- **Research-heavy topics** (e.g., embeddings, attention mechanisms): invest more depth in academic papers and pre-prints; community discussions may be thinner
- **Practice-heavy topics** (e.g., monorepo tooling, CI/CD patterns): invest more depth in practitioner blogs and community discussions; academic coverage may be thinner
- **Standard-heavy topics** (e.g., API design, accessibility): invest more depth in official documentation and RFCs; vendor reports may be thinner

The key principle: **every category gets visited, but not every category gets the same depth**. Document the depth allocation rationale in the sources log.

### Search Techniques

Use a combination of search approaches:

1. **Direct queries:** Search for the topic and key terms directly
   - `"{topic}" state of the art`
   - `"{concept}" best practices {current year}`

2. **Comparative queries:** Search for comparisons and alternatives
   - `"{option A}" vs "{option B}"`
   - `"alternatives to {tool/approach}"`

3. **Experience queries:** Search for real-world experiences
   - `site:reddit.com {topic} experiences`
   - `site:news.ycombinator.com {topic}`
   - `"{topic}" lessons learned`

4. **Academic queries:** Search for research papers
   - `site:arxiv.org {topic}`
   - `"{topic}" survey OR review`

5. **Snowball search:** Follow references from found sources
   - Check reference lists of high-quality sources
   - Search for authors who publish frequently on the topic
   - Follow citation trails from seminal papers

## Quality Criteria

### Source Evaluation

Evaluate each source against these criteria before determining its disposition:

| Criterion | Question to Ask |
|-----------|-----------------|
| **Relevance** | Does this source directly address the research topic or a key subtopic? |
| **Recency** | Is this source current enough to be reliable? (threshold varies by topic) |
| **Authority** | Is the author/publisher credible in this domain? |
| **Depth** | Does this source provide substantive analysis, not just surface-level coverage? |
| **Evidence basis** | Are claims supported by data, experience, or references? |

### Disposition Rules

Based on evaluation, assign each source a disposition:

- **Included:** Meets relevance + at least two other criteria. Contributes material to the review.
- **Excluded:** Fails relevance, or is relevant but fails on recency/authority/depth. Document the specific reason.
- **Skimmed:** Partially relevant but not deep enough to warrant full analysis. May be useful for future updates.

## Saturation Heuristic

Research is approaching saturation when **three or more** of these signals are present:

1. **Redundancy:** New searches return sources already found or that repeat the same findings
2. **Concept stability:** No new core concepts are emerging from recent searches
3. **Theme convergence:** Themes identified early are being reinforced, not challenged or expanded
4. **Source cross-referencing:** Found sources cite each other, forming a closed cluster
5. **Diminishing novelty:** The ratio of new insights to sources read is declining

When saturation signals appear:
- Inform the user: describe which signals you're observing
- Confirm whether to continue searching or move to analysis
- Note: saturation in one source category doesn't mean saturation overall — check all categories

## Versioning

This is **version 1** of the search methodology. When this methodology is updated:
- Increment the version number
- Document what changed and why
- Existing reviews retain their original `methodology_version` — they are not retroactively updated
- Reviews can be flagged for re-research under the new methodology if the changes are significant
