# 5. Use PostgreSQL for Primary Database

Date: 2026-01-15

## Status

Accepted

## Context

Our microservices-based e-commerce platform needs a reliable database for order management, inventory tracking, and customer data. We're currently in the design phase with no production data yet.

Key constraints and requirements:
- Must support ACID transactions (financial data requires strict consistency)
- Need complex queries with joins (product catalog with categories, tags, variants)
- Expected initial load: 100K orders/month, scaling to 1M within 2 years
- Team has SQL experience but limited NoSQL experience
- Budget: ~$500/month for database infrastructure initially
- Compliance: PCI-DSS for payment data storage

The decision affects all microservices that need persistent storage and will be costly to change after we have production data.

## Decision Drivers

* **Data consistency requirements** - ACID transactions are critical for financial operations
* **Query complexity** - Need complex relational queries with joins
* **Team expertise** - Team is proficient in SQL, less experienced with NoSQL
* **Cost** - Need to stay within budget constraints
* **Scalability** - Must support projected growth to 1M orders/month
* **Compliance** - Must meet PCI-DSS requirements

## Considered Options

* PostgreSQL
* MongoDB
* DynamoDB (AWS)
* MySQL

## Decision

We will use **PostgreSQL** as our primary database for all microservices that require relational data and ACID guarantees.

### Rationale

PostgreSQL best satisfies our critical decision drivers:
1. **ACID compliance** is built-in and battle-tested, which is non-negotiable for financial data
2. **Query capabilities** are excellent for complex relational queries we need for reporting
3. **Team expertise** aligns with SQL, minimizing learning curve and time-to-productivity
4. **Cost** is predictable with managed services (AWS RDS, Azure Database)
5. **Extensibility** with JSONB allows NoSQL-like flexibility where needed without a separate database

PostgreSQL's strong consistency model and relational capabilities outweigh the potential performance benefits of NoSQL options for our use case.

## Consequences

### Positive

* Team can be productive immediately without learning new database paradigms
* ACID guarantees simplify application logic (no distributed transaction coordination)
* Rich ecosystem of tools for backup, monitoring, and management
* JSONB support provides flexibility for semi-structured data without additional database
* Strong community support and extensive documentation
* Battle-tested in production by companies at our scale (Instagram, Spotify, Reddit)

### Negative

* Vertical scaling has limits; horizontal scaling (sharding) is more complex than with DynamoDB
* May need additional caching layer (Redis) for high-read workloads sooner than with some alternatives
* Lock contention could become an issue at very high write volumes
* Managed service costs increase with storage/IOPS (though predictable)

### Neutral

* Need to establish backup and disaster recovery procedures
* Will use connection pooling (PgBouncer) to manage connection limits
* Schema migrations must be carefully planned and tested

## Validation

We will evaluate this decision based on:

* **Performance:** Order processing time remains under 200ms at p99 through 1M orders/month milestone
* **Cost:** Database costs stay under $1000/month at 1M orders/month scale
* **Team velocity:** No significant slowdowns due to database limitations in first 6 months
* **Reliability:** Database-related incidents are < 0.01% of transactions

**Evaluation timeline:** Review after 6 months in production and again at 1M orders/month milestone

## Pros and Cons of the Options

### PostgreSQL

* Good, because ACID compliance is built-in and rock-solid
* Good, because team has SQL expertise and can be productive immediately
* Good, because excellent support for complex queries with joins
* Good, because JSONB provides NoSQL-like flexibility when needed
* Good, because mature ecosystem with many tools and integrations
* Bad, because horizontal scaling is more complex than some alternatives
* Bad, because may need additional caching layer sooner for read-heavy workloads
* Bad, because write performance can degrade with very high concurrency without careful tuning

### MongoDB

* Good, because horizontal scaling (sharding) is built-in and easier
* Good, because schema flexibility with document model
* Good, because very fast for simple key-value reads
* Bad, because lack of ACID guarantees across documents requires complex application logic
* Bad, because limited team experience means slower initial development
* Bad, because joins are inefficient (requires application-side joins or denormalization)
* Bad, because less suitable for complex reporting queries we need

### DynamoDB (AWS)

* Good, because nearly unlimited horizontal scalability
* Good, because fully managed with minimal operational overhead
* Good, because predictable single-digit millisecond latency
* Bad, because no support for complex queries or joins (requires application-side logic)
* Bad, because eventual consistency model complicates financial transactions
* Bad, because steep learning curve for team unfamiliar with NoSQL
* Bad, because vendor lock-in to AWS
* Bad, because cost can become unpredictable at scale with fluctuating read/write units

### MySQL

* Good, because team has SQL expertise
* Good, because ACID compliance like PostgreSQL
* Good, because mature and widely adopted
* Good, because slightly better performance for simple queries
* Bad, because less advanced features compared to PostgreSQL (e.g., no JSONB, less powerful full-text search)
* Bad, because historically weaker support for complex queries and window functions
* Bad, because replication and high availability are more complex to set up
* Bad, because no compelling advantages over PostgreSQL for our use case

## Related Decisions

* [ADR-0003](0003-use-redis-for-caching.md) - Caching strategy (decided later based on PostgreSQL choice)
* [ADR-0012](0012-database-migration-strategy.md) - How to handle schema migrations

## References

* [PostgreSQL Performance at Instagram Scale](https://instagram-engineering.com/postgresql-at-instagram-a5cab26f1e6)
* [MongoDB vs PostgreSQL Performance Benchmarks](https://www.enterprisedb.com/blog/comparing-database-performance-postgresql-mongodb)
* [DynamoDB Best Practices](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/best-practices.html)
* [PCI-DSS Database Requirements](https://www.pcisecuritystandards.org/)
