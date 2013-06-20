#!/bin/bash
#set -x
#http://stackoverflow.com/questions/3900496/using-shell-script-to-insert-data-into-remote-mysql-database
#mysql --host=randomhost --user=randomuser --password=randompass randomdb << EOF
#insert into table (field1,field2,field3) values('http://www.site.com/$hash','$file','$size');
#EOF

#mysql --host=localhost --user=bashscriptuser --password=bashscriptuserpass bashscript << EOF
#insert into FileList (Path,Filename,MD5) values('/path/to/myfile/something.txt','something.txt','d443e98a91461d31edb4a7069e7eb168');
#EOF
STARTPATH="/tmp/testing"

#for file in $(find $STARTPATH -type f)
find $STARTPATH -iname "*" -type f | while read file
	do 
		FILEPATH=`ls -la "$file" | awk '{ print '%s\n' *|nl }'`
		FILESIZE=`ls -la $file | awk '{ print $5 }'`
		MODIFIEDON=`ls -lat --time-style="+%Y-%m-%d %H:%M:%S" $file | awk '{ print $6" "$7 }'`
		LASTACCESS=`ls -lau --time-style="+%Y-%m-%d %H:%M:%S" $file | awk '{ print $6" "$7 }'`
		SCANDATE=`date '+%F %T'`
		MD5SUM=`/usr/bin/md5sum $file | awk '{ print $1 }' && touch -a --date="$LASTACCESS" $file`
		echo "file: $file"
		echo "Last Modified: 	$MODIFIEDON"
		echo "Last Accessed: 	$LASTACCESS"
		echo "File Path: 	$FILEPATH"
		echo "MD5: 		$MD5SUM"
		echo "Scan Date:	$SCANDATE"
		echo "Filesize:		$FILESIZE"
#mysql --host=localhost --user=bashscriptuser --password=bashscriptuserpass bashscript << EOF
#insert into FileList (Path,Size,ModifiedDate,AccessDate,ScannedDate,MD5) values('$FILEPATH','$FILESIZE','$MODIFIEDON','$LASTACCESS','$SCANDATE','$MD5SUM');
#EOF
sleep 20	
done
#set +x
