# Arch-Setup-For-MBP-11-2


Instructions on how I Dual-Booted Arch-Linux on an old (Late 2013 or version 11,2) Macbook pro.

Disk: Partition 1-EFI, 4-Swap, 5-Arch
WM: BSPWM


### Step 1 - Get Ready to Run It

---

Select EFI Boot upon power up

Add in boot command with 'e' for Arch-ISO boot.

Add in boot option 'nomodeset'.

Boot into ArchISO

```console
root@root-~$ curl -JLO https://raw.github.com/zac-j-harris/dev/Arch-Setup-For-MBP-11-2
```

### Step 2 - Run It

---

```console
root@root-~$ ./run_me.sh
```

### Step 3 - Run Runnable_1.sh 

---

Sign in as yourself

```console
testusr@testhost-~$ ./runnable_1.sh
```

### Step 4 - Run Runnable_2.sh 

---

Sign in as yourself

```console
testusr@testhost-~$ ./runnable_2.sh
```


## Notes (Future Updates)

***

- No getty support
- No WiFi setup *yet*
- Basic desktop config
- No user input
- Noisy
