# My Setup

## ⚠ Backup Warning

**Before proceeding, make sure to back up your important files!**  
If your configuration files exist, this script may **modify or delete** them..  
Always have a **recovery plan** before making changes.

### 🔥 Files That May Be Removed or Replaced 
The following files **could be deleted or replaced**, so ensure you have a backup (WINDOWS Devices):
- `C:\Users\YourUsername\.config\`
- `C:\Users\YourUsername\.config\powershell`
- `C:\Users\YourUsername\AppData\nvim\*`
- `$PROFILE`
- `$PROFILE.CurrentUserCurrentHost`

and for **Linux:**
- `~/.vimrc`
- `~/.zshrc`
- some **python packages** will installed (if you installed them so **upgraded**)


**💡 Tip:** To understand how this script works, examine the code. The primary file responsible for modifying files is **`install.ps1`** or **`install.sh`**, so be sure to check the source.

# Setup

1. Download a **Nerd Font** from [here](https://www.nerdfonts.com/font-downloads) (if on windows)

2. Install **Windows-Terminal** from Microsoft app store.(if on windows)

3. Install **Winget**. (if on windows)

4. Clone The Proj : 
    ```bash
    git clone https://github.com/wukalt/MySetup.git
    ```
5. Change Directory : 
    ```bash
    cd MySetup
    ```

6. Run Installer : 
    ```bash
    ./install.ps1     # for Windows
    bash install.sh   # for Linux 
    ```


## 🙌 Thanks To

- **FreeCodeCamp.org** for  vim config file 
    
    link: [vimrc configuration guide customize your vim](https://www.freecodecamp.org/news/vimrc-configuration-guide-customize-your-vim-editor)


- **Scott Hanselman** for oh-my-posh config file 

    link: [my ultimate powershell prompt with oh-my-posh](https://www.hanselman.com/blog/my-ultimate-powershell-prompt-with-oh-my-posh-and-the-windows-terminal)