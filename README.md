<div align="center">

<br>

![Lexiwin - Enhanced Windows Features](./res/Lexiwin-Header.png)

<br>

<br>

**Lexiwin is no longer maintained. This repository is for archival purpose.**

<br>

<br>

</div>

I have written Lexiwin in 2012 and 2013 and used it until 2016, when I stopped using Windows. It was publicly available and open source.

I recently learnt that it is still being used in 2021, so I created this repository to allow users to access the code again if they need to.

---

Lexiwin is an [AutoHotKey](https://www.autohotkey.com/) script that adds clipboard history, window management, quick launch, and a few other features, to Windows XP and later.

Please note that it has been made to work on a French AZERTY keyboard. However it's probably easily adaptable for other keyboard layouts.

You can read the [presentation](./doc/Presentation-Fr.md), the [user manual](./doc/UserManual-Fr.md) and the [quick reference sheet](./doc/QuickReference-Fr.md), all in French.

## Development setup

Install AutoHotKey and clone this repository.

## How to create Lexiwin portable

- Comment the first line and uncomment the second one, as shown bellow, in the file `src/Lexiwin-00-Main.ahk`:

```
; PrfDataPath := A_AppData . "\Lexiwin"   ; For installed version
PrfDataPath := A_ScriptDir              ; For portable version
```

- Place in a zip archive the files:

  - `Lexiwin.exe`, that you generate with AutoHotKey
  - `Lexiwin.ini`
  - `Lexiwin-DefaultConfiguration.ini`, just a copy of `Lexiwin.ini`
  - `LICENSE`
  - All the files in the `doc` folder

## How to create the installer of Lexiwin

- Uncomment the first line and comment the second one, as shown bellow, in the file `src/Lexiwin-00-Main.ahk`:

```
PrfDataPath := A_AppData . "\Lexiwin"   ; For installed version
; PrfDataPath := A_ScriptDir              ; For portable version
```

- Use [Inno Setup](https://jrsoftware.org/isinfo.php) and the file `Lexiwin.iss`.
