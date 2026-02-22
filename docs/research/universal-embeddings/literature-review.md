---
date: 2026-02-22
last_updated: 2026-02-22
produced_by: claude-opus-4-6
freshness: current
methodology_version: 1
---

# Universal Embedding Spaces

## Abstract

Embedding spaces — learned vector representations of data — are converging across modalities. Research from 2021–2025 shows a clear trajectory: from modality-specific embeddings (Word2Vec for text, CNNs for images) toward unified multimodal spaces where text, images, audio, video, depth, and other signals coexist as points in a shared geometry. Landmark models include CLIP (text + images, 2021), ImageBind (6 modalities via image anchoring, 2023), LanguageBind (N modalities via language anchoring, 2024), and ONE-PEACE (vision + audio + language with shared self-attention, 2023). A 2025 generation of fully unified models (VLM2Vec-V2, Omni-Embed) outperforms binding approaches through joint optimization.

However, a fundamental tension persists: the **modality gap** — different modalities occupy separate regions of even "shared" spaces, recently recharacterized as a **contrastive gap** inherent to the training objective rather than to the modalities themselves. The **Platonic Representation Hypothesis** (Huh et al., 2024) offers a counterpoint, arguing that larger models converge toward a shared statistical model of reality regardless of modality.

On the reasoning side, embedding arithmetic (king − man + woman ≈ queen) has been understood since Word2Vec, but scaling this to general reasoning remains an open challenge. **Coconut** (Hao et al., 2024) demonstrates that LLMs can reason in continuous latent space without decoding to tokens — enabling breadth-first search over reasoning paths — though latent reasoning currently matches rather than exceeds explicit chain-of-thought in accuracy.

The vision of a universal "concept space" with a separate "thinking machine" operating on embeddings is directionally aligned with current research but faces significant barriers: the modality gap, compositional reasoning limitations, and the interpretability cost of non-linguistic thought.

## Concepts

### Embedding Space

**Definition:** A learned vector space where data points (words, images, audio clips, etc.) are represented as high-dimensional vectors, such that geometric relationships (distance, direction) encode semantic relationships. [1], [2]
**Current state:** Embedding spaces are foundational to modern ML. Text embeddings (Word2Vec, GloVe, transformer-based) are mature. Image embeddings (CLIP, SigLIP) are production-ready. Multimodal embeddings spanning 3+ modalities are an active research frontier.
**Key sources:** [1], [2], [6]
**Relates to:** Multimodal Alignment, Contrastive Learning, Modality Gap

### Contrastive Learning

**Definition:** A training paradigm where models learn representations by pulling matched pairs (e.g., an image and its caption) close together in embedding space while pushing unmatched pairs apart. The standard objective uses a temperature-scaled cosine similarity loss. [1], [3]
**Current state:** Contrastive learning is the dominant approach for multimodal alignment (CLIP, ImageBind, LanguageBind). Recent work (GRAM, 2025) extends beyond pairwise cosine similarity to n-modality geometric alignment using Gramian volumes. [12]
**Key sources:** [1], [3], [12]
**Relates to:** Embedding Space, Modality Gap, Multimodal Alignment

### Multimodal Alignment

**Definition:** The process of mapping representations from different modalities (text, image, audio, etc.) into a shared embedding space where semantically equivalent concepts from different modalities are nearby. [3], [5]
**Current state:** Three architectural generations exist: (1) dual-encoder contrastive models like CLIP (2021), (2) binding models that anchor to a pivot modality — ImageBind uses images, LanguageBind uses text (2023–2024), and (3) fully unified models with joint optimization across all modalities (2025). Generation 3 outperforms binding: VLM2Vec-V2 achieves 87.2% on image-text retrieval vs. CLIP-ViT-L's 72.3%. [5], [11]
**Key sources:** [1], [3], [4], [5], [11]
**Relates to:** Contrastive Learning, Modality Gap, Binding Architectures

### Modality Gap

**Definition:** The phenomenon where embeddings from different modalities occupy systematically separate regions of a supposedly shared embedding space, even after contrastive training. Discovered to be present in CLIP and similar models. [8]
**Current state:** Initially attributed to separate encoder initializations and contrastive loss dynamics (Liang et al., 2022). Recharacterized in 2024 by Fahim et al. as a **contrastive gap** — the separation is inherent to the two-encoder contrastive loss itself, not specific to modality differences, and is caused by low uniformity in the embedding space. Mitigation strategies include temperature scheduling, feature swapping, embedding standardization, and uniformity regularization. [8], [9]
**Key sources:** [8], [9]
**Relates to:** Contrastive Learning, Multimodal Alignment, Embedding Space

