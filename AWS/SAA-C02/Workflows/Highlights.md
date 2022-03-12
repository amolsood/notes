# Decoupling Workflows

## Points

- Never [Tight couple](./TightCoupling.png)
- Always Setup [Loose coupling](./LooseCoupling.png). Makes it highly available and scalable
- Services
  - SQS - Fully managed message queuing service, highly available, that enables to decouple and scale microservices, distributed systems and serverless systems
  - SNS - Fully managed messaging service for both application-to-application (A2A) and application-to-person (A2P) communication
  - API Gateway - Fully managed highly available and scalable service which makes easy to create, publish, maintain, monitor and secure APIs at and scale.

### Simple Queue Service (SQS)

- Messaging queue that allows asynchronous processing of work
- **Poll based messaging** - One resource will write a message to queue, and another resource will retrieve that message from queue
- Settings
  - Delivery Delay - Default 0 - Can be set to 15 minutes - If delay is set, the queue hides the message till the time, and reveal for consumer once delay is expired
  - Message Size - Maximum 256KB of text in any format
  - Encryption - Messages are encrypted in-transit by default, but you can add at-rest
  - Message Retention - Default 4 days - Can be set between **1 minute to 14 days**, after the time is expired, the messages are purged from the queue
  - Long vs Short Poll - Long Polling isn't default, but it should be (Connect and keep waiting)
  - Queue Depth (Not a setting, but a value) - Depth of SQS queue, as depth increases, it can be used to trigger an up-scaling event for fast process, and if depth decreased then it can be used trigger a down-scaling event.
  - [Visibility Timeout](./VisibilityTimeout.png) - (Default 30 seconds) - Once message is received by a consumer, the message stays in the queue, but is hidden to other consumers to avoid reprocessing. If the consumer fails to process, the message reappears in the queue for next consumer, else if successful it is purged from the queue
  - Dead-letter queue (just a standard/fifo queue)
    - Temporarily sideline messages to Dead-letter queue
    - To avoid retrying (until retention) of a message if it is failed to process by the consumer due to some issue. These problematic messages can be sidelined to a dead-letter queue (DLQ) after a specific number of retries (Maximum receives)
    - The received count carries over from main queue into dead letter queue and keeps increasing when polled (processed by consumer)
    - Important to setup a CloudWatch alarm to monitor DLQ queue depth, so it can alert when messages start to fail consumer process
    - DLQs can be created for SNS topics
  - FIFO Queues (First-in-first-out)
    - [SQS message ordering](./MessagesOrdering.png)
    - Standard queue can deliver the messages in unordered fashion and even **duplicate** **(At-least once message delivery)**. Best effort ordering is done, duplicate messages, and nearly unlimited transactions per second (read/write)
    - Fifo queue does Guaranteed ordering, no message duplication **(Exactly once message delivery)**, only 300 message transactions per second and has increased cost because of de-duplication and ordering which AWS has to do
    - Fifo queue name has to end with `.fifo`
    - Message deduplication ID - If value is set, then the same message can be received by the queue, but it won't received by the consumer within the deduplication interval (5 minute)
  - You cannot convert SQS queues after you create them (Standard to FIFO and vice-versa)

### Simple Notification Service (SNS)

- **Push-based Messaging** - It proactively delivers messages to endpoints subscribed to the topic. This can be used to alert system of a person
- Settings
  - Subscribers - What is subscribed to SNS topic - Who, Where, What does the message go out to. Kinesis Data Firehose, Lambda, Email, HTTP/HTTPS, SMS, SQS (Fan-out method)
  - Message size - Maximum 256KB of text in any format
  - DLQ Support - Messages those are failed to be deliver can be stored in DLQ
  - FIFO or Standard - **FIFO only supports SQS as a subscriber**
  - Encryption - Messages are encrypted in-transit by default, but you can add at-rest
  - Access Policy - A resource policy can be added to a topic, similar to S3. Who or What can publish the information into SNS topics

### API Gateway

- Fully managed service that allows to publish, create, maintain, monitor and secure the API. It allows to a put a safe front door the application
- Features
  - Security - Allows to easily protect endpoints by a attaching a web application firewall (WAF - Allows rate limiting, blocking specific of address or countries, stop SQL injection attacks, filtering malicious behavior)
  - Stop Abuse - Can easily implement DDoS (Distributed Denial-of-Service) protection and rate limit to curb abuse of endpoints
  - Ease of Use - Easily build out calls that can trigger other AWS services
  - Amazon API Gateway provides throttling at multiple levels including global and by a service call. Throttling limits can be set for standard rates and bursts. For example, API owners can set a rate limit of 1,000 requests per second for a specific method in their REST APIs, and also configure Amazon API Gateway to handle a burst of 2,000 requests per second for a few seconds.

## Exam Tips

- **Never tightly couple** such as EC2 instance directly communicating to another EC2 instance
- Always loosely couple
- Exam only focuses on loosely coupled system
- Internal and External - Every level of application should be loosely coupled
- One size doesn't fit all - there is no single solution to decouple
- Monitor - Setup CloudWatch alarm to monitor queue depth
- DLQs are not special, just standard/fifo queues and have same retention window (max 14 days)
- FIFO queues
  - Doesn't have same level of performance as of standard queues
  - Not the only way to order messages, it can be done via Standard, but using code smarts and developer's responsibility
  - Message Group ID - This ensures messages are processed one by one, but doesn't guarantee that the groups of messages will be processed in order
  - Costs more than Standard Queues
- SNS
  - Alerts/Notifications = SNS
  - Push based notifications
  - CloudWatch and SNS combination is used to alert about something happened
  - **Subscribers - What is subscribed to SNS topic - Who, Where, What does the message go out to. Kinesis Data Firehose, Lambda, Email, HTTP/HTTPS, SMS, SQS (Fan-out method)**. SES is only used for marketing emails. SES is distraction in exam
  - Amazon SNS defines a delivery policy for each delivery protocol. The delivery policy defines how Amazon SNS retries the delivery of messages when server-side errors occur (when the system that hosts the subscribed endpoint becomes unavailable). You can use a delivery policy and its four phases to define how Amazon SNS retries the delivery of messages to HTTP/S endpoints. With the exception of HTTP/S, you can't change Amazon SNS-defined delivery policies. Only HTTP/S supports custom policies.
- API Gateway
  - Secure and safe front door for an application
  - Preferred method to get API calls into application and AWS environment
  - Favor answers that include API Gateway over hardcoded access/secret keys
  - Stops DDoS using WAF
  - Supports API Versioning
  - No baking of credentials into the code
- Questions to ask
  - Is it synchronous or asynchronous workload?
  - What type of decoupling makes sense?
  - Does the order of messages matter?
  - What type of application load you will see?
- Tips
  - SQS can duplicate messages - This is only once in a while, so if it is happening consistently, then check for a visibility misconfigured timeout, or a developer is failing to make a Delete message API call
  - SQS queues are not bidirectional - Meaning, the sender cannot receive a response back. If it is required, then another queue has to be setup
  - Default settings
  - Messages can only live 14 days in SQS queue
  - Proactive notifications = SNS - Push, email, text, alerts; think SNS. CloudWatch alarms, can be used to fan-out messages
  - CloudWatch💝SNS - SNS is always best to choose for an alert triggered by a CloudWatch alarm

### Samples
