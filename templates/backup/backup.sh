#!/bin/sh
# Source is a source file or directory to encrypt
SOURCE=$1
# Target dir is a directory to place encrypted file
TARGET_DIR=$2
# Target filename is a target file name without any extensions
TARGET_FILENAME=$3
# Target file is a full path to target unencrypted (yet) file
TARGET_FILE=${TARGET_DIR}/${TARGET_FILENAME}.tar
# Temp file is a filename to make diff against unencrypted filename
TEMP_FILE=/tmp/${TARGET_FILENAME}.tar

if [ -z ${ENCRYPTION_KEY} ]; then
  echo 'Encryption key is empty, exiting'
  exit 1
fi

move_and_encrypt () {
  # If we call this function it means we already know that target tar archive
  # does not exist or differ from fresh-created tar archive, so we replace old
  # one.
  mv -f ${TEMP_FILE} ${TARGET_FILE}
  # All we need for now is just to encrypt new archive
  echo "Re-encrypt new archive"
  /usr/bin/openssl aes-256-cbc -k "$ENCRYPTION_KEY" -md sha256 \
    -in ${TARGET_FILE} -out ${TARGET_FILE}.enc
  # Unencrypt that file with next command
  #/usr/bin/openssl aes-256-cbc -k "$ENCRYPTION_KEY" -md sha256 \
  #  -in ${TARGET_FILE}.enc -out ${TARGET_FILE} -d
  echo "Encryption done"
}

data_rclone () {
  echo "Start copying encrypted private documents to Gdrive"
  /usr/bin/rclone copy ${TARGET_FILE}.enc gdrive:backups/
}

# So, first we create given source to temporary file
/usr/bin/tar cf ${TEMP_FILE} ${SOURCE} 2>/dev/null
# Then we check if we already such a filename in target place
if [ -f ${TARGET_FILE} ]; then
  echo "${TARGET_FILE} found, will try to catch if it should be updated"
  # If we already had that backup tool running then we have old archive. We
  # diff old archive against new one to understand if they differ.
  diff ${TARGET_FILE} ${TEMP_FILE}
  # And if they really differ, just replace old archive with new one and
  # encrypt it.
  if [ "$?" != "0" ]; then
    echo "New archive differs from old one, replace old with new"
    move_and_encrypt
    data_rclone
  else
    # Otherwise just continue
    echo "Source was not changed from last backup, so no actions needed"
  fi
else
  # If old archive not found, just move new one to target place and encrypt it.
  echo "Old archive not found, move new one to its place"
  move_and_encrypt
  data_rclone
fi

# Additionally copy Keepass database to the google drive. Stop blaming me, it's
# my personal backup script, I don't use it for anything but for backup my
# personal files.
/usr/bin/rclone copy /home/sbog/Documents/private_db_new.kdbx gdrive:backups/
