#Custom `git-prompt.sh` with Accompanying `.bashrc`

The `master` branch contains an initial stab at a more customizable Git prompt than what is currently provided with 
[Git for Windows](https://git-for-windows.github.io/).

You can begin to use these two files without any changes and the Git prompt should appear as it does with the standard
Git for Windows git prompt.

##Requirements

1. When using Mintty terminal as your terminal, you must place `git-prompt.sh` into the `%Program_Install_Dir%\mingw64\share\git\completion` folder. On Windows, by default, this is `%ProgramFiles%\Git\mingw64\share\git\completion` for x64. For x86, replace `%ProgramFiles%` with `%ProgramFiles(x86)%`.
2. When using Mintty terminal as your terminal, you must place `.bashrc` in `%USERPROFILE%'

##Notes

1. The available "glyphs" that you choose for various parts of the Git string prompt depend on the font you've chosen to use for your terminal window. For example, the font Consolas has a rather limited set of Unicode characters to choose from, while another font such as DejaVu Sans Mono has many Unicode glyphs to choose from.
2. The modifications made to `git-prompt.sh` may not be compatable with Z-Shell (zsh). Leave me an issue tracker if you find that to be the case. Better yet, submit a pull request.

##Planned, Future Enhancements

1. Create a "build system" that would allow for creating a "theme" that would then generate the required environment variable values and example code which could be placed in your `.bashrc`.
2. Create a set of pre-defined "themes".
3. Create further customization opportunities for the bash prompt, in general, in addition to the customizations provided for the git prompt.
4. Look into customizing other git scripts colors (e.g. git status).
    * I find the default red and green colors a bit too dark and saturated for my liking, which is what spawned these customizations to begin with.
5. Look into contributing these customizations to Git for Windows. Is there any interest in providing this level of customizability in Git for Windows proper (or perhaps even git itself)??
    * I'm open to comments on this. If there's little to no interest, then I'll just keep these customizations here.