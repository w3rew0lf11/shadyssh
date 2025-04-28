# shadyssh - Windows OpenSSH Server Setup and Admin Access Script

**shadyssh** is a batch script toolset for enabling OpenSSH Server, configuring the Administrator account, and controlling firewall access on a Windows system. It includes a main script to set everything up and a secondary script to disable and clean up the changes.

---

## Included Files

- `shadyssh.bat` – Enables OpenSSH Server, configures sshd, enables and hides Administrator account, opens firewall ports.
- `stopshadyssh.bat` – Reverses all changes made by shadyssh.bat.

---

## Purpose

shadyssh simplifies the process of setting up a secure remote shell via OpenSSH on Windows. It is useful for developers, system administrators, and testers who need quick SSH access to a Windows machine.

---

## What shadyssh.bat Does

1. Requests Administrator privileges.
2. Enables the default Windows `Administrator` account.
3. Sets a password for the Administrator account (`test` by default).
4. Installs OpenSSH.Server if it's not already installed.
5. Configures the `sshd` service to start automatically.
6. Starts the `sshd` service.
7. Enables necessary firewall rules (`SMB-In` and `NB-Session-In`).
8. Hides the Administrator account from the login screen.

---

## What Stopshadyssh.bat Does

1. Requests Administrator privileges.
2. Stops `sshd` and `ssh-agent` services.
3. Disables the `Administrator` account.
4. Removes the registry entry that hides the Administrator account.
5. Disables the previously enabled firewall rules.

---

## Usage
Just put it in thumbdrive then sneak and plugin into system run it and leave then you have access to the system. No need to drop it to the  victims system run it in when the file is inside your thumbdrive. 🤣 just kidding.... 

I don't encourage to use it such way. use it leaglly with permision and run the `stopshadyssh.bat` after testing to revert all settings back to normal.

### Setup

Run `shadyssh.bat`

---
> 📌 **Note:**  
> When file is ran it runs in hidden terminal so user cannot suspect
> This script is designed to work **only on Windows systems**.  
> Please do not run it on Linux or MacOS.
> You can elevate the power of the script by either converting it into exe ad adding more invisibility when script runs.
---
