# S3

## Points

- S3 is global, but buckets are created in a specific region, but bucket names are in universal namespace
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
  - Default Retrieval Time - 1 minute to 12 hours (3-5 hours as per Amazon [FAQ](https://aws.amazon.com/s3/glacier/faqs/))
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
- Delete marker's version is set to `some_id` if versioning is enabled, file can be restored anytime by deleting the delete marker
- To Restore a deleted object, the delete marker itself can be deleted
- If versioning is suspended for a bucket, a DELETE request: [Read Here](https://docs.aws.amazon.com/AmazonS3/latest/userguide/DeletingObjectsfromVersioningSuspendedBuckets.html)
  - Can only remove an object whose version ID is null.
  - Doesn't remove anything if there isn't a null version of the object in the bucket.
  - Inserts a delete marker into the bucket.
  - Delete marker's version is set to `null` if versioning is suspended, file can be restored anytime by deleting the delete marker
  - Even in a versioning-suspended bucket, the bucket owner can permanently delete a specified version. Only the bucket owner can delete a specified object version.

### Lifecycle management

- Automates moving of objects between storage tiers for cost optimization
- Can be used in conjunction with Versioning
- Can be applied to current versions or previous versions
- Minimum storage duration in days before transitioning (from creation of object)
  - Standard-IA - 30 days
  - Intelligent-Tiering - 30 days
  - One Zone-IA - 30 days
  - Glacier - 90 days
  - Glacier Deep Archive - 180 days
- Actions Available
  - Transition current versions of object
  - Transition previous versions of object
  - Expire current versions
  - Permanently delete previous versions
- You cannot enable Delete expired object delete markers if you enable Expire current versions of objects.
- [Supported Transitions](https://docs.aws.amazon.com/AmazonS3/latest/userguide/lifecycle-transition-general-considerations.html)
  - Encrypted objects remain encrypted throughout the storage class transition process.
  - Objects that are stored in the S3 Glacier or S3 Glacier Deep Archive storage classes are not available in real time.
  - Objects that are stored in the S3 Glacier storage class can only be transitioned to the S3 Glacier Deep Archive storage class.
  - The transition of objects to the S3 Glacier Deep Archive storage class can go only one way.
  - The objects that are stored in the S3 Glacier and S3 Glacier Deep Archive storage classes are visible and available only through Amazon S3. They are not available through the separate Amazon S3 Glacier service.

### Object Lock

- Use WORM model (Write Once Read Many). Prevents the object from deletion or modification from given time or indefinitely
- Can be applied on individual object or across the bucket
- Can be used for extra layer of protection for objects
- Governance Mode
  - Cannot overwrite or delete object versions or alter lock settings unless user has special permissions to do
- Compliance Mode
  - Cannot be overwritten or deleted by any user and retention mode and period cannot be changed, even by root account user
- Retention Period - Protects the object from changes for a duration. S3 stores the timestamp in object's metadata which indicates retention period expiry
- After retention period expires, the object can be changed unless there is **Legal Hold** on object version
- Legal Hold - It can be freely placed and objects cannot be modified until user with permission **s3:PutObjectLegalhold** doesn't remove it
- Glacier Vault Lock - WORM model to Glacier objects
- Object Lock works only in versioned buckets. Enabling Object Lock automatically enables Bucket Versioning.
- Object lock cannot be enabled after bucket is created

### Encryption

- Encryption in Transit
  - SSL/TLS (Port 443)
  - HTTPS
- Encryption at Rest (Server-Side Encryption)
  - *SSE-S3* - S3 managed keys, uses AES 256-bit encryption
  - *SSE-KMS* - AWS Key Management Service-managed keys
  - *SSE-C* - Customer Provided Keys
- Encryption at Rest (Client-Side Encryption)
  - Client responsible to encrypt before upload
- Can be enforced
  - Using Console
  - Using Bucket Policy
- **x-amz-server-side-encryption** - Request Header to be included for SSE
  - x-amz-server-side-encryption: AES256
  - x-amz-server-side-encryption: aws:kms

### S3 Performance

- Prefixes
  - bucketname/folder1/subfolder1/file.jpg
  - bucketname/folder2/subfolder1/file.jpg
  - bucketname/folder3/file.jpg
  - bucketname/folder4/subfolder4/file.jpg
- 100-200ms latency
- 3500 PUT/COPY/POST/DELETE requests and 5500 GET/HEAD requests per second, per prefix
- The more the prefixes, the better the performance
- Uploads - Multipart uploads are
  - recommended for files over 100MB
  - required for files over 5GB
- Downloads - S3 Byte Range Fetches
  - Parallel downloads by specifying byte-range (partial amount of files)

### Limitations

- KMS limits while SSE
  - Uploading/downloading will count towards KMS Quota
  - Quota cannot be increased
  - Region specific, its either 5500, 10000, 30000 requests per second

### Replication (Cross region replication)

- Objects can be replicated from one bucket to another (in same or different region)
- The source and destination buckets must have versioning enabled
- Existing objects are NOT automatically replicated when replication is turned on
- Deleting individual versions or delete markers are not replicated by default, but can be turned on

## Exam Tips

- S3 is global
- Object based Storage rather than file system or data blocks
  - Upload any type of files
  - Cannot be used to run DB or OS
- Buckets are globally universal (Universal Namespace)
- URL - https://{{bucket_name}}.s3.{{region}}.amazonaws.com/{{object.exe}}
- Unlimited Storage
- Upto 5TB file size
- Static Content - Use S3 (Websites)
- Automatic Scaling
- Key-Value store - Key - Object.exe, Value - Data of Object.exe
- VersionID - Used to store multiple version of same object
- Metadata - Data about data (content-type, last-modified, etc)
- Characteristics
  - Tiered Storage
  - Lifecycle Management
  - Versioning
- Security
  - Server Side Encryption
  - Access Control Lists (Can be attached to individual objects)
  - Bucket Policies (Bucket Wide JSON Policies)
- Buckets are private by default (Include all objects within)
- Need to allow public access to bucket and its objects to make the bucket public
- Object ACLs - Control permissions on individual objects
- Bucket Policies - Control permission on entire bucket (Bucket Wide JSON Policies)
- HTTP 200 status code on successful upload via CLI or API
- All objects by default are private. Only the object owner has permission to access these objects. However, the object owner can optionally share objects with others by creating a presigned URL, using their own security credentials, to grant time-limited permission to download the objects. When you create a presigned URL for your object, you must provide your security credentials, specify a bucket name, an object key, specify the HTTP method (GET to download the object) and expiration date and time. The presigned URLs are valid only for the specified duration. Anyone who receives the presigned URL can then access the object.
- S3 Transfer Acceleration facilitates quicker uploads by using edge locations to copy data into Amazon S3. S3 Transfer Acceleration does not solve the problem of the file size limitation (5 GB) for a single PUT operation.
- The Amazon S3 notification feature enables you to receive notifications when certain events happen in your bucket. To enable notifications, you must first add a notification configuration that identifies the events you want Amazon S3 to publish and the destinations where you want Amazon S3 to send the notifications. An S3 notification can be set up to notify you when objects are restored from Glacier to S3.

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

## [CheatSheet](https://tutorialsdojo.com/amazon-s3)
