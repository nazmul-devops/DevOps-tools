# Commonly Used Linux Commands

Here are some of the most commonly used Linux commands for DevOps Engineers:

## Volume Making Commands

```
To partition a Linux Ubuntu EC2 EBS volume after it has been added, you can follow these steps:

1. Connect to your EC2 instance using SSH.

2. List the available block devices on your instance by running the command:
   ```
   lsblk
   ```

   This will show you the existing block devices and their partitions.

3. Identify the EBS volume you want to partition. It will typically be named like `/dev/xvdf`.

4. Run the command `sudo fdisk /dev/xvdf` to start the partitioning tool for the chosen volume.

5. Inside the `fdisk` tool, type `n` to create a new partition.

6. Choose the partition type:
   - If you want to create a primary partition, type `p`.
   - If you want to create an extended partition, type `e`.

7. Specify the partition number, starting from 1, and press Enter.

8. Specify the starting and ending sectors for the partition.
   - Press Enter to select the default values to use the entire disk for a single partition.
   - If you want to create multiple partitions, specify the desired sizes and sectors.

9. Once you have finished creating partitions, type `w` to write the changes and exit `fdisk`.

10. After exiting `fdisk`, run `lsblk` again to verify that the new partitions have been created.

11. Format the newly created partition(s) with the desired file system. For example, to format a partition as ext4, you can use the command:
    ```
    sudo mkfs.ext4 /dev/xvdf1
    ```

    Replace `/dev/xvdf1` with the actual partition device name you created.

12. Create a mount point directory for the new partition:
    ```
    sudo mkdir /mnt/new_partition
    ```

13. Mount the partition to the mount point:
    ```
    sudo mount /dev/xvdf1 /mnt/new_partition
    ```

    Replace `/dev/xvdf1` with the actual partition device name.

14. You can now use the partition by accessing the `/mnt/new_partition` directory.

Remember to modify the device names (`/dev/xvdf`, `/dev/xvdf1`, etc.) based on your specific configuration. Additionally, ensure that you have backups of any important data before making any 
modifications to disk partitions.

```

## Navigation Commands

- `cd`: Change the current working directory.


- `ls`: List the contents of a directory.


- `pwd`: Print the current working directory.


- `mkdir`: Create a new directory.


- `rmdir`: Remove a directory.


## File Commands

- `touch`: Create a new empty file.


- `cat`: Display the contents of a file.


- `nano`: Edit a file.


- `cp`: Copy a file.


- `mv`: Move or rename a file.


- `rm`: Remove a file.


## Process Management Commands

- `ps`: Display information about running processes.


- `top`: Display real-time information about system processes.


- `kill`: Send a signal to a process to terminate it.


## System Information Commands

- `uname`: Display system information.


- `uptime`: Display how long the system has been running.


- `free`: Display information about available memory.


## Network Commands

- `ping`: Check if a network host is reachable.


- `nslookup`: Lookup the IP address for a domain name.


- `netstat`: Display active network connections.


- `ifconfig`: Display network interface configuration.


## System Administration Commands

- `sudo`: Run a command with administrative privileges.


- `chmod`: Change the permissions of a file or directory.


- `chown`: Change the owner of a file or directory.


- `useradd`: Create a new user.


- `userdel`: Delete a user.


- `userdel`: Delete a user.



