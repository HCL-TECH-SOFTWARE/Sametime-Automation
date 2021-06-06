# How to copy files from Windows to Linux

- Start Command window (terminal) on a Windows desktop
- Check if you can connect to the Admin Workstation (running on Linux)

  `ssh ansible@192.168.10.139`
  Close the session after successful login

  `exit`
- Download the ZIP file to your Windows desktop.
- Copy files from Windows desktop to Linux server via scp command:

  `scp Sametime-Automation-main.zip ansible@192.168.10.139:/home/ansible`

**Note:** If you connected from this Windows desktop to other virtual machines in the past, there is a chance that you already connected to a server with the same IP. That server was then decommissioned, and now a new server got the same IP address. Yet SSH fingerprint for the old server is still stored in your local file `C:\Users\User\\.ssh\known_hosts`. And now, if you try to connect to the new server, you see this warning message:
  ```
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
    Someone could be eavesdropping on you right now (man-in-the-middle attack)!
    It is also possible that a host key has just been changed.
    The fingerprint for the ECDSA key sent by the remote host is
    SHA256:ZNMV+RD2nIMNtm+nu93rvAABS9K1qWzSotYRsvlHVX0.
    Please contact your system administrator.
    Add correct host key in C:\\Users\\User/.ssh/known_hosts to get rid of this message.
    Offending ECDSA key in C:\\Users\\User/.ssh/known_hosts:1
    ECDSA host key for 192.168.10.139 has changed and you have requested strict checking.
    Host key verification failed.
  ```
  The solution in this situation is to delete the entry for the old server for your known_hosts file. Do this with this command:

  `ssh-keygen -R 192.168.10.139`

  The result should look like this:
  ```
    # Host 192.168.10.140 found: line 1
    C:\Users\User/.ssh/known_hosts updated.
    Original contents retained as C:\Users\User/.ssh/known_hosts.old
  ```
  Now you can try the command again.
  After you approve the new server fingerprint and type password for an ansible user, you should log into your Linux server successfully.
  ```
    The authenticity of host '192.168.10.140 (192.168.10.140)' can't be established.
    ECDSA key fingerprint is SHA256:ZNMV+RD2nIMNtm+nu93rvAABS9K1qWzSotYRsvlHVX0.
    Are you sure you want to continue connecting (yes/no)? yes
    Warning: Permanently added '192.168.10.140' (ECDSA) to the list of known hosts.
    ansible@192.168.10.140's password:
    Last login: Wed Mar 17 15:14:02 2021 from 192.168.10.1
  ```
