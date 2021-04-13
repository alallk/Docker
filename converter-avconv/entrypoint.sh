#!/bin/bash

# Loop through each file of the current directory

cd /files

find `pwd` -type f -name "*.mkv" | while read file; do
  echo "Now converting: $file"
  m_filename=`basename "$file"`
  m_dirname=`dirname "$file"`
  m_filename_wo_ext="${m_filename%.*}"

  if [ -n "${PRESERVE_DIR_STRUCTURE:+x}" ]; then
    output_dir="${m_dirname}"
  else
    output_dir="`pwd`"
  fi
  m_newfilename="${output_dir}/${m_filename_wo_ext}.mp4"
  avconv -loglevel error -y -i "$file" -c:v copy -c:a aac -strict experimental "$m_newfilename"
  if [ "$?" -eq 0 ]; then
    echo "Successfully processed: $file"
    if [ -n "${DELETE_ORIGINAL_ON_SUCCESS:+x}" ]; then
      /bin/rm -f "$file"
      echo "original file deleted successfully"
    else
      echo "original file preserved"
    fi
  fi

  # Pause for 3 seconds before moving on to the next file
  sleep 3

done
