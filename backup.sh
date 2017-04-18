#!/bin/bash
####################################
#
# Backup to Ya.Disk script.
#
####################################


# What to backup.
FILES_TO_BACKUP="/var/www/$SITENAME"
DATE=$(date +%m_%d_%y_%H_%m_%s)

# Where to backup to.
DEST_TO_STORE_BACKUP="/mnt/yandex.disk.$SITENAME/backup"

# Create archive filename.
ARCHIVE_NAME=$SITENAME-$DATE.tgz

# Remove old
# Long listing of files in $dest to check file sizes.
echo "Remove old backups older than '$DAYS_TO_KEEP' "
find $DEST_TO_STORE_BACKUP/site/* -type f -mmin +$DAYS_TO_KEEP |xargs rm -f
find $DEST_TO_STORE_BACKUP/sql/*  -type f -mmin +$DAYS_TO_KEEP |xargs rm -f


echo "Backing up $FILES_TO_BACKUP to $DEST_TO_STORE_BACKUP/site/$ARCHIVE_NAME"
# Backup the files using tar.
tar czf $DEST_TO_STORE_BACKUP/site/$ARCHIVE_NAME $FILES_TO_BACKUP

# Dump DB via mysqldump
mysqldump -p$MYSQL_PASSWORD -u$MYSQL_USER $MYSQL_DATABASE > $DEST_TO_STORE_BACKUP/sql/mysql-$ARCHIVE_NAME.sql
