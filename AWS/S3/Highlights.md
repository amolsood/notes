# S3

## Points

- S3 is global
- Object based Storage rather than file system or data blocks
  - Upload any type of files
  - Cannot be used to run DB or OS
- Unlimited Storage
- Upto 5TB file size
- S3 stores files in buckets
- Buckets are globally universal (Universal Namespace)
- URL - https://{{bucket_name}}.s3.{{region}}.amazonaws.com/{{object.exe}}
- Data is spread across multiple devices, as it is highly available (99.95% - 99.99% based on S3 tier)
- Data is durable (99.99999999% (9 decimals))
- Key-Value store. Key - Object.exe, Value - Data of Object.exe
- VersionID - Used to store multiple version of same object
- Characteristics
  - Tiered Storage
  - Lifecycle Management
  - Versioning
- Security
  - Server Side Encryption
  - Access Control Lists (Can be attached to individual objects)
  - Bucket Policies (Bucket Wide JSON Policies)
- Strong Read-After-Write Consistency

### Storage Classes

- Standard (S3 Standard) (>=3AZ) (Default)
  - High Availability and Durability
  - Data stored redundantly in multiple devices
  - Stored at-least in 3 availability zones (AZ)
  - Designed for Frequent Access
  - Use Cases - Websites, Content Distribution, Gaming Applications, Big Data Analytics etc
- Standard-Infrequent Access (S3 Standard IA) (>=3AZ)
  - Rapid access to data but less frequently
  - Pay per-GB storage price and pay per-GB retrieval fee
  - Use Cases - Long term storage, backups, as a data store for disaster recovery
- One zone-Infrequent Access (S3 One Zone-IA) (=1AZ)
  - Similar to Standard IA but stored in only one AZ
  - Costs 20% less than regular S3 Standard IA
  - Use Cases - Non critical data (AZ can lose data in case of disasters etc), long lived and infrequently accessed
- Glacier (>=3AZ)
  - Cheap Storage and very infrequent access to data
  - Used for long term data archiving
  - Pay for every access
  - Default Retrieval Time - 1 minute to 12 hours
  - Use Cases - Historical Data (Accessed few times a year)
- Glacier Deep Archive (>=3AZ)
  - Cheap Storage and very infrequent access to data
  - Used for rarely accessed data
  - Pay for every access
  - Default Retrieval Time - 12 hours
  - Use Cases - Financial Records for regulatory purposes (Accessed 1-2 times a year)
- Intelligent Tiering (>=3AZ)
  - Moves data automatically to most cost effective tier
  - Uses ML to automate, based on object access
  - Allows to optimize cost
  - Monthly Fee - $0.0025 per 1000 objects
- Costs (Descending)
  - Standard - Highest cost
  - Standard Intelligent - Cost optimized for unknown access patterns
  - Standard-IA - Retrieval Fee
  - One Zone-IA - Retrieval Fee
  - Glacier - Retrieval Fee
  - Glacier Deep Archive - Retrieval Fee

### Versioning

- Works as a backup tool
- All versions are stored for an object
- Can be integrated with LifeCycle Rules
- Cannot be disabled once enabled, only suspended
- Supports MFA (Protects objects from accidental deletion)
- The bucket policy does not apply to older versions of objects (Even public)
- Delete action on a version deletes that specific version of the object which cannot be restored (hard delete)
- Delete action on the top level versioned object just adds a Delete marker (Basically creates a delete version of the object) (soft delete)
- To Restore a deleted object, the delete marker itself can be deleted

## Exam Tips

- S3 is global
- Object based Storage rather than file system or data blocks
  - Upload any type of files
  - Cannot be used to run DB or OS
- Buckets are globally universal (Universal Namespace)
- URL - https://{{bucket_name}}.s3.{{region}}.amazonaws.com/{{object.exe}}
- Unlimited Storage
- Upto 5TB file size
- Static Content - Use S3
- Automatic Scaling
- Key-Value store - Key - Object.exe, Value - Data of Object.exe
- VersionID - Used to store multiple version of same object
- Metadata - Data about data
- Characteristics
  - Tiered Storage
  - Lifecycle Management
  - Versioning
- Security
  - Server Side Encryption
  - Access Control Lists (Can be attached to individual objects)
  - Bucket Policies (Bucket Wide JSON Policies)
- Buckets are private by default (Include all objects within)
- Object ACLs - Control permissions on individual objects
- Bucket Policies - Control permission on entire bucket (Bucket Wide JSON Policies)
- HTTP 200 status code on successful upload via CLI or API

### Sample Bucket Policy (To allow make objects public in the BUCKET_NAME bucket)

  ```json
  {
    "Version": "2012-10-17", // Version of policy language syntax rules. Possible values - 2012-10-17, and 2008-10-17 (default). 2012-10-17 supports policy variables (${aws:username})
    "Statement": [
      {
        "Sid": "PublicReadGetObject", // Optional identifier, unique for all statements in current JSON policy
        "Effect": "Allow",
        "Principal": "*", // Accounts or users who are allowed to access the resource. Inverse - NotPrincipal
        "Action": [ // Inverse - NotAction
          "s3:GetObject"  // Actions to be permitted
        ],
        "Resource": [ // Inverse - NotResource
          "arn:aws:s3:::BUCKET_NAME/*" // Bucket ARN
        ]
      }
    ]
  }
  ```
