# Decoupling Workflows

## Points

- Never [Tight couple](./TightCoupling.png)
- Always Setup [Loose coupling](./LooseCoupling.png). Makes it highly available and scalable
- Services
  - SQS - Fully managed message queuing service, highly available, that enables to decouple and scale microservices, distributed systems and serverless systems
  - SNS - Fully managed messaging service for both application-to-application (A2A) and application-to-person (A2P) communication
  - API Gateway - Fully managed highly available and scalable service which makes easy to create, publish, maintain, monitor and secure APIs at and scale.

## Exam Tips

- **Never tightly couple** such as EC2 instance directly communicating to another EC2 instance
- Always loosely couple
- Exam only focuses on loosely coupled system
- Internal and External - Every level of application should be loosely coupled
- One size doesn't fit all - there is no single solution to decouple

### Samples
