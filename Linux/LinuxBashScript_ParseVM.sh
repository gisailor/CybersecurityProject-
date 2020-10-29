    ```bash
    #!/bin/bash
[#!/bin/bash
#Scripts using Linux tools to  parse information about the VM.
#
#Print system memory to ~/backups/freemem/free_mem.txt 
free -h > ~/backups/freemem/free_mem.txt
#
#Pring disk usage and save to ~/backups/diskuse/disk_usage.txt
du -ahc ~/ > ~/backups/diskuse/disk_usage.txt
#
#list allopen files and save to ~/backups/openlist/open_list.txt
lsof > ~/backups/openlist/open_list.txt
#
#Print file system disk space statistics adn save to ~/backups/freedis/free_disk.txt 
cat /proc/meminfo > ~/backups/freedisk/free_disk.txt