### Binding Architectures

**Definition:** Multimodal models that align multiple modalities by anchoring them to a single pivot modality (typically images or text), leveraging transitive alignment — if (text, image) and (image, audio) are aligned, then (text, audio) is implicitly aligned. [3], [4]
**Current state:** ImageBind (Meta, 2023) binds 6 modalities through image-paired data alone, enabling zero-shot cross-modal retrieval and embedding arithmetic. LanguageBind (ICLR 2024) uses language as the anchor, achieving stronger video-text retrieval (42.7% R@10 vs. ImageBind's 34.2%). ONE-PEACE (Alibaba, 2023) uses shared self-attention with modality-specific FFNs for 3 modalities. Binding approaches are being superseded by fully unified models (2025) that avoid information loss through the anchor bottleneck. [3], [4], [5], [11]
**Key sources:** [3], [4], [5]
**Relates to:** Multimodal Alignment, Modality Gap

### Embedding Arithmetic

**Definition:** The property that meaningful semantic transformations can be expressed as vector addition and subtraction in embedding space. The classic example: king − man + woman ≈ queen. [6], [7]
**Current state:** Well-established for word embeddings since Word2Vec (2013). Extends to multimodal spaces — ImageBind demonstrates cross-modal arithmetic (combining image + audio embeddings produces meaningful results). However, the king-queen analogy is more nuanced than commonly presented: it relies on excluding input words from nearest-neighbor search, and the underlying mechanism is tied to co-occurrence statistics rather than "understanding." More sophisticated operations include: interpolation between embeddings, box/region-based logical queries (Query2Box), and manifold-based relational reasoning. [6], [7], [13]
**Key sources:** [6], [7], [13]
**Relates to:** Embedding Space, Latent Space Reasoning

### Latent Space Reasoning

**Definition:** Performing inference, planning, or multi-step reasoning directly in a model's continuous hidden state / embedding space, without decoding intermediate steps to discrete tokens. [10], [14], [15]
**Current state:** Coconut (Hao et al., 2024, COLM 2025) is the landmark work: it replaces chain-of-thought tokens with continuous "thoughts" — feeding the LLM's last hidden state back as the next input embedding. This enables breadth-first search over reasoning paths (vs. CoT's single-path commitment) and outperforms CoT on logical reasoning tasks requiring planning. Chain-of-Embedding (CoE, ICLR 2025) uses hidden states for output-free self-evaluation. A comprehensive survey (2025) identifies four approaches: discrete tokens, continuous tokens, structural CoT (depth/recurrence), and representational CoT (distilled into hidden states). Current limitation: latent reasoning matches but doesn't consistently exceed explicit CoT accuracy, and generalization to novel problem structures is weak. [10], [14], [15]
**Key sources:** [10], [14], [15]
**Relates to:** Embedding Arithmetic, Platonic Representation Hypothesis

### Platonic Representation Hypothesis

**Definition:** The hypothesis (Huh et al., 2024) that neural network representations are converging toward a shared statistical model of reality — a "platonic representation" — regardless of architecture, training data, or modality. Inspired by Plato's theory of ideal forms. [16]
**Current state:** Presented as a position paper at ICML 2024. Evidence: as vision and language models scale, they measure distances between datapoints in increasingly similar ways. Larger models show greater cross-model alignment. The proposed mechanism: task and data pressures, combined with increasing capacity, leave fewer viable representations, driving convergence. The implication is that universal embeddings are not just an engineering goal but may reflect an underlying structure. Critics (e.g., Alexei Efros) argue this overlooks meaningful modality-specific information that resists translation. Covered by Quanta Magazine (Jan 2026) as a significant result. [16], [17]
**Key sources:** [16], [17]
**Relates to:** Multimodal Alignment, Embedding Space, Latent Space Reasoning

### Promptable Embeddings

**Definition:** A recent paradigm (2025) where embeddings vary based on both input content and task instructions, rather than being static vectors. The same image can produce different embeddings depending on the query context. [11]
**Current state:** Emerged in Generation 3 unified models (VLM2Vec-V2, Omni-Embed-Nemotron). Represents a shift from "one embedding per input" to "one embedding per (input, task) pair." Enabled by instruction-tuned vision-language models. Significant practical impact: training on visual documents (PDFs, slides) improved general image understanding from 76.3% to 85.7%. [11]
**Key sources:** [11]
**Relates to:** Multimodal Alignment, Embedding Space

