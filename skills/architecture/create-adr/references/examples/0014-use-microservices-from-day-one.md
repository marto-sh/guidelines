# 14. Use Microservices Architecture from Day One

Date: 2025-09-15

## Status

Rejected

## Context

We are starting a new product with a team of 4 engineers. We anticipate the product will grow significantly if successful, and we want to ensure the architecture can scale.

Some team members have experience with microservices at previous companies and suggest we start with microservices architecture to avoid a painful migration later.

Key considerations:
- Product is in MVP stage, need to ship in 3 months
- Team of 4 engineers (2 backend, 1 frontend, 1 full-stack)
- No dedicated DevOps engineer
- Expecting significant growth if product-market fit is achieved
- Team members have varying levels of distributed systems experience

## Decision Drivers

* **Future scalability** - Product may need to scale significantly
* **Team experience** - Some team members have microservices experience
* **Development velocity** - Need to ship MVP in 3 months
* **Team size** - Currently only 4 engineers
* **Operational complexity** - Limited DevOps resources
* **Organizational structure** - Single team with no clear sub-team boundaries

## Considered Options

* Start with microservices architecture
* Start with modular monolith, extract services later
* Start with simple monolith

## Decision

**This ADR was rejected.** We will NOT use microservices architecture from day one.

Instead, we will start with a **modular monolith** with clear service boundaries, and extract services only when we have concrete scaling or team organization needs.

### Rationale for Rejection

While microservices offer benefits at scale, the operational complexity and overhead are too high for our current team size and stage:

1. **Operational burden:** With 4 engineers and no dedicated DevOps, we can't effectively operate 8+ services, each needing deployment, monitoring, logging, and debugging
2. **Development velocity:** Microservices would slow down our MVP development due to:
   - Network calls and latency for service-to-service communication
   - Service coordination and distributed transactions
   - Distributed debugging and tracing overhead
   - Need to establish API contracts before implementation
3. **Premature optimization:** We're optimizing for a scale problem we don't have yet
4. **Team organization:** Microservices work best with multiple teams owning services; we're a single team
5. **Cost:** Running multiple services with proper redundancy is more expensive than a monolith

The modular monolith gives us the benefits of clear boundaries while avoiding the operational overhead. We can extract services later if and when we need to.

## Consequences

### Positive (from choosing modular monolith)

* Faster development velocity for MVP (no network overhead, simpler debugging)
* Simpler deployment (single artifact, fewer moving parts)
* Easier debugging (single process, no distributed tracing needed yet)
* Lower infrastructure costs (one application server vs. many)
* Can extract services later when needed (if boundaries are clear)
* Lower operational burden (one service to monitor, one deploy pipeline)

### Negative (from rejecting microservices)

* Will need migration effort if we extract services later
* May miss some learning opportunities about operating distributed systems
* Some team members disappointed (wanted to use microservices)
* If we grow rapidly, may face scaling bottlenecks before we can extract services
* Requires discipline to maintain module boundaries without enforcement

### Neutral

* Need to establish clear module boundaries within monolith
* Will document which modules could become services later
* May need to refactor if boundaries are wrong (but same risk with microservices)

## Validation

We will revisit this decision when ANY of the following triggers occur:

* **Team size:** Team grows beyond 10 engineers with clear sub-team structure
* **Performance bottlenecks:** Performance profiling shows clear bottlenecks that would benefit from independent scaling of specific components
* **Organizational boundaries:** We have clear organizational boundaries that map to service boundaries (e.g., separate teams for orders, inventory, payments)
* **Deployment frequency:** We need to deploy different parts of the system at different cadences
* **Technology diversity:** We need different technology stacks for different components

**Evaluation timeline:** Review quarterly or when any trigger occurs

## Pros and Cons of the Options

### Start with Microservices Architecture

* Good, because prepares for future scale
* Good, because enforces service boundaries
* Good, because allows independent deployment of services
* Good, because some team members have experience
* Bad, because high operational overhead for small team
* Bad, because slows down initial development velocity
* Bad, because requires distributed tracing, service discovery, API gateways
* Bad, because more expensive infrastructure (multiple services with redundancy)
* Bad, because premature optimization (optimizing for problems we don't have)

### Start with Modular Monolith, Extract Services Later

* Good, because faster initial development
* Good, because simpler operations and debugging
* Good, because lower infrastructure costs
* Good, because clear module boundaries allow future extraction
* Good, because can extract services when we have real data on bottlenecks
* Bad, because requires migration effort later
* Bad, because requires discipline to maintain boundaries
* Bad, because risk of "big ball of mud" if boundaries erode

### Start with Simple Monolith (No Modular Structure)

* Good, because fastest initial development
* Good, because simplest operations
* Bad, because no clear boundaries makes future extraction very difficult
* Bad, because tight coupling makes testing harder
* Bad, because likely becomes "big ball of mud" over time

## Related Decisions

* [ADR-0015](0015-modular-monolith-structure.md) - How to structure the monolith for future service extraction
* [ADR-0016](0016-module-communication-rules.md) - Rules for inter-module communication within monolith

## References

* [MonolithFirst - Martin Fowler](https://martinfowler.com/bliki/MonolithFirst.html)
* [The Majestic Monolith - DHH](https://m.signalvnoise.com/the-majestic-monolith/)
* [Microservices Prerequisites - Martin Fowler](https://martinfowler.com/bliki/MicroservicePrerequisites.html)
* [Don't Start With Microservices](https://arnoldgalovics.com/microservices-in-production/)

---

## Why Documenting Rejections Matters

This ADR documents a decision NOT to adopt microservices. This is valuable because:

1. **Prevents rediscussion:** New team members won't suggest microservices without understanding why we rejected it
2. **Shows thoughtfulness:** We considered microservices seriously, not just dismissed it
3. **Sets triggers:** Clear criteria for when to reconsider
4. **Preserves context:** Future readers understand the constraints at the time

Rejected ADRs are not failures—they're evidence of good decision-making.
