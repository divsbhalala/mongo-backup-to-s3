#!/bin/sh

# Make sure to:
# 1) Name this file `backup.sh` and place it in /home/ubuntu
# 2) Run sudo apt-get install awscli to install the AWSCLI
# 3) Run aws configure (enter s3-authorized IAM user and specify region)
# 4) Fill in DB host + name
# 5) Create S3 bucket for the backups and fill it in below (set a lifecycle rule to expire files older than X days in the bucket)
# 6) Run chmod +x backup.sh
# 7) Test it out via ./backup.sh
# 8) Set up a daily backup at midnight via `crontab -e`:
#    0 0 * * * /home/ubuntu/backup.sh > /home/ubuntu/backup.log

# DB host (secondary preferred as to avoid impacting primary performance)
HOST=MONGO_DB_HOST

# DB name
DBNAME=DB_NAME

# S3 bucket name
BUCKET=AWS_BUCKET_NAME

#zip file prefix
PREFIX=ZIP_FILE_PRIFIX

# Linux user account
USER=ubuntu

# Current time
TIME=`/bin/date +%d-%m-%Y-%T`

# Backup directory
DEST=dbBackUp

# Tar file of backup directory
TAR=$DEST/$PREFIX-$TIME.tar

# Create backup dir (-p to avoid warning if already exists)
sudo mkdir -p $DEST

# Log
echo "Backing up $HOST/$DBNAME to s3://$BUCKET/ on $TIME";

# Dump from mongodb host into backup directory
sudo mongodump -h $HOST -d $DBNAME -o $DEST

# Create tar of backup directory
sudo /bin/tar cvf $TAR -C $DEST .

# Upload tar to s3
aws s3 cp $TAR s3://$BUCKET/

# Remove tar file locally
sudo rm -rf $TAR
# Remove backup directory
sudo rm -rf $DEST

# All 
echo "Backup available at https://s3.amazonaws.com/$BUCKET/$TIME.tar"