## Themes

### Theme 1: The Pivot Modality Pattern and Its Limits

A recurring architectural pattern in multimodal embedding research is the use of a **pivot modality** to achieve transitive alignment. ImageBind uses images, LanguageBind uses language, and both exploit the insight that paired data with the pivot is sufficient to implicitly align all other modalities with each other.

This pattern is elegant and data-efficient — it avoids the combinatorial explosion of needing paired data for every modality pair. However, binding approaches force information through the anchor modality, potentially losing modality-specific features. LanguageBind's choice of language as anchor (rather than images) proved empirically stronger for video-text retrieval, suggesting the choice of pivot matters and language may carry richer semantic structure.

The 2025 generation of fully unified models (VLM2Vec-V2, Omni-Embed) moves beyond the pivot pattern entirely, optimizing all modalities jointly. Empirical results show substantial gains (87.2% vs 72.3% on image-text retrieval), suggesting the pivot bottleneck was a real limitation. The pivot era (2023–2024) may be transitional — necessary when paired data was scarce, but superseded as training infrastructure catches up.

### Theme 2: The Gap That Won't Close

The modality gap is perhaps the most persistent challenge to the vision of truly universal embeddings. Even in models explicitly trained to align modalities, embeddings from different types cluster separately. Fahim et al. (2024) reframed this as the **contrastive gap** — intrinsic to two-encoder contrastive loss rather than to the modalities themselves. This is a significant reframing: it suggests the problem is in the training objective, not in the data.

