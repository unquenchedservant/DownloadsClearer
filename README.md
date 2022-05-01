# DownloadsClearer

## How to use
Download install.sh from the release page
in a terminal, do 

```chmod +x install.sh && ./install.sh```

Once it's installed the command is 

```dlClear ```

Use the following flags
```
    -i Minutes (1-59)
    -h Hours (1-24)
    -d Days (1-7)
    -m Months (1-12)
    -y Years (1-infinity)
    -p Permanent (permanently delete downloads folder contents)
        If not permanent, files are moved to ~/.local/share/Trash/files/
```

Note: try to only set things 1 at a time. Otherwise, the script will automatically 0 everything out up to the highest option.

Example: 

To clear downloads permanently ever day:
```dlClear -d 1 -p```
