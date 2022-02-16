# Automation

## Points

- Benefits
  - Saves time
  - Easier to prevent security incidents
  - Consistent results of an action every single time
- Services
  - CloudFormation - IAC - Infrastructure as Code
  - Elastic Beanstalk - Easy to use Drag and drop creator for AWS Architecture
  - Systems Manager

### CloudFormation

- CloudFormation is a declarative programming language.
- Supports JSON or YAML formatting
- Sections
  - InputParameters - Allows to set input variables at runtime
  - Mappings - Allows to put values for template to run
  - Resources - Resources which are going to be created when ran
- Hard coded values and resource IDs can be reason templates fail to create
- If template finds an error, CloudFormation rolls back to last known good state
- Just a set of API calls underneath. It makes the same API calls which we make manually, but faster, immutable and in automated way

### Elastic Beanstalk

- Is Amazon PaaS (Platform-as-a-service) tool. One stop for everything AWS related
- Automation - Lets to automate all the deployments
- Deployment - Handles the deployments. Just upload the code, test code in staging and then deploy to production
- Management - Handles building out the insides of EC2 instances
- Supports containers, Windows and Linux applications
- Great solution for simpler applications, not for complex, big applications
- Not serverless. Creates and manages a standard EC2 architecture

### Systems Manager

- Collections of tools to manage EC2 architecture and on-premises architecture
- Systems Manager agent has to be installed on the EC2 instance
- Features
  - Automation Documents - Can be used to control instances or other AWS resources
  - Run Command - Execute commands on hosts or the whole fleet
  - Patch Manager - Manages application versions
  - Parameter Store - Securely store secret values
  - Hybrid Activations - Control on-premises architecture using Systems manager
  - Session Manager - Remotely connect and interact with architecture
- Application of Parameter Store - Store variables which can be loaded at runtime, without keeping secret keys on GitHub or anywhere else

## Exam Tips

- Automate everything!
- Automation via CloudFormation is perfect for creating immutable architecture
- Systems Manager is rarely called by its name, it will be called by the features. E.g - Automation documents to fix S3 bucket permissions or using Session Manager to connect to an instance
- 4 questions to ask
  - Can you automate - Yes
  - What kind of automation works in given scenario
  - Is automation repeatable
  - Will this work cross-region or cross-account - No hard-coding of resources
- Immutable architecture is preferable - Stateless is better
- Mappings or Parameter store to store secrets or resources IDs and makes template more flexible
- Elastic Beanstalk is a one-stop IT shop for AWS things
- Automation documents are primary method to configure the inside of an EC2 instance

### Samples
