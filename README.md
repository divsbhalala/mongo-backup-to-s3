# Auto backup MongoDB to AWS S3
  - Download mongoDbBackup.sh	 file and set following configuration
  - Install *AWS CLI* using `sudo apt-get install awscli` OR follow link REF=http://docs.aws.amazon.com/cli/latest/userguide/installing.html
  - run following command from terminal to configure AWSCLI
   `aws  configure`
This will ask you enter AWSKEY, AWS_SECRET_KEY and AWS REGION
- To check AWS is propar conigure or on run `aws s3 ls` 
this will list all AWS S3 buckets  of configured A/C

## Set Script Variable according to your AWS S3 configuration
1. Your mongoDB host url/IP 
`HOST=MONGO_DB_HOST`
2. Database(Collection) name that you want to take a backuo
  `HOST=MONGO_DB_HOST`
3. AWS bucket name where you want to store data 
  `BUCKET=AWS_BUCKET_NAME`
4. Prefix name for ZIP(Compress) file 
  `PREFIX=ZIP_FILE_PRIFIX`
5. Current username of system 
  `USER=ubuntu`
6. Set Cronjob for tacking ragular backup of DB to AWS
    `00 00 * * * PATH_OF_YOUR_SHELL_SCRIPT `
