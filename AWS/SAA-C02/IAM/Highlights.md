# IAM

## Points

- On global level
- Root account should have been secured using MFA
- No permission are granted initially when a new user is created
- Pre-defined Policies based on Job function (Type filter) (Database managers, Administrators)
- AWS Access and Secret keys are shown once, Download CSV
- Setup password rotation/policies
- IAM Federation - To combine existing Active directory (Windows) system with AWS
- SAML as standard for IAM Federation (Active Directory)

## Exam Tips

- MFA for root account
- Create Admin Group and assign appropriate permissions and never sign in back using root account, instead use IAM
- Policy documents use JSON (Sample below)

  ```json
  {
    "Version": "2012-10-17",
    "Statement": {
      "Effect": "Allow", //
      // "Action": []/"*", // Specific Actions
      "Action": "*", // All Actions
      "Resource": "*", // All resources
    }
  }

- IAM is universal (Global, not region specific)
- No permission are granted initially when a new user is created
- AWS Security Token Service (AWS STS) is the service that you can use to create and provide trusted users with temporary security credentials that can control access to your AWS resources. https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp.html
- AWS doesn't allow users to add an IAM role to an IAM group
- You can authenticate to your DB instance using **AWS Identity and Access Management (IAM) database authentication**. IAM database authentication works with MySQL and PostgreSQL. With this authentication method, you don't need to use a password when you connect to a DB instance. Instead, you use an authentication token.

## [CheatSheet](https://tutorialsdojo.com/aws-identity-and-access-management-iam/#validate-your-knowledge)