Mitigation strategies exist (uniformity regularization, GRAM's geometric alignment, hyperbolic space exploration), but none fully eliminate the gap. The most provocative perspective comes from "Accept the Modality Gap" (CVPR 2024), which argues the gap may be structurally useful — modalities may genuinely need separate representational regions to preserve modality-specific information.

This tension is critical for the "universal concept space" vision: if the gap is fundamental, then a single shared space may always be a compromise between cross-modal alignment and within-modality expressiveness.

### Theme 3: From Arithmetic to Reasoning

Embedding operations have evolved along a spectrum of increasing complexity:

1. **Linear arithmetic** (Word2Vec, 2013): king − man + woman ≈ queen. Simple but brittle — works for specific relational patterns, not general reasoning.
2. **Cross-modal arithmetic** (ImageBind, 2023): composing embeddings from different modalities by addition. Enables novel applications but remains compositional, not inferential.
3. **Region-based logic** (Query2Box, 2020): representing logical queries as geometric regions (boxes) in embedding space, supporting conjunction, disjunction, and existential quantification.
4. **Continuous reasoning** (Coconut, 2024): feeding hidden states back as inputs, enabling multi-step inference without token decoding. The closest realization to a "thinking machine operating on embeddings."

The progression suggests that embeddings can support increasingly sophisticated operations, but each step introduces trade-offs. Coconut's continuous reasoning is more efficient and enables parallel exploration of reasoning paths, but it currently matches — not exceeds — explicit chain-of-thought accuracy, and its internal process is opaque.

### Theme 4: Convergence Toward a Universal Representation

The Platonic Representation Hypothesis offers the strongest theoretical argument for universal embeddings: if all models are converging toward the same statistical model of reality, then a universal embedding space isn't just possible — it's inevitable as models scale. The evidence is suggestive: cross-model alignment increases with scale, and vision-language alignment improves even without explicit multimodal training.

However, convergence of statistical structure doesn't necessarily mean convergence of all useful information. Efros's critique — "there is a reason why you go to an art museum instead of just reading the catalog" — points to modality-specific richness that may resist compression into a single vector space. The hypothesis may be true at the level of semantic structure while failing at the level of perceptual detail.

The practical implication is that embeddings from sufficiently large models trained on sufficiently diverse data may be approximately translatable — the vec2vec research demonstrates that embedding spaces can be mapped between models without paired data. This doesn't require identical spaces, just structurally isomorphic ones.

### Theme 5: The Text-Embedding-Reasoning-Embedding-Text Pipeline

The user's proposed pipeline — text → embeddings → reasoning machine → embeddings → text — maps directly onto current research directions, with each component at a different maturity level:

- **Text → Embeddings**: Mature. LLM encoders, CLIP, and dedicated embedding models handle this well.
- **Embeddings → Reasoning**: Nascent. Coconut demonstrates feasibility for logical planning tasks. Latent CoT approaches show promise but don't yet match explicit reasoning in accuracy or generalization.
- **Reasoning → Embeddings → Text**: The weakest link. Decoding from latent reasoning states back to text is where interpretability breaks down. Coconut produces final answers but the intermediate "continuous thoughts" are not human-readable.

A key insight from the HN discussion on natively multimodal LLMs: embeddings optimized for next-token prediction (LLM hidden states) differ fundamentally from embeddings optimized for semantic similarity (CLIP-style). A "thinking machine" would need embeddings suited for reasoning operations, which may be a third distinct type not well-served by either paradigm.

## Synthesis

Five themes emerge from this research landscape, and they point to a central tension: **the theoretical case for universal embeddings is strong, but the engineering reality is fragmented.**

The Platonic Representation Hypothesis and the empirical trajectory from CLIP → ImageBind → unified models suggest genuine convergence. Models trained on different data, with different objectives, in different modalities, are discovering similar geometric structures. This supports the intuition that embeddings capture "concepts" in some meaningful sense.

But the modality/contrastive gap, the limitations of current reasoning in embedding space, and the distinction between different embedding "purposes" (retrieval vs. generation vs. reasoning) suggest we're not yet at a single universal space. Instead, we're in an era of **approximate universality** — embeddings are translatable between spaces (vec2vec), combinable across modalities (ImageBind arithmetic), and usable for basic reasoning (Coconut), but each operation introduces loss and limitation.

The "thinking machine" vision is the most speculative piece. Current latent reasoning (Coconut, structural CoT) demonstrates that models *can* reason without decoding to tokens, but the reasoning is tightly coupled to the specific model's latent space — it's not a general-purpose "embedding computer." The gap between embedding arithmetic (linear, compositional) and general reasoning (non-linear, abductive, creative) remains wide.

The most promising near-term direction is not a separate "thinking machine" but rather **deeper integration of reasoning into the embedding space itself** — models that natively think in latent space and decode only when communicating results. Coconut and structural CoT point this way. The longer-term question is whether these internal representations can be made modality-agnostic and model-agnostic, which the Platonic Representation Hypothesis suggests may happen naturally with scale.

## Gaps & Open Questions

1. **No true N-modality universal space exists yet.** Current models handle 3–6 modalities. No model has been demonstrated on the full range of human sensory and cognitive modalities (text, vision, audio, touch, smell, proprioception, abstract reasoning). It's unclear whether a single space can scale to arbitrary modalities without degradation.

2. **The modality gap's fundamental nature is unresolved.** Is it an artifact of current training objectives (fixable with better losses) or a structural feature of cross-modal representation (fundamental)? The contrastive gap reframing and GRAM's geometric approach suggest it may be addressable, but no current method fully eliminates it.

3. **Latent reasoning doesn't generalize well.** Coconut and related approaches work on structured logical tasks but haven't been demonstrated on open-ended, creative, or abductive reasoning. Whether continuous latent space can support the full range of human-like reasoning is an open question.

4. **Interpretability of latent reasoning is near-zero.** If reasoning happens in embedding space, we lose the ability to inspect intermediate steps. Chain-of-Embedding offers some signal (correct vs. incorrect patterns), but "understanding" what a continuous thought represents is unsolved.

5. **The relationship between embedding purpose and embedding structure is underexplored.** Retrieval embeddings, generation embeddings, and reasoning embeddings may require fundamentally different geometric properties. Whether these can coexist in a single space is unclear.

6. **Scale requirements are unknown.** The Platonic Representation Hypothesis predicts convergence with scale, but the required scale for practical universality — and whether it's achievable with current hardware — is unquantified.

7. **Evaluation frameworks for universal embeddings are immature.** MMEB-V2 and similar benchmarks test retrieval, not reasoning or creative composition. There's no standard way to evaluate whether an embedding space is "truly universal."

## Implications

1. **Experiment:** Test whether current multimodal embedding models (ImageBind, VLM2Vec-V2) can support basic cross-modal reasoning tasks — e.g., can you perform analogy operations across modalities (text:image :: audio:?) and get meaningful results?

2. **Experiment:** Evaluate Coconut-style latent reasoning on practical tasks relevant to this project — e.g., can a model reason about code architecture in embedding space more efficiently than via explicit chain-of-thought?

3. **BET:** "By 2027, at least one production system will use latent-space reasoning (no token decoding) as its primary inference mode for planning tasks." The Coconut results and structural CoT trajectory suggest this is likely for narrow domains.

4. **BET:** "By 2028, embedding spaces from different foundation models will be routinely translatable without paired data." The vec2vec and Platonic Representation research suggest this is directionally correct.

5. **ADR candidate:** If adopting embedding-based retrieval or RAG in this project, decide between binding-era models (CLIP, ImageBind — simpler, well-understood) vs. Generation 3 unified models (VLM2Vec-V2 — better performance, more complex, less battle-tested).

6. **Future research:** The "thinking machine" concept deserves a follow-up investigation specifically into Coconut, structural CoT (Huginn, RELAY), and whether their latent reasoning capabilities can be combined with multimodal embeddings.

## References

- [1] Radford, A. et al. "Learning Transferable Visual Models From Natural Language Supervision" (CLIP). OpenAI, 2021. https://arxiv.org/abs/2103.00020
- [2] Mikolov, T. et al. "Efficient Estimation of Word Representations in Vector Space" (Word2Vec). 2013. https://arxiv.org/abs/1301.3781
- [3] Girdhar, R. et al. "ImageBind: One Embedding Space To Bind Them All." CVPR 2023. https://arxiv.org/abs/2305.05665
- [4] Zhu, B. et al. "LanguageBind: Extending Video-Language Pretraining to N-modality by Language-based Semantic Alignment." ICLR 2024. https://arxiv.org/abs/2310.01852
- [5] Wang, P. et al. "ONE-PEACE: Exploring One General Representation Model Toward Unlimited Modalities." 2023. https://arxiv.org/abs/2305.11172
- [6] Ethayarajh, K. "Word Embedding Analogies: Understanding King - Man + Woman = Queen." 2019. https://kawine.github.io/blog/nlp/2019/06/21/word-analogies.html
- [7] Allen, C. and Hospedales, T. "Analogies Explained: Towards Understanding Word Embeddings." ACL 2019. https://arxiv.org/abs/1901.09813
- [8] Liang, W. et al. "Mind the Gap: Understanding the Modality Gap in Multi-modal Contrastive Representation Learning." NeurIPS 2022. https://arxiv.org/abs/2203.02053
- [9] Fahim, A. et al. "It's Not a Modality Gap: Characterizing and Addressing the Contrastive Gap." 2024. https://arxiv.org/abs/2405.18570
- [10] Hao, S. et al. "Training Large Language Models to Reason in a Continuous Latent Space" (Coconut). COLM 2025. https://arxiv.org/abs/2412.06769
- [11] TheDataGuy. "Understanding Multimodal Embeddings: The Evolution from CLIP to Unified Foundation Models." 2025. https://thedataguy.pro/blog/2025/12/multimodal-embeddings-evolution/
- [12] Oñoro-Rubio, D. et al. "Gramian Multimodal Representation Learning and Alignment." ICLR 2025. https://arxiv.org/abs/2412.11959
- [13] Ren, H. et al. "Query2Box: Reasoning over Knowledge Graphs in Vector Space Using Box Embeddings." ICLR 2020.
- [14] Wang, Y. et al. "Latent Space Chain-of-Embedding Enables Output-free LLM Self-Evaluation." ICLR 2025. https://arxiv.org/abs/2410.13640
- [15] "Reasoning Beyond Language: A Comprehensive Survey on Latent Chain-of-Thought Reasoning." 2025. https://arxiv.org/abs/2505.16782
- [16] Huh, M. et al. "The Platonic Representation Hypothesis." ICML 2024. https://arxiv.org/abs/2405.07987
- [17] Quanta Magazine. "Distinct AI Models Seem To Converge On How They Encode Reality." Jan 2026. https://www.quantamagazine.org/distinct-ai-models-seem-to-converge-on-how-they-encode-reality-20260107/
- [18] Hacker News. "Harnessing the Universal Geometry of Embeddings." Discussion thread, 2025. https://news.ycombinator.com/item?id=44054425
- [19] Hacker News. Discussion on natively multimodal LLMs and embeddings. 2024. https://news.ycombinator.com/item?id=42163723
- [20] EdenAI. "Best Multimodal Embeddings APIs in 2025." https://www.edenai.co/post/best-multimodal-embeddings-apis
- [21] AIMUltiple. "Multimodal Embedding Models: Apple vs Meta vs OpenAI." https://research.aimultiple.com/multimodal-embeddings/
