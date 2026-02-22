---
date: 2026-02-22
last_updated: 2026-02-22
produced_by: claude-opus-4-6
freshness: current
methodology_version: 1
---

# Universal Embedding Spaces

## Abstract

Embedding spaces — learned vector representations of data — are converging across modalities. Research from 2013–2025 traces a clear arc: from modality-specific embeddings (Word2Vec for text, CNNs for images) toward unified multimodal spaces where text, images, audio, video, depth, thermal, and other signals coexist as points in a shared geometry. Three architectural generations have emerged: dual-encoder contrastive models (CLIP, 2021), binding models that anchor to a pivot modality (ImageBind via images, LanguageBind via text, 2023–2024), and fully unified models with joint optimization (VLM2Vec-V2, Omni-Embed-Nemotron, 2025). Each generation outperforms the last, with unified models achieving 87.2% on image-text retrieval versus CLIP's 72.3%.

However, a fundamental tension persists: the **modality gap** — different modalities occupy separate regions of even "shared" spaces. Initially attributed to the nature of modalities themselves, this was recharacterized in 2024 as a **contrastive gap** inherent to the training objective. Work in hyperbolic geometry (Ramasinghe et al., CVPR 2024) goes further, arguing the gap may be structurally useful and proposing angle-based alignment that respects modality differences rather than forcing spatial proximity.

The **Platonic Representation Hypothesis** (Huh et al., ICML 2024) offers the strongest theoretical argument for universality: neural networks trained on different data, with different architectures, in different modalities, are converging toward a shared statistical model of reality. The vec2vec framework (Jha et al., 2025) demonstrates this practically — embeddings can be translated between model spaces without paired data, achieving up to 0.92 cosine similarity and 100% top-1 accuracy.

On the reasoning side, embedding arithmetic (king − man + woman ≈ queen) has been understood since Word2Vec, but scaling to general reasoning remains an open challenge. Operations on embeddings have evolved from linear arithmetic through region-based logic (Query2Box, box embeddings for logical queries) to continuous latent reasoning. **Coconut** (Hao et al., 2024) demonstrates that LLMs can reason in continuous latent space without decoding to tokens, enabling breadth-first search over reasoning paths. **Huginn** (2025) implements a depth-recurrent architecture that "thinks" through repeated latent iterations. A parallel approach — discrete tokenization of all modalities (AnyGPT, 2024) — offers an alternative path where any-to-any multimodal processing happens through discrete token sequences rather than continuous embeddings.

The vision of a universal "concept space" with a separate "thinking machine" operating on embeddings is directionally aligned with current research but faces significant barriers: the modality gap, the distinction between different embedding purposes (retrieval vs. generation vs. reasoning), compositional reasoning limitations, and the interpretability cost of non-linguistic thought.

## Concepts

### Embedding Space

**Definition:** A learned vector space where data points (words, images, audio clips, etc.) are represented as high-dimensional vectors, such that geometric relationships (distance, direction) encode semantic relationships. The fundamental insight is that semantically similar items end up near each other, and meaningful directions in the space correspond to semantic properties. [1], [2]
**Current state:** Embedding spaces are foundational to modern ML. Text embeddings have evolved through multiple generations: from sparse count-based representations (TF-IDF) through static dense vectors (Word2Vec, GloVe) to contextual embeddings (BERT, GPT) where the same word gets different vectors depending on context. Image embeddings followed a parallel trajectory from handcrafted features (SIFT, HOG) through CNN-based representations to vision transformers. The current frontier is multimodal embeddings spanning 3+ modalities. A key geometric property: high-dimensional embedding spaces exhibit the "manifold hypothesis" — real data occupies lower-dimensional manifolds within the high-dimensional space, meaning the effective dimensionality of semantic information is much lower than the vector dimension. Modern embedding models typically produce vectors of 768–4096 dimensions, though PCA analysis shows much of the variance can be captured in 32–128 dimensions. [1], [2], [6], [24]
**Key sources:** [1], [2], [6], [24]
**Relates to:** Multimodal Alignment, Contrastive Learning, Modality Gap, Geometric Properties of Embeddings

### Contrastive Learning

**Definition:** A training paradigm where models learn representations by pulling matched pairs (e.g., an image and its caption) close together in embedding space while pushing unmatched pairs apart. The standard objective uses a temperature-scaled cosine similarity loss (InfoNCE or its variants). [1], [3]
**Current state:** Contrastive learning is the dominant approach for multimodal alignment. Two main loss formulations compete: CLIP uses **softmax-based** contrastive loss (treating alignment as multi-class classification within a batch), while SigLIP (Google, 2023) uses **sigmoid-based** loss (treating each pair as independent binary classification). The sigmoid approach is more memory-efficient — fitting batch size 4096 where softmax fits only 2048 on the same hardware — and performs better at small batch sizes, though both saturate around 32K batch size. [1], [3], [22]

The **temperature parameter** is a critical hyperparameter that controls the sharpness of the similarity distribution. Small temperatures increase uniformity (spreading embeddings evenly across the space) but reduce tolerance for semantically similar items; large temperatures preserve local semantic structure but reduce global uniformity. This creates a fundamental **uniformity-tolerance dilemma** that adaptive temperature strategies attempt to resolve. [26]

Recent work extends beyond pairwise alignment. **GRAM** (Oñoro-Rubio et al., ICLR 2025) introduces Gramian volume minimization for n-modality geometric alignment — instead of aligning modalities in pairs, it minimizes the volume of the parallelotope spanned by all modality vectors simultaneously, ensuring geometric alignment of all modalities at once. [12]
**Key sources:** [1], [3], [12], [22], [26]
**Relates to:** Embedding Space, Modality Gap, Multimodal Alignment, Temperature Parameter

### Multimodal Alignment

**Definition:** The process of mapping representations from different modalities (text, image, audio, etc.) into a shared embedding space where semantically equivalent concepts from different modalities are nearby. [3], [5]
**Current state:** Three architectural generations have emerged, each with distinct trade-offs:

**Generation 1 — Dual-encoder contrastive models (2021–2022):** CLIP (OpenAI) pioneered the approach with separate text and image encoders trained on 400M image-text pairs using contrastive loss. Limitations include coarse-grained understanding (good at object recognition, poor at compositional reasoning), static embeddings (one vector per input regardless of task), the 77-token text length limit, and the persistent modality gap. SigLIP (Google, 2023) improved efficiency and small-batch performance through sigmoid loss, and **SigLIP 2** (2025) added decoder objectives (captioning, grounding, dense captioning), self-distillation, and dynamic resolution support (NaFlex), producing embeddings that are simultaneously dense, spatially-aware, and semantically rich. [1], [22], [23]

