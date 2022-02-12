# [Serverless](./Serverless.png) Architecture

## Points

- Ease of use - Leave the management behind, there is not much to do besides bringing code, rest of it is handled by AWS
- Event Based - Serverless compute resources can be brought online based on events triggered
- Billing Model - 'Pay as you go'. Only pay for provisioned resources and the length of runtime
- Lambda - Allows to code, build function and ready
- Fargate - Let's run containers, no servers, no patching

### Lambda

- Serverless compute service that lets run code without managing the underlying servers/hardware
- Building a function
  - Runtime - The environment the code will run in. Java, JavaScript, etc
  - Permissions - If function needs to make an AWS API call then, then IAM roles are required to be attached
  - Networking - These can be defined in a VPC, subnet, and security groups
  - Resources - Defining the available amount of memory will allocate the CPU and RAM the code gets
  - Trigger - Defining the trigger will kick lambda off if an event occurs
- Lambda runs for maximum 15 minutes, with a maximum RAM of 10GB
- Lambda can run inside or outside a VPC

### [Containers](./Containers.png)

- Standard unit of software that packages code and all its dependencies, so the application runs quickly and reliably from one computing environment to another
- Terms
  - Dockerfile - Document contains all the commands and instructions that will be used to build an image
  - Images - Immutable file that contains the code and libraries, dependencies and configuration files need to run the application
  - Registry - Stores docker images for distribution. They can be both private and public
  - Container - A running copy of the image that has been created

### [ECS & EKS](./ECS&EKS.png)

- ECS - Elastic Container Service
- ECS runs containers on EC2 instances
- Allows management of containers at scale
- ECS can manage 1, 10, hundreds or thousands of containers. It places the containers and keep them online
- ELB integration - Containers are appropriately registered with load balancers as they come online and go offline
- Role integration - Containers can have individual roles attached to them
- Easy to use - Extremely easy to setup and scale to handle any workload
- Kubernetes is open source container management and orchestration platform, originally built by Google
  - Open source alternative
  - Can be used On-premise and in the cloud
- EKS - Elastic Kubernetes Service

### Fargate

- Run containers without servers (EC2)
- Serverless compute engine for containers that works with both ECS and EKS
- Linux only workloads/feature
  - No OS access
  - Pay based on resources allocated and time ran
  - Short-running tasks
  - Isolated environments
- [EC2 vs Fargate](EC2vsFargate.png)

### Amazon EventBridge (formerly CloudWatch events)

- It is a serverless event bus
- Allows to pass events from source to an endpoint
- Creating rules
  - Define Pattern - Do you want to the rule to be invoked based on event happening or want it to be scheduled
  - Event Bus - Is it going to be AWS-based event, a custom event or a partner
  - Target - What happens when this event kicks off

## Exam Tips

- Focus on answers that move away from un-managed architecture like EC2
- Better to select answers that uses lambda/containers over traditional operating system
- Lambda runs for maximum 15 minutes, with a maximum RAM of 10GB
- One of the most common ways the questions you are going to see Lambda used is to **add features to AWS**
- ECS and containers go hand in hand on the exam
- Only exception, if question asks for an open-source solution, Kubernetes or on-premise container management solution, choose EKS
- Generally, favor using AWS-designed services over the third-party
- Anytime open-source or Kubernetes is seen, choose EKS
- Fargate is a serverless compute option
- ECS or EKS is a requirement. Fargate doesn't work by itself
- Fargate is more expensive but easy to use
- Fargate is for containers and applications that need to run longer. Lambda excels at short and simpler functions
- Fargate
  - When workloads are consistent
  - Allows docker use access the organization and a greater level of control by developers
  - No time limit
- Lambda
  - Great for unpredictable or inconsistent workloads
  - Perfect for applications that can be expressed as single function
  - Time limit of 15 minutes
- Lambda loves roles - Whenever it is mentioned about credentials/permissions and lambda, ensure role is attached to the function
- Lambda triggers - S3, SQS, SNS, Kinesis, EventBridge are common triggers
- Lambda Limitations - Functions should be short, can be allocated upto 10GB of RAM and 15 minutes of runtime. CPU scales up proportionate with RAM
- Any AWS API call can be a trigger to kick off an EventBridge rule. This is faster than trying to scrape through CloudTrail (focus on auditing)
- Open source/on-premise = Kubernetes - Consider EKS; container management solution that can run in AWS and on-premises
- Fargate doesn't work alone - In order to use Fargate, you must be using ECS or EKS
- Containers are flexible

### Samples
