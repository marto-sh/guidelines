# 8. Use REST for All Microservice Communication

Date: 2025-06-20

## Status

Superseded by [ADR-0023](0023-use-grpc-for-internal-apis.md)

Superseded on: 2026-01-20

Reason: Performance requirements changed as system scaled; needed more efficient serialization for internal service-to-service communication

## Context

We are building a microservices architecture with multiple services needing to communicate. We need a standard communication protocol that is well-understood, debuggable, and has good tooling support.

Our services are polyglot (Python, Node.js, Go) and we want to ensure any service can communicate with any other service without complex protocol translation.

Key requirements at the time:
- Easy to debug (human-readable format)
- Broad language support
- Simple to implement and maintain
- Works well with existing HTTP infrastructure (load balancers, API gateways)
- Team familiarity (most developers know REST)

## Decision Drivers

* **Developer experience** - Easy to understand, debug, and troubleshoot
* **Language compatibility** - Works across our polyglot environment
* **Tooling maturity** - Established tools for testing, documentation, monitoring
* **Learning curve** - Team already familiar with REST
* **Infrastructure compatibility** - Works with existing HTTP load balancers

## Considered Options

* REST with JSON
* gRPC with Protocol Buffers
* GraphQL
* Message queues (RabbitMQ/Kafka)

## Decision

We will use **REST APIs with JSON** for all microservice-to-microservice communication.

All services will expose REST endpoints using standard HTTP verbs (GET, POST, PUT, DELETE) and return JSON responses. We will follow RESTful principles for resource naming and status codes.

### Rationale

REST with JSON best fits our current needs:
1. **Familiarity** - Entire team knows REST; no training needed
2. **Debugging** - JSON is human-readable; easy to debug with curl/Postman
3. **Infrastructure** - Works seamlessly with our existing HTTP infrastructure
4. **Tooling** - Excellent support for OpenAPI/Swagger documentation
5. **Flexibility** - Easy to evolve APIs without breaking clients

## Consequences

### Positive

* Zero learning curve for the team
* Easy to debug with standard HTTP tools
* Excellent documentation options (Swagger/OpenAPI)
* Works with existing load balancers and API gateways
* Client libraries available in all languages we use

### Negative

* JSON serialization is less efficient than binary formats (Protocol Buffers)
* No built-in schema enforcement (unlike gRPC)
* Network overhead higher than binary protocols
* No native streaming support (would need WebSockets or Server-Sent Events)
* Looser typing means runtime errors more likely

### Neutral

* Need to establish API versioning strategy
* Will use OpenAPI for API documentation
* Need to decide on authentication/authorization approach (OAuth2/JWT)

## Validation

* API response times remain under 100ms for 95% of requests
* No significant issues with JSON parsing or serialization
* Developer satisfaction with debugging experience
* Cross-service integration is straightforward

**Evaluation timeline:** Review after 6 months in production

## Pros and Cons of the Options

### REST with JSON

* Good, because team is already familiar
* Good, because human-readable format aids debugging
* Good, because works with existing HTTP infrastructure
* Good, because excellent tooling and documentation support
* Bad, because less efficient than binary protocols
* Bad, because no schema enforcement at protocol level

### gRPC with Protocol Buffers

* Good, because highly efficient binary serialization
* Good, because built-in schema enforcement
* Good, because supports streaming
* Bad, because steeper learning curve
* Bad, because harder to debug (binary format)
* Bad, because requires HTTP/2 (infrastructure changes)

### GraphQL

* Good, because flexible queries (clients get exactly what they need)
* Good, because strong typing with schema
* Bad, because significant complexity for simple use cases
* Bad, because primarily designed for client-server, not service-to-service
* Bad, because team has no GraphQL experience

### Message Queues (RabbitMQ/Kafka)

* Good, because excellent for async communication
* Good, because natural decoupling of services
* Bad, because adds operational complexity
* Bad, because not suitable for synchronous request/response
* Bad, because different communication paradigm (pub/sub vs request/response)

## Related Decisions

* [ADR-0009](0009-api-versioning-strategy.md) - How we version REST APIs
* [ADR-0023](0023-use-grpc-for-internal-apis.md) - Supersedes this decision

## References

* [REST API Best Practices](https://restfulapi.net/)
* [OpenAPI Specification](https://swagger.io/specification/)
* [Microservices Communication Patterns](https://microservices.io/patterns/communication-style/messaging.html)

---

## Why This ADR Was Superseded

This decision was appropriate for our initial scale and team maturity. However, as the system grew to handle 10x the traffic, REST's overhead became a bottleneck. The team also gained experience and was ready to adopt more efficient protocols.

The key lesson: **What's right at one scale may not be right at another**. This ADR served its purpose well during our growth phase.