**Generation 2 — Binding models (2023–2024):** ImageBind (Meta, CVPR 2023) binds 6 modalities (images, text, audio, depth, thermal, IMU) through image-paired data alone. LanguageBind (ICLR 2024) uses language as the pivot, achieving stronger video-text retrieval (42.7% R@10 vs. ImageBind's 34.2%). ONE-PEACE (Alibaba, 2023) uses shared self-attention layers with modality-specific FFNs for 3 modalities. The binding insight is elegant — paired data with the pivot is sufficient to align all other modalities transitively — but forces information through the anchor, losing modality-specific features. [3], [4], [5]

**Generation 3 — Fully unified models (2025):** VLM2Vec-V2 uses instruction-tuned VLMs to produce task-aware embeddings. Omni-Embed-Nemotron (NVIDIA, 4.7B params) handles text, image, audio, and video with decoupled sensory streams — keeping audio and video processing separate rather than interleaved, which preserves temporal structure and improves retrieval (0.5662 vs 0.4700 NDCG@10 on FineVideo for late vs. early fusion). UniME achieves 4.1% improvement over E5-V baseline through knowledge distillation and hard-negative mining. These models significantly outperform binding approaches: VLM2Vec-V2 reaches 87.2% on image-text retrieval vs. CLIP-ViT-L's 72.3%. [11], [25], [27]
**Key sources:** [1], [3], [4], [5], [11], [22], [23], [25], [27]
**Relates to:** Contrastive Learning, Modality Gap, Binding Architectures, Promptable Embeddings

### Modality Gap

**Definition:** The phenomenon where embeddings from different modalities occupy systematically separate regions of a supposedly shared embedding space, even after contrastive training. Technically, the representations form distinct clusters on the unit hypersphere, with cross-modal cosine similarities substantially lower than intra-modal similarities. [8]
**Current state:** The understanding of this phenomenon has evolved through three phases:

**Phase 1 — Discovery (2022):** Liang et al. (NeurIPS 2022) demonstrated that CLIP embeddings of images and text occupy separate regions, attributing this to two causes: (a) the **cone effect** — deep neural network representations are restricted to narrow cones, so two separate encoders produce representations in different cones from initialization, and (b) contrastive loss dynamics that maintain rather than close this initial separation. [8]

**Phase 2 — Reframing (2024):** Fahim et al. recharacterized the modality gap as a **contrastive gap** — even when using the same modality in both encoders, the contrastive loss creates separation. The root cause is low uniformity: embeddings occupy only a small portion of the available space. Adding uniformity and alignment regularization to the CLIP loss distributes embeddings more evenly and improves downstream zero-shot classification. [9]

**Phase 3 — Acceptance and alternative geometries (2024):** Ramasinghe et al. (CVPR 2024) argue the gap may be structurally necessary. Text conveys abstract concepts through structured syntax, while images express complex scenes through visual cues — these are "intrinsically different in representational nature." They prove that forcing spatial proximity in hyperbolic space creates contradictory optimization objectives: Proposition 1 shows satisfying contrastive alignment and entailment constraints simultaneously is impossible; Proposition 2 shows joint optimization causes "exponential contraction" destroying hierarchical structure. Their alternative — **angle-based contrastive loss** — aligns concepts by angular direction rather than spatial proximity, preserving modality-specific hierarchy while enabling cross-modal retrieval. [10a]

The practical impact of the gap is significant: queries preferentially retrieve same-modality items due to higher intra-modal similarities, suppressing relevant cross-modal results. [8], [9]
**Key sources:** [8], [9], [10a]
**Relates to:** Contrastive Learning, Multimodal Alignment, Geometric Properties of Embeddings

### Binding Architectures

**Definition:** Multimodal models that align multiple modalities by anchoring them to a single pivot modality (typically images or text), leveraging transitive alignment — if (text, image) and (image, audio) are aligned, then (text, audio) is implicitly aligned without direct (text, audio) training pairs. [3], [4]
**Current state:** Three major binding models define the state of the art:

**ImageBind** (Meta, CVPR 2023, Highlighted Paper): Binds 6 modalities — images, text, audio, depth, thermal, IMU — using only image-paired data. The key architectural choice: freeze a pre-trained image-text model (from CLIP) and train additional modality-specific encoders to align with the frozen image encoder. This produces emergent capabilities never explicitly trained: audio-to-text retrieval, depth-to-text classification, and cross-modal arithmetic. Performance scales with the strength of the underlying image encoder. Analysis of ImageBind's embedding structure (Bian et al., 2024) shows that meaningful fused embeddings can be created through simple averaging of modality-specific embeddings, and pure audio embeddings can correlate with semantically similar visual items — confirming genuine cross-modal alignment. [3], [24a]

**LanguageBind** (ICLR 2024): Uses language as the pivot instead of images, arguing language "is well-explored and contains rich semantics." Freezes the language encoder from video-language pretraining and trains modality encoders for video, infrared, depth, and audio via contrastive learning. Trained on VIDAL-10M (10M samples across 5 modalities from short video platforms). Achieves superior performance on 15 benchmarks, with notably stronger video-text retrieval than ImageBind (42.7% vs 34.2% R@10). [4]

**ONE-PEACE** (Alibaba, 2023): A 4B-parameter model with a different architecture — shared self-attention layers across modalities with modality-specific FFNs and adapters. Uses two pretraining tasks: cross-modal aligning contrast and intra-modal denoising contrast. Unlike ImageBind and LanguageBind, it was trained from scratch without initializing from any vision or language pretrained model. Achieves strong results across vision (ImageNet), audio (ESC-50, VGGSound), and cross-modal (AudioCaps, MSCOCO) benchmarks. [5]

Binding approaches are being superseded by Generation 3 unified models that avoid the pivot bottleneck but remain widely used due to their data efficiency and simplicity. [3], [4], [5], [11]
**Key sources:** [3], [4], [5], [24a]
**Relates to:** Multimodal Alignment, Modality Gap, Emergent Cross-Modal Capabilities

### Embedding Arithmetic

**Definition:** The property that meaningful semantic transformations can be expressed as vector addition and subtraction in embedding space. Relationships between concepts become directions, and applying a direction to a new starting point produces a semantically appropriate result. [6], [7]
**Current state:** Embedding arithmetic exists at multiple levels of sophistication:

**Word-level arithmetic (2013–present):** The classic king − man + woman ≈ queen example from Word2Vec. However, this is more nuanced than commonly presented. Ethayarajh (2019) showed the analogy only works when excluding the input words from nearest-neighbor search — without this exclusion, king − man + woman = king (the nearest neighbor is the original word). Allen & Hospedales (ACL 2019) provided a formal explanation tying the arithmetic to co-occurrence statistics: the observed phenomenon is "underpinned by a known relationship between the values in a word embedding and statistics of how often the word corresponding to that embedding co-occurs with all other words." The arithmetic captures statistical regularities in language use, not conceptual understanding. [6], [7]

**Cross-modal arithmetic (2023–present):** ImageBind demonstrated that modality vectors can be composed: adding an image embedding and an audio embedding produces a result that captures the combined semantics. For example, image(beach) + audio(birds) retrieves images of beaches with birds. This works because the shared embedding space preserves semantic linearity across modalities. [3]

**Region-based operations (2020–present):** Query2Box (Ren et al., ICLR 2020) represents queries as axis-aligned hyper-rectangles (boxes) in embedding space. Sets of answer entities correspond to points inside a box. Logical operations map to geometric operations: conjunction → box intersection, existential quantification → projection. This achieves up to 25% relative improvement over point-based methods for knowledge graph reasoning. The authors prove a negative result: handling disjunctions requires embedding dimension proportional to the number of entities — a fundamental limitation of spatial representations for certain logical operations. Disjunctions are handled indirectly via Disjunctive Normal Form. [13]

**Manifold-based operations (2015–present):** Related word groups can be modeled as low-dimensional subspaces on Grassmannian manifolds, using geodesic flow to measure relation-specific similarities (achieving ~10% accuracy improvements). Conceptual subspaces assign semantic types to affine subspaces; properties become convex regions and features become directional components. [28]
**Key sources:** [6], [7], [3], [13], [28]
**Relates to:** Embedding Space, Latent Space Reasoning, Geometric Properties of Embeddings

### Latent Space Reasoning

**Definition:** Performing inference, planning, or multi-step reasoning directly in a model's continuous hidden state / embedding space, without decoding intermediate steps to discrete tokens. The reasoning "happens" as geometric transformations in the latent space rather than as word-by-word generation. [14], [15], [16]
**Current state:** This is among the most active frontiers in AI research. A comprehensive survey (2025) identifies four main approaches: [16]

**1. Discrete token strategies:** Learnable symbolic markers — pause tokens, planning tokens, thinking tokens — segment reasoning steps. The model generates special tokens that trigger internal computation without producing interpretable output. Simple but limited in expressiveness.

**2. Continuous token strategies (Coconut):** The landmark Coconut framework (Hao et al., 2024, accepted COLM 2025) replaces chain-of-thought tokens with continuous embeddings. Instead of decoding the LLM's last hidden state into words, it feeds the state directly back as the next input embedding — creating a loop of continuous "thoughts." Key properties: (a) continuous thoughts can "encode multiple alternative next steps," enabling **breadth-first search** over reasoning paths rather than CoT's single-path commitment; (b) the approach outperforms CoT on logical reasoning tasks requiring substantial search during planning; (c) it achieves "a better trade-off between accuracy and efficiency" because no model capacity is wasted on maintaining textual coherence. [14]

**3. Structural CoT (depth-recurrence):** Huginn (2025) is a 3.5B-parameter depth-recurrent Transformer that reuses a small "bank" of blocks (2 Prelude, 4 Recurrent, 2 Coda) with variable iteration counts at inference. It "thinks" through repeated latent iterations, with harder problems receiving more recurrences. Analysis through logit lens and coda lens reveals limited evidence of structured chain-of-thought-like patterns in the latent space — the model may use iterative refinement rather than step-by-step reasoning. A related approach, "Scaling by Thinking in Continuous Space" (2025), trains a similar recurrent architecture on 800B tokens and observes emergent latent dynamics: orbital patterns, fixed-point convergence, and directional drifts arise naturally during training without explicit optimization for these behaviors. On GSM8K, the model achieves 38.13% at 32 recurrences. [29], [30]

**4. Representational CoT:** Reasoning is distilled directly into hidden states without any explicit intermediate output. The model is trained so that its hidden representations at each layer encode reasoning steps, but these are never decoded. Chain-of-Embedding (CoE, Wang et al., ICLR 2025) uses "all progressive hidden states produced during inference time" as a latent cognitive process, enabling output-free self-evaluation with "no training and millisecond-level computational cost." [15]

**5. Recursive latent reasoning:** A separate line explores recursive processing with discrete anchoring — after each iteration, continuous hidden states project into a structured discrete symbolic space and re-embed, maintaining semantic stability. This achieves "perfect generalization on inputs that are several times larger" than training examples (training on ≤32-node graphs, testing on 128-node). [31]

**Critical limitations:** The survey notes that latent reasoning approaches "still underperform explicit reasoning approaches in accuracy" in general. They show poor generalization to novel problem structures, and interpretability is near-zero — models may use "shortcuts" rather than genuine reasoning. The LessWrong AI safety community has flagged this as an alignment concern: "Faithful and legible CoT is perhaps the most powerful tool currently available to alignment researchers," and moving reasoning into opaque latent spaces undermines this tool. [16], [32]
**Key sources:** [14], [15], [16], [29], [30], [31], [32]
**Relates to:** Embedding Arithmetic, Platonic Representation Hypothesis, Geometric Properties of Embeddings

### Platonic Representation Hypothesis

**Definition:** The hypothesis (Huh et al., ICML 2024) that neural network representations are converging toward a shared statistical model of reality — a "platonic representation" — regardless of architecture, training data, or modality. Named after Plato's theory of ideal forms: the models are discovering the same underlying structure, like shadows of the same world. [17]
**Current state:** The evidence spans multiple levels:

**Cross-model convergence:** Different neural networks trained independently represent data in increasingly aligned ways over time. Larger models show greater alignment with each other. The researchers measure this via "the similarity of similarities" — comparing how different models rank the relatedness of concept pairs.

**Cross-modal convergence:** Vision models and language models trained on Wikipedia image-caption pairs show "a steady increase in representational similarity as models became more powerful." This holds even without explicit multimodal training objectives.

**Proposed mechanism:** Task and data pressures, combined with increasing model capacity, leave fewer viable representations. As models become more general-purpose, they converge. Senior author Phillip Isola: "Why do the language model and the vision model align? Because they're both shadows of the same world." [17], [18]

**Practical validation — vec2vec:** Jha et al. (2025) provide the strongest practical evidence. Their vec2vec framework translates embeddings between model spaces without any paired data, encoders, or predefined matches, using adversarial losses and cycle consistency to learn mappings through a universal latent space. Results: up to 0.92 cosine similarity across model pairs with different architectures, parameter counts, and training datasets; 100% top-1 accuracy on matched pairs; and strong out-of-distribution performance (tweets, medical records). A follow-up, mini-vec2vec (2025), achieves competitive performance with just a linear transformation, suggesting the mapping between spaces may be simpler than expected. The practical application is immediate: Vector Rosetta (2026) used a 50M-parameter adapter to translate 200M+ CLIP embeddings to SigLIP space at 41x the speed of re-embedding, achieving 90.9% cosine similarity preservation and 94.3% Rank@1 accuracy on 10K pools. [19], [20], [33]

**Criticism:** Alexei Efros contends that focusing on convergence overlooks meaningful differences: "There is a reason why you go to an art museum instead of just reading the catalog." Real-world data often resists translation between modalities. Jeff Clune cautions that "trillion-parameter systems" may resist simple unified explanations. The hypothesis may hold for statistical structure while failing for perceptual richness. [18]
**Key sources:** [17], [18], [19], [20], [33]
**Relates to:** Multimodal Alignment, Embedding Space, Latent Space Reasoning, Embedding Translation

### Promptable Embeddings

**Definition:** A paradigm (2025) where embeddings vary based on both input content and task instructions, rather than being static vectors. The same image produces different embeddings depending on the downstream task — one for captioning, another for object detection, another for retrieval. [11]
**Current state:** Emerged in Generation 3 unified models (VLM2Vec-V2, Omni-Embed-Nemotron). Represents a conceptual shift from "one embedding per input" to "one embedding per (input, task) pair." Enabled by instruction-tuned vision-language models that condition their representation on a textual prompt describing the desired task. The practical impact is significant: training on visual documents (PDFs, slides) improved general image understanding from 76.3% to 85.7% [11]. Omni-Embed-Nemotron outputs 2048-dimensional embedding vectors that support both cross-modal (text ↔ video) and joint-modal (text ↔ video+audio) retrieval from a single model. [11], [25]

This paradigm challenges the notion of a static "concept" in embedding space — the representation of a concept depends on what you want to do with it. A dog in an image has a different optimal embedding for "what animal is this?" vs "is this photo indoor or outdoor?" vs "find similar cute animals."
**Key sources:** [11], [25]
**Relates to:** Multimodal Alignment, Embedding Space

### Discrete Multimodal Tokenization

**Definition:** An alternative to continuous embedding spaces where all modalities are compressed into discrete token sequences using specialized tokenizers, then processed uniformly by an autoregressive language model. [34]
**Current state:** AnyGPT (ACL 2024) demonstrates this approach: speech is tokenized via SpeechTokenizer, images via SEED tokens (aligned with diffusion latent space), music via Encodec (residual vector quantization). All modalities become discrete sequences that a standard LLM processes autoregressively — "without any alterations to the current LLM architecture or training paradigms." Trained on AnyInstruct-108k (108K multi-turn dialogues with interleaved multimodal elements). [34]

This represents a fundamentally different philosophy from continuous embedding spaces. Rather than projecting everything into a shared geometric space where distance encodes similarity, discrete tokenization converts everything into a shared symbolic vocabulary where sequential patterns encode meaning. The approach sacrifices the geometric properties of continuous spaces (arithmetic, interpolation, distance-based retrieval) in exchange for compatibility with existing LLM architectures and training pipelines.

The trade-off is revealing: continuous embeddings are better for retrieval and similarity tasks (where distance matters), while discrete tokens are better for generation tasks (where sequential prediction matters). The two approaches may ultimately complement rather than compete. [34]
**Key sources:** [34]
**Relates to:** Embedding Space, Latent Space Reasoning, Multimodal Alignment

### Geometric Properties of Embeddings

**Definition:** The mathematical structure of embedding spaces — the geometry that makes operations like arithmetic, retrieval, and reasoning possible. Different geometric properties serve different purposes. [10a], [13], [28]
**Current state:** Several geometric frameworks compete:

**Euclidean space (standard):** Most embedding models use Euclidean (flat) geometry with cosine similarity as the distance metric. Simple and well-understood, but struggles with hierarchical relationships — the distance between "animal" and "dog" is the same type of measurement as between "golden retriever" and "labrador," despite the conceptual levels being different.

**Hyperbolic space:** Exponentially expanding space that naturally encodes hierarchical (tree-like) relationships. Ramasinghe et al. (CVPR 2024) explored hyperbolic multimodal embeddings, finding that naive application of contrastive loss in hyperbolic space creates contradictory objectives. Their angle-based loss resolves this by aligning concepts directionally rather than spatially, positioning images further along geodesics from text (reflecting greater specificity). Works effectively in "high curvature spaces" unlike prior methods. [10a]

**Box embeddings:** Represent entities as hyper-rectangles rather than points. Naturally model set membership (a point inside a box) and set operations (box intersection ≈ conjunction). Query2Box showed up to 25% improvement over point-based methods for knowledge graph reasoning. [13]

**Manifold structure:** Real data in high-dimensional spaces typically lies on lower-dimensional manifolds. The manifold hypothesis implies that the "true" embedding space is much smaller than the ambient dimension — a 768-dimensional CLIP embedding may capture its essential semantic content in ~32–128 effective dimensions. ImageBind analysis confirms this: PCA reduction to 32 dimensions preserves cluster structure with optimal Silhouette scores. [24], [24a]

The choice of geometry constrains what operations are possible. Euclidean spaces support arithmetic; hyperbolic spaces support hierarchy; box embeddings support logical operations. A truly universal embedding space might require a hybrid geometry that supports all three — an unsolved problem.
**Key sources:** [10a], [13], [24], [24a], [28]
**Relates to:** Embedding Space, Embedding Arithmetic, Modality Gap

## Themes

### Theme 1: The Pivot Modality Pattern — Elegance, Limits, and Succession

A recurring architectural pattern in multimodal embedding research is the use of a **pivot modality** to achieve transitive alignment. ImageBind uses images, LanguageBind uses language, and both exploit the insight that paired data with the pivot is sufficient to implicitly align all other modalities with each other.

The pivot pattern is data-efficient — it avoids the combinatorial explosion of needing paired data for every modality pair (with N modalities, you need N−1 paired datasets instead of N(N−1)/2). ImageBind demonstrated this dramatically: training only on (image, X) pairs for each modality X, it achieved emergent (audio, text) and (depth, text) retrieval that was never explicitly trained. Analysis of ImageBind's internal structure (Bian et al., 2024) confirmed that this isn't superficial — pure audio embeddings genuinely correlate with semantically similar visual items, and meaningful fused embeddings can be created through simple arithmetic averaging of modality vectors. [3], [24a]

**The choice of pivot matters.** LanguageBind's use of language as anchor — rather than images — proved empirically stronger, particularly for video-text retrieval (42.7% vs 34.2% R@10). This may reflect language's richer semantic structure: language can express abstract relationships, negation, temporal ordering, and composition that images encode more implicitly. ONE-PEACE takes a middle path with shared self-attention layers, allowing cross-modal information flow without a strict anchor.

**The pivot bottleneck is real.** Binding approaches force information through the anchor modality, potentially losing features that the anchor cannot represent. What aspects of thermal imagery are relevant but have no natural image-pair analogue? What audio features matter that aren't captured in image-audio correlation? The 2025 generation of fully unified models confirms this limitation empirically: VLM2Vec-V2 achieves 87.2% on image-text retrieval vs. CLIP's 72.3%; Omni-Embed-Nemotron's decoupled late-fusion achieves 0.5662 NDCG@10 on video retrieval vs. 0.4700 for early fusion. [11], [25]

The pivot era (2023–2024) appears transitional — necessary when paired multimodal data was scarce, but being superseded as training infrastructure scales. The trajectory suggests the field is moving from "align modalities" (an engineering constraint) toward "understand modalities jointly" (a modeling goal).

### Theme 2: The Gap That Won't Close — And Maybe Shouldn't

The modality gap is the most persistent challenge to the vision of truly universal embeddings, and its story illustrates how the field's understanding has deepened over just four years.

**The discovery phase** (2022) established the basic phenomenon: in CLIP, image and text embeddings cluster in separate regions of the hypersphere. Liang et al. identified two contributing factors — the cone effect (separate encoders initialize in different cones) and contrastive loss dynamics (the loss maintains rather than closes the initial separation).

**The reframing phase** (2024) shifted the explanation. Fahim et al. showed that even identical modalities processed through two separate encoders develop a gap under contrastive training. The root cause isn't modality difference — it's low uniformity in the embedding space. Embeddings cluster in a small region rather than distributing evenly across the available space. Adding uniformity regularization directly to the loss reduces the gap and improves zero-shot classification.

**The acceptance phase** (2024) introduced the most provocative idea: the gap might be useful. Ramasinghe et al. argue that text and images have "intrinsic differences in representational nature" — text conveys abstract concepts through syntax while images express scenes through visual cues. They prove formally that forcing spatial proximity between modalities in hyperbolic space creates contradictory objectives: Proposition 1 shows that when multiple distinct image embeddings must maintain consistent distances to one text embedding (as contrastive loss requires), satisfying entailment constraints is impossible. Proposition 2 shows joint optimization causes "exponential contraction" — image embeddings collapse into an ever-shrinking region, destroying hierarchical structure.

Their solution — **angle-based contrastive loss** — is conceptually elegant: instead of making image and text embeddings spatially close, make them point in the same direction from the origin. Images sit further along geodesics (reflecting greater specificity), text sits closer (reflecting greater abstraction). This preserves hierarchy while enabling cross-modal retrieval, and works in high-curvature hyperbolic spaces where prior methods fail.

**The uniformity-tolerance dilemma** underlies all of this: the temperature parameter in contrastive loss controls whether embeddings spread uniformly (good for diverse retrieval) or cluster locally (good for fine-grained similarity). Small temperatures increase uniformity but push apart semantically similar items; large temperatures preserve local structure but create sparse, gappy distributions. No single temperature resolves this. Adaptive temperature strategies (2024) attempt dynamic adjustment, but the fundamental trade-off remains.

**GRAM** (ICLR 2025) attacks the gap from a different angle: instead of pairwise alignment (which creates the gap as a side effect), it aligns all N modalities simultaneously by minimizing the Gramian volume of the parallelotope they span. This shifts from "make A close to B, then B close to C" to "make A, B, and C geometrically aligned as a system." Results show state-of-the-art on video-audio-text retrieval.

The combined picture: the modality gap is partially an artifact of training (addressable with better objectives) and partially a genuine feature of cross-modal representation (useful if respected rather than forced away). A truly universal space may need to be **structured** — with shared semantic directions but modality-specific regions, much like a building with shared hallways but different rooms.

### Theme 3: From Arithmetic to Reasoning — The Operations Spectrum

The history of "what you can do with embeddings" traces a trajectory from simple to sophisticated, each step extending what kind of meaning can be manipulated geometrically.

**Level 1 — Linear arithmetic (2013):** Word2Vec revealed that word embeddings encode relational structure as directions. king − man + woman ≈ queen captures the "royalty" direction. But this is fragile: it only works when input words are excluded from the nearest-neighbor search (otherwise king − man + woman = king), and the underlying mechanism is co-occurrence statistics, not conceptual understanding. The arithmetic captures that "king" and "queen" appear in similar contexts adjusted for the gender contexts of "man" and "woman." [6], [7]

**Level 2 — Cross-modal arithmetic (2023):** ImageBind showed that modality vectors can be composed meaningfully: image(beach) + audio(birds) retrieves beach-with-birds images. This is more impressive than word-level arithmetic because the modalities were never directly paired in training — the arithmetic works through the shared embedding structure. However, it remains compositional (adding properties) rather than inferential (deriving new conclusions). [3]

**Level 3 — Region-based logic (2020):** Query2Box represents entities as points and queries as boxes. Logical conjunction becomes box intersection; existential quantification becomes projection onto a subspace. This enables multi-hop reasoning over knowledge graphs: "What movies did Actor X star in that were directed by Director Y?" becomes a sequence of geometric operations. Achieves 25% improvement over point-based methods. Importantly, the authors prove a fundamental limit: disjunctions (OR) require embedding dimension proportional to the number of entities — a genuine geometric constraint on what logic can be done in bounded-dimensional spaces. [13]

**Level 4 — Continuous reasoning (2024–2025):** Coconut feeds the LLM's hidden state back as input, creating a loop of "continuous thoughts" that never decode to words. This is the first approach to perform multi-step reasoning entirely in embedding space. Key capabilities: (a) encodes multiple reasoning paths simultaneously (breadth-first search), (b) avoids wasting capacity on textual coherence, (c) outperforms CoT on planning-heavy tasks. Huginn (3.5B params) implements a related idea through depth-recurrence: a small set of transformer blocks iterates variable times, with harder problems getting more iterations. Analysis reveals emergent latent dynamics — orbital patterns and fixed-point convergence — but limited evidence of structured step-by-step reasoning (per logit lens and coda lens probing). [14], [29], [30]

**Level 5 — Recursive reasoning with discrete anchoring (2025):** A hybrid approach where continuous hidden states periodically project into structured discrete spaces and re-embed. This maintains semantic stability over long reasoning chains and achieves "perfect generalization" to inputs several times larger than training examples. The periodic discretization acts as an error-correction mechanism, preventing the semantic drift that plagues purely continuous latent reasoning. [31]

The progression reveals a pattern: each level trades interpretability for capability. Word arithmetic is transparent but weak. Continuous reasoning is powerful but opaque. The field hasn't yet found an approach that is simultaneously powerful, interpretable, and general — a trilemma that may be fundamental.

### Theme 4: Convergence Toward Universal Representation — Evidence and Limits

The Platonic Representation Hypothesis offers the strongest theoretical argument for universal embeddings: if all sufficiently large models converge toward the same statistical model of reality, then a universal embedding space isn't just possible — it's inevitable at scale.

**The evidence is mounting.** Huh et al. (ICML 2024) showed that cross-model alignment increases with scale and training duration, across both vision and language models. The vec2vec framework (2025) provided the most dramatic practical demonstration: embeddings can be translated between entirely different model architectures without any paired data, achieving 0.92 cosine similarity. mini-vec2vec (2025) showed this translation can be accomplished with just a linear transformation, suggesting the mapping between model spaces is surprisingly simple — rotations and scalings, not complex nonlinear warps. [17], [19], [20]

**The Vector Rosetta story** makes this concrete at scale. A production system with 200M+ CLIP embeddings needed to migrate to SigLIP (5–10% better recall@1). Rather than re-embedding everything (weeks of GPU time), they trained a 50M-parameter adapter that converts CLIP → SigLIP directly. Results: 41x faster than re-embedding, 90.9% cosine similarity preservation, 94.3% Rank@1 accuracy on 10K pools, 85.7% on WikiArt. This works precisely because the two spaces share enough geometric structure to be bridged — evidence for the Platonic hypothesis in production. [33]

**But convergence has limits.** The HN discussion on natively multimodal LLMs surfaced a critical distinction: LLM embeddings (optimized for next-token prediction) produce fundamentally different representations than retrieval embeddings (optimized for semantic similarity). As one commenter noted, LLM embeddings contain "super positions of many concepts" tuned for text prediction, making them poor at similarity-based retrieval despite encoding rich semantic information. The Platonic hypothesis may describe convergence of **statistical structure** without convergence of **operational utility** — two spaces can be structurally isomorphic but optimized for different operations. [21]

Efros's critique — "there is a reason why you go to an art museum instead of just reading the catalog" — points to a deeper issue: statistical convergence captures shared relational structure but may lose modality-specific phenomenological richness. The smell of coffee, the timbre of a violin, the texture of sandpaper — these may resist representation as points in a shared vector space not because they lack statistical correlates, but because their experiential character is inherently non-reducible.

### Theme 5: Continuous vs. Discrete — Two Philosophies of Universal Representation

A less-discussed but fundamental tension in the field: should universal multimodal representation be **continuous** (shared vector spaces) or **discrete** (shared token vocabularies)?

**The continuous camp** (CLIP, ImageBind, Omni-Embed) projects all modalities into geometric spaces where distance, direction, and arithmetic encode meaning. Strengths: supports smooth interpolation, distance-based retrieval, and (nascent) geometric reasoning. Weakness: the modality gap, difficulty with discrete logic, and opaque latent reasoning.

**The discrete camp** (AnyGPT, 2024) converts all modalities into token sequences via specialized tokenizers — SpeechTokenizer for speech, SEED for images, Encodec for music. A standard LLM then processes all modalities as discrete sequences "without any alterations to the current LLM architecture or training paradigms." Strengths: full compatibility with autoregressive generation, explicit token-by-token processing, and ability to leverage all existing LLM infrastructure. Weakness: loses geometric properties (no distance-based similarity, no smooth interpolation), and tokenization introduces quantization error. [34]

The two approaches may capture different aspects of "universal representation":
- Continuous spaces capture **similarity structure** — what is like what, and how much
- Discrete tokens capture **compositional structure** — what follows what, and in what pattern

A complete "universal concept space" might require both: continuous embeddings for representing and comparing concepts, discrete tokens for sequencing and composing them. This mirrors the dual-process theory in cognitive science (Kahneman's System 1/System 2): fast, intuitive similarity judgments (continuous) alongside slow, deliberate sequential reasoning (discrete).

### Theme 6: The Text → Embedding → Reasoning → Embedding → Text Pipeline

The proposed pipeline maps directly onto current research directions, with each component at a different maturity level and facing distinct challenges:

**Text → Embeddings (Mature):** LLM encoders, CLIP/SigLIP, and dedicated embedding models handle this well. The main subtlety is that different downstream uses require different embeddings — a retrieval embedding is not the same as a generation-conditioning embedding, which is not the same as a reasoning-state embedding. Promptable embeddings (2025) begin to address this by making the embedding task-conditional. [11]

**Embeddings → Reasoning (Nascent):** Coconut demonstrates feasibility for logical planning tasks, achieving better accuracy-efficiency trade-offs than explicit CoT. Huginn shows that depth-recurrent architectures can adaptively allocate compute to harder problems. "Scaling by Thinking in Continuous Space" (2025) observes emergent sophisticated dynamics (orbital patterns, fixed-point convergence) in latent reasoning. But critical gaps remain: (a) latent reasoning currently matches rather than exceeds explicit CoT accuracy; (b) generalization to novel problem structures is weak; (c) models may use "shortcuts" rather than genuine multi-step reasoning. [14], [29], [30]

**Reasoning → Embeddings → Text (Weakest link):** Decoding from latent reasoning states back to human-interpretable text is where the vision breaks down most. Coconut produces final answers, but the intermediate "continuous thoughts" are not human-readable. Chain-of-Embedding can detect correct vs. incorrect reasoning patterns without decoding, but can't explain what the reasoning was. The recursive discrete-anchoring approach (Level 5 in Theme 3) offers a partial solution: periodic projection to discrete space provides checkpoints of interpretability within otherwise continuous reasoning. [14], [15], [31]

**The fundamental tension:** A "thinking machine" that operates purely on embeddings gains efficiency (no token decoding overhead) and expressiveness (continuous representations can encode superpositions of possibilities) but loses interpretability (no human-readable intermediate steps) and verifiability (how do you check if the reasoning was sound?). The AI safety community has flagged this as a significant concern: latent reasoning makes it harder to detect when a model is "reasoning" incorrectly, deceptively, or in unintended ways. [32]

**The type mismatch problem:** Perhaps the deepest challenge is that the "thinking machine" would need embeddings optimized for reasoning operations — a third type distinct from retrieval embeddings (optimized for similarity) and generation embeddings (optimized for next-token prediction). What geometric properties does a "reasoning embedding" need? Linear directions for analogies (like Word2Vec), box structures for logical operations (like Query2Box), continuous dynamics for multi-step inference (like Coconut) — these impose different and potentially incompatible geometric constraints. Whether a single space can support all three is an open question. [21]

## Synthesis

Six themes emerge from this research landscape, and they converge on a central insight: **universal embedding spaces are not a single destination but a spectrum of increasingly powerful approximations, and the most important design decisions involve trade-offs between competing desiderata rather than simply scaling toward a unified solution.**

The empirical trajectory is clear and accelerating: CLIP (2021) → ImageBind (2023) → LanguageBind (2024) → VLM2Vec-V2 / Omni-Embed (2025). Each generation aligns more modalities, more tightly, with better downstream performance. The Platonic Representation Hypothesis provides a theoretical explanation for why this works at all — and vec2vec demonstrates that the convergence is deep enough to enable model-to-model translation without paired data. The theoretical case for eventual universal embeddings is strong.

But the engineering reality reveals that "universal" has at least three distinct meanings that may be in tension:

1. **Universal across modalities** — a single space for text, images, audio, video, and beyond. Progress is real (6 modalities in ImageBind, 4 in Omni-Embed) but the modality gap persists, and some researchers argue it should persist because modalities genuinely require separate representational regions.

2. **Universal across operations** — a single space supporting retrieval, generation, reasoning, and logic. This is the most challenging dimension. Retrieval needs smooth similarity surfaces; logic needs discrete regions and boundaries (boxes); reasoning needs dynamics (recurrence, fixed points). These impose different geometric constraints. No single space supports all three well today.

3. **Universal across models** — embeddings from different models being interchangeable. The vec2vec and Vector Rosetta results suggest this is achievable, at least approximately, through learned translations. This is the most pragmatically useful form of universality.

The "thinking machine" vision — embedding-space reasoning decoupled from language — is the most speculative piece but also the most intellectually interesting. The continuous/discrete tension (Theme 5) suggests the right answer may not be a pure embedding machine but a hybrid system: continuous spaces for representing and navigating the semantic landscape, discrete tokens for compositional and sequential reasoning, with interfaces between the two (like recursive discrete anchoring in Level 5 reasoning). This mirrors how the brain uses both continuous neural dynamics and discrete symbolic representations.

The most actionable near-term insight: the field is converging on a pattern where **models think in latent space and speak in token space**. Coconut, Huginn, and the depth-recurrent architectures all follow this pattern. The "thinking machine" isn't a separate component — it's increasingly being integrated into the model itself, with the output decoder serving as the "translator back to text." The question isn't whether to build a separate reasoning machine, but how to make the reasoning that already happens inside models more general, more multimodal, and more trustworthy.

## Gaps & Open Questions

1. **No true N-modality universal space exists yet.** Current models handle 3–6 modalities. No model has been demonstrated on the full range of human sensory modalities (text, vision, audio, touch, smell, proprioception) let alone abstract cognitive modalities (mathematical structure, musical harmony, spatial reasoning). Whether a single space can scale to arbitrary modalities without degradation is unknown.

2. **The modality gap's fundamental nature is unresolved.** Three competing explanations exist — artifact of training objectives (Fahim et al.), structural necessity (Ramasinghe et al.), or both — and each implies a different engineering approach (eliminate it, accept it, or structure it). GRAM's geometric alignment and the angle-based loss offer promising directions but haven't been tested at scale with many modalities.

3. **Latent reasoning doesn't generalize well.** Coconut and Huginn work on structured logical/mathematical tasks but haven't been demonstrated on open-ended, creative, or abductive reasoning. The logit/coda lens analysis of Huginn found limited evidence of structured chain-of-thought patterns, suggesting the mechanism may be iterative refinement rather than step-by-step reasoning. Whether continuous latent spaces can support the full range of reasoning is deeply uncertain.

4. **Interpretability of latent reasoning is near-zero.** If reasoning happens in embedding space, we lose the ability to inspect intermediate steps. The AI safety community considers this a critical concern. Chain-of-Embedding offers some signal (correct vs. incorrect patterns), and recursive discrete anchoring provides periodic interpretability checkpoints, but "understanding" what a continuous thought represents remains unsolved.

5. **The geometry of "reasoning embeddings" is unexplored.** Retrieval embeddings need smooth similarity surfaces. Logic needs boxes and boundaries. Reasoning needs dynamics (convergence, oscillation). These impose different and potentially incompatible geometric constraints. Whether a single geometry can support all three, or whether a hybrid geometry is needed, is an open research question.

6. **The continuous vs. discrete choice is unresolved.** Continuous embeddings and discrete tokens excel at different tasks (retrieval vs. generation). A universal representation may require both, but the interface between them (how to discretize without losing information, how to embed without losing compositionality) is underexplored. The recursive discrete anchoring approach hints at solutions.

7. **Scale requirements are unknown.** The Platonic Representation Hypothesis predicts convergence with scale, but the required scale for practical universality — and whether it's achievable with current hardware — is unquantified. The vec2vec results suggest useful convergence exists at current scales, but full convergence may require orders of magnitude more.

8. **Evaluation frameworks for universal embeddings are immature.** MMEB-V2 tests retrieval across modalities. But there's no standard benchmark for cross-modal reasoning, embedding arithmetic generalization, latent reasoning quality, or the kind of "think in embedding space" pipeline the user envisions. The field is building what it can measure, which may not be what matters most.

9. **The security implications are underexplored.** Vec2vec demonstrates that embeddings can be translated between model spaces — which means embeddings are not private. An adversary with access to embedding vectors could extract sensitive document information sufficient for classification and attribute inference, even without access to the original model.

## Implications

1. **Experiment:** Test whether current multimodal embedding models (ImageBind, VLM2Vec-V2) can support basic cross-modal reasoning tasks — e.g., can you perform analogy operations across modalities (text:image :: audio:?) and get meaningful results? Measure how many "hops" of transitive reasoning the embedding space supports before quality degrades.

2. **Experiment:** Evaluate Coconut-style latent reasoning on a practical task — e.g., can a model reason about code architecture in embedding space more efficiently than via explicit chain-of-thought? Compare accuracy, efficiency, and failure modes.

3. **Experiment:** Test the continuous/discrete hybrid hypothesis — take a reasoning task, run it with (a) pure CoT (discrete), (b) pure Coconut (continuous), and (c) a hybrid with periodic discrete anchoring. Does the hybrid outperform both pure approaches?

4. **BET:** "By 2027, at least one production system will use latent-space reasoning (no token decoding) as its primary inference mode for planning tasks." The Coconut and Huginn results suggest this is likely for narrow, well-structured domains.

5. **BET:** "By 2028, embedding spaces from different foundation models will be routinely translatable without paired data." The vec2vec, mini-vec2vec, and Vector Rosetta results suggest this is already emerging and will become standard tooling.

6. **BET:** "By 2027, the modality gap will be reframed from a 'problem to solve' to a 'structure to leverage' in at least one major multimodal model." The Ramasinghe et al. work and the angle-based loss point toward treating the gap as informative rather than adversarial.

7. **ADR candidate:** If adopting embedding-based retrieval or RAG in this project, choose between: binding-era models (CLIP/ImageBind — simple, well-understood, good ecosystem) vs. Generation 3 unified models (VLM2Vec-V2/Omni-Embed — better performance, more complex) vs. discrete token approaches (AnyGPT-style — better for generation, worse for retrieval).

8. **Future research:** The "thinking machine" concept warrants a dedicated follow-up investigation into: (a) Coconut and Huginn's internal dynamics, (b) whether latent reasoning capabilities can be combined with multimodal embeddings, (c) the recursive discrete anchoring approach as a potential bridge between continuous reasoning and interpretability, and (d) the AI safety implications of opaque latent reasoning.

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
- [10a] Ramasinghe, S. et al. "Accept the Modality Gap: An Exploration in the Hyperbolic Space." CVPR 2024.
- [11] TheDataGuy. "Understanding Multimodal Embeddings: The Evolution from CLIP to Unified Foundation Models." 2025. https://thedataguy.pro/blog/2025/12/multimodal-embeddings-evolution/
- [12] Oñoro-Rubio, D. et al. "Gramian Multimodal Representation Learning and Alignment." ICLR 2025. https://arxiv.org/abs/2412.11959
- [13] Ren, H. et al. "Query2Box: Reasoning over Knowledge Graphs in Vector Space Using Box Embeddings." ICLR 2020. https://arxiv.org/abs/2002.05969
- [14] Hao, S. et al. "Training Large Language Models to Reason in a Continuous Latent Space" (Coconut). COLM 2025. https://arxiv.org/abs/2412.06769
- [15] Wang, Y. et al. "Latent Space Chain-of-Embedding Enables Output-free LLM Self-Evaluation." ICLR 2025. https://arxiv.org/abs/2410.13640
- [16] "Reasoning Beyond Language: A Comprehensive Survey on Latent Chain-of-Thought Reasoning." 2025. https://arxiv.org/abs/2505.16782
- [17] Huh, M. et al. "The Platonic Representation Hypothesis." ICML 2024. https://arxiv.org/abs/2405.07987
- [18] Quanta Magazine. "Distinct AI Models Seem To Converge On How They Encode Reality." Jan 2026. https://www.quantamagazine.org/distinct-ai-models-seem-to-converge-on-how-they-encode-reality-20260107/
- [19] Jha, R. et al. "Harnessing the Universal Geometry of Embeddings" (vec2vec). 2025. https://arxiv.org/abs/2505.12540
- [20] "mini-vec2vec: Scaling Universal Geometry Alignment with Linear Transformations." 2025. https://arxiv.org/abs/2510.02348
- [21] Hacker News. Discussion on natively multimodal LLMs and embeddings. 2024. https://news.ycombinator.com/item?id=42163723
- [22] Zhai, X. et al. "Sigmoid Loss for Language Image Pre-Training" (SigLIP). 2023. https://arxiv.org/abs/2303.15343
- [23] Tschannen, M. et al. "SigLIP 2: A better multilingual vision language encoder." 2025. https://huggingface.co/blog/siglip2
- [24] Wikipedia. "Curse of dimensionality." https://en.wikipedia.org/wiki/Curse_of_dimensionality
- [24a] Bian, J. et al. "From Latent to Engine Manifolds: Analyzing ImageBind's Multimodal Embedding Space." 2024. https://arxiv.org/abs/2409.10528
- [25] Gu, T. et al. "Omni-Embed-Nemotron: A Unified Multimodal Retrieval Model for Text, Image, Audio, and Video." NVIDIA, 2025. https://arxiv.org/abs/2510.03458
- [26] Wang, F. and Liu, H. "Understanding the Behaviour of Contrastive Loss." CVPR 2021.
- [27] Gu, T. et al. "Breaking the Modality Barrier: Universal Embedding Learning with Multimodal LLMs" (UniME). 2025. https://arxiv.org/abs/2504.17432
- [28] Emergent Mind. "Reasoning in Embedding Space." https://www.emergentmind.com/topics/reasoning-in-embedding-space
- [29] Emergent Mind. "Huginn-3.5B: Depth-Recurrent Language Model." https://www.emergentmind.com/topics/huginn-3-5b
- [30] "Scaling by Thinking in Continuous Space." 2025. https://arxiv.org/abs/2502.05171
- [31] "Unlocking Out-of-Distribution Generalization in Transformers via Recursive Latent Space Reasoning." 2025. https://arxiv.org/abs/2510.14095
- [32] LessWrong. "On the Implications of Recent Results on Latent Reasoning in LLMs." https://www.lesswrong.com/posts/pLnLSgWphqDbdorgi/on-the-implications-of-recent-results-on-latent-reasoning-in
- [33] Hacker News. "CLIP to SigLIP: Migrating 200M+ Multimodal Embeddings." 2026. https://news.ycombinator.com/item?id=46673957
- [34] Zhan, J. et al. "AnyGPT: Unified Multimodal LLM with Discrete Sequence Modeling." ACL 2024. https://arxiv.org/abs/2402.12226
- [35] Hacker News. "Harnessing the Universal Geometry of Embeddings." Discussion thread, 2025. https://news.ycombinator.com/item?id=44054425
- [36] EdenAI. "Best Multimodal Embeddings APIs in 2025." https://www.edenai.co/post/best-multimodal-embeddings-apis
- [37] AIMUltiple. "Multimodal Embedding Models: Apple vs Meta vs OpenAI." https://research.aimultiple.com/multimodal-embeddings/
