#Shell Prompt Customization Scripts

<!-- Unfortunately, GitHub doesn't support t Pagedown def_list module, nor the TOC module. So there will be a lot of HTML in this markdown document. :(
[TOC]
-->
These scripts aim to provide the user the ability to more easily and flexibly change their shell (bash and zsh) and git repository prompts.
> **NOTE**  
> ZSH is not currently supported, but support is planned to be included.

##Using the Shell Prompt Customization Scripts

To use the Shell Prompt customization scripts, simply copy `sh-prompt.sh` and/or `git-prompt.sh` files to your home directory. On linux, this is typcially accessed by using the alias `~`. On Windows&reg;, your home directory is typically located at `C:\Windows\Users\<your username>`. You can quickly go to the location of your home directory by typing `%USERPROFILE%` into the location bar in Windows Explorer.

When putting these files into your home directory, you can optionally rename the scripts to `.sh-prompt.sh` and `.git-prompt.sh`.

Finally, an example `.bashrc` file is provided in this repository. You can use it as is (by copying it also to your home directory), or take the bits and pieces that you need to customize your shell prompt, adding them to your existing `.bashrc` file. The example `.bashrc` file contains many environment variables that are commented out. This example script shows you all the available environment variables you can set in your `.bashrc` to affect the display of your shell prompt. The value shown for each commented out variable is the default value for the variable used by the scripts when the variable is undeclared and/or empty or null. See below or read the comments in the individual `sh-prompt.sh` and `git-prompt.sh` scripts for more information.

The version of `git-prompt.sh` that is supplied with this repository has been modified to allow you to customize the display of git repository information in your shell prompt in more ways than the original `git-prompt.sh` script allows.

##Customizing Your Shell Prompt
This section will outline how you can use `sh-prompt.sh` to customize your shell prompt. This section won't discuss customizing the git repository portion of the shell prompt (that will be covered under **Customzing Your Git Format String** below).

The following sections define the environment variables you can set in your `.bashrc` file to customize your shell prompt. Examples of various customizations will be shown afterwards.

As stated in **Using the Shell Prompt Customization Scripts**, you must copy `sh-prompt.sh` to your home directory (either with the same name, or renamed as `.sh-prompt.sh`) and be sourced from your `.bashrc` file (which is typically in the same location) in order for the environment variables discussed below to have any effect on your shell prompt.

###Shell Prompt Textual Format String Variables
The environment variables listed below can be used to customize the text that is displayed for each portion of a typical shell prompt. You should refrain from including any color information in these format strings (unless you want or need more complex colorization of portions of your shell prompt).

Just remember, the more text you display in your prompt, the slower it will be to display the prompt. This includes any color information you decide to include in the color format strings discussed in the following section.

<dl>
  <dt>SH_PS1_USERNAME</dt>
  <dd>
    <P>Sets the string to be used for the <i>username</i> portion of the prompt string.</p>
   <p>If this variable is not declared, or it's null or empty, then this defaults to the username placeholder token for the shell prompt. Otherwise, the username portion of the shell prompt will contain this text.</p>
    <blockquote>
      <p><b>NOTE</b></p>  
      <p>If the format string does not contain the username placeholder (<samp>\u</samp> for <i>bash</i>, for example), then the username of the current interactive user will not be displayed; however, any other text in this variable will still be displayed.</p>
    </blockquote>
    <p>If you don't want to display the username portion of the shell prompt, omit the <samp>%u</samp> format specifier when setting <samp>SH_PS1_FORMAT_STRING</samp>. See below for more details.</p>
  </dd>
  <dd>
      <p><b>EXAMPLE</b></p>
      <pre>SH_PS1_USERNAME="\n$(tput setaf 170)$MSYSTEM \u"</pre>
      <p>On a MINGW64 system (such as <a href="https://git-for-windows.github.io/">Git for Windows</a>, this results in MINGW64 being displayed in a light purple (when using a 256-color terminal) followed by a space, followed by the bash username of the current interactive user.</p>
  </dd>
  <dt>SH_PS1_USER_HOST_SEPARATOR</dt>
  <dd>
    <p>Sets the string to be used for separating the <i>username</i> from the <i>hostname</i> when displaying the shell prompt.</p>
    <p>If not declared, null, or empty, then this defaults to the '<samp>@</samp>' character. Otherwise, the value defined is used between the <i>username</i> and <i>hostname</i> portions of the shell prompt format string.</p>
    <p>If for whatever reason you want no separator between the <i>username</i> and <i>hostname</i> portions of the shell prompt, then omit the <samp>%z</samp> format specifier in <samp>SH_PS1_FORMAT_STRING<samp> instead. See below for more details.</p>
</dd>
<dt>SH_PS1_HOSTNAME</dt>
<dd>
  <p>Sets the string to be used for the <i>hostname</i> portion of the prompt string.</p>
  <p>If not declared, null, or empty, then this defaults to the hostname placeholder token for the shell prompt. Otherwise, the <i>hostname</i> portion of the shell prompt will contain this text.</p>
  <blockquote>
    <p><b>NOTE</b></p>
    <p>If the format string does not contain the hostname placeholder token (<samp>\h</samp> for <i>bash</i>, for example), then the <i>hostname</i> will not be displayed; however, any other text in this variable will still be displayed.</p>
  </blockquote>
  <p>If you don't want to display the <i>hostname</i> portion of the shell prompt,  omit the <samp>%h</samp> format specifier in <samp>SH_PS1_FORMAT_STRING</samp>.  See below for more details.
  </p>
</dd>
<dt>SH_PS1_PWD</dt>
<dd>
  <p>Sets the string to be used for the <i>present working directory</i> (PWD) portion of the prompt string.</p>
  <p>If not declared, null, or empty, then this defaults to the PWD placeholder token for the shell prompt. Otherwise, the PWD portion of the shell prompt will contain this text.</p>
  <blockquote>
    <p><b>NOTE</b></p>
    <p> If the format string does not contain the PWD placeholder token (<samp>\w</samp> for <i>bash</i>, for example), then the PWD will not be displayed; however, any other text in this variable will still be displayed.</p>
  </blockquote>
  <p>If you don't want to display the PWD portion of the shell prompt,  omit the <samp>%w</samp> format specifier in <samp>SH_PS1_FORMAT_STRING</samp>.  See below for more details.
  <p>
</dd>
<dt>SH_PS1_PROMPT</dt>
<dd>
  <p>Sets the string to be used for the <i>prompt</i> portion of the prompt string (i.e. the <samp>$</samp> or <samp>#</samp> that is displayed indicating the shell is ready for user input).</p>
  <p>If not declared, null, or empty, then this variable defaults to <samp>\n\$_</samp> (where <samp>_</samp> is a space) for the shell prompt (i.e. a <samp>$</samp> on a new line followed by a space).</p>
  <p>Any other text can be used for this variable. But as you may have noticed, something must be displayed. There is no way to not have some sort of prompt be displayed (without altering <samp>sh-prompt.sh</samp> itself).</p>
</dd>
<dt>SH_PS1_FORMAT_STRING</dt>
<dd>
  <p>Defines the tokens that define what portions of the bash prompt should be displayed, and in what order. The <samp>SH_PS1_PROMPT</samp> is always appended to this string.</p>
  <p>If this variable is undeclared, null, or empty, it defaults to <samp>"%u%z%h%w%v"</samp>. By default, this results in the following prompt:<pre>

		username@host pwd [git_repository_info]
		$
</pre></p>
  <p>If you are not inside a git repository (or <samp>__git_ps1</samp> is not defined), then the <samp>[git_repository_info]</samp> is not displayed.</p>
  <p>The meanings of the format specifier tokens are listed below:</p>
  <table summary="SH_PS1_FORMAT_STRING format token descriptions.">
	  <thead>
	    <tr>
	      <th scope="col">Format Token</th>
	      <th scope="col">Description</th>
	    </tr>
	  </thead>
	  <tbody>
	    <tr>
	      <td align="center"><samp>%u</samp></td>
	      <td>Gets relpaced with <samp>SH_PS1_USERNAME</samp></td>
	    </tr>
	    <tr>
	      <td align="center"><samp>%z</samp></td>
	      <td>Gets replaced with <samp>SH_PS1_USER_HOST_SEPARATOR</samp></td>
	    </tr>
	    <tr>
	      <td align="center"><samp>%h</samp></td>
	      <td>Gets replaced with <samp>SH_PS1_HOSTNAME</samp></td>
	    </tr>
	    <tr>
	      <td align="center"><samp>%w</samp></td>
	      <td>Gets replaced with <samp>SH_PS1_PWD</samp></td>
	    </tr>
	    <tr>
	      <td align="center"><samp>%v</samp></td>
	      <td>If <samp>__git_ps1</samp> is defined, and you are in a directory that houses a <i>git</i> repository, then this token is indicates where the <i>git</i> repository information will be displayed in your shell prompt.</td>
	    </tr>
	  </tbody>
	</table>
    <p>Some notes regarding the use of this variable:</p>
    <ol>
      <li>You can place these tokens in any order.</li>
      <li>All whitespace between tokens is stripped out.</li>
      <li>This variable should only contain these tokens and no other text. Any other text included in this variable may result in unpredictable and unsupported behavior.</li>
      <li>Any spacing and formatting should occur within the individual format string variables (e.g. <samp>SH_PS1_*</samp> variables discussed above).</li>
      <li>Unless you need (or want) complex coloring (e.g. you want to format your username using the colors of the rainbow&mdash;yes, this is pointless, but someone out there has done this), you should place all color formatting in the appropriate environment variables discussed in the next section below.</li>
    </ol>
  </dd>
</dl>

###Shell Prompt Color Format String Variables
The environment variables listed below can be used to customize the colorization of various parts of your shell prompt. You should refrain from including any textual information in these format strings (unless you want or need more complex customization of portions of your shell prompt). Any text other than _command-substitution_ calls to `tput` (or ANSI/VT-100 color escape sequences) may result in unpredictable behavior of this script and is stricty unsupported.

Just remember, the more text you display in your prompt, the slower it will be to display the prompt. This includes any color information you decide to include in these color format strings.

SH_PS1_DONT_COLORIZE_PROMPT
:   If set to `1`, the shell prompt will not be colorized (unless any textual format strings discussed in the section above contain any color information themselves).
:   If this variable is not declared or has any value other than `1` (including null), then the bash prompt will be colorized.

SH_PS1_USERNAME_COLOR
:   Sets the color the _username_ portion of the shell prompt.
:   If this variable is not declared and `SH_PS1_DONT_COLORIZE_PROMPT` is not set to `1`, the default color is green, `$(tput setaf 2)`. Otherwise, if this variable is null or empty, it results in `$(tput sgr0)`. Otherwise the value of the variable is used in the shell prompt.

SH_PS1_USER_HOST_SEPARATOR_COLOR
:   Sets the color for the text which separates the username/hostname portions of the shell prompt.
:   If this variable is not declared and `SH_PS1_DONT_COLORIZE_PROMPT` is not set to `1`, the default color is green, `$(tput setaf 2`). Otherwise, f this variable is null or empty, it results in `$(tput sgr0)`.  Otherwise the value of the variable is used in the shell prompt.

SH_PS1_HOSTNAME_COLOR
:   Sets the color for the _hostname_ portion of the shell prompt.
:   If this variable is not declared and `SH_PS1_DONT_COLORIZE_PROMPT` is not set to `1`, the default color is green, `$(tput setaf 2)`. Otherwise, if this variable is null or empty, it results in `$(tput sgr0)`. Otherwise the value of the variable is used in the shell prompt.

SH_PS1_PWD_COLOR
:   Sets the color for the _present working directory_ (PWD) portion of the shell prompt.
:   If this variable is not declared and `SH_PS1_DONT_COLORIZE_PROMPT` is not set to `1`, the default color is dim yellow, `$(tput setaf 3)` (or brown, as I think it was called for 8/16-color mode). Otherwise, if this variable is null or empty, it results in `$(tput sgr0)`. Otherwise the value of the variable is used in the shell prompt.

SH_PROMPT_COLOR
:   Set the color for the _prompt_ portion of the shell prompt (e.g. typically the `$` or `#` that appears indicating the shell is ready and  awaiting user input).
:   If this variable is not declared, is null, or empty, then the prompt string's resulting color is `$(tput sgr0)`. Otherwise the value of the variable is used in the shell prompt.

> **WARNING**
> There's nothing stopping you from placing other text in the variables discussed above, but they're intended only to contain only color information for the various pieces of the prompt string. 
> You can experiment with other values other than purely color information, but you do so at your own risk. This is unsupported behavior.

##Customzing Your Git Format String
`git-prompt.sh` only affects the display of your shell prompt when you are currently in a directory which contains a _git_ repository.

The customized version of `git-prompt.sh` included in this repository allows for enhanced customization of your git repository format string. In the sections that follow, the standard environment variables will be discussed (those that natively come with the `git-prompt.sh` script as supplied by git) and the variables that this customized version of `git-prompt.sh` allow to be set.

As stated above in **Using the Shell Prompt Customization Scripts**, you must copy `git-prompt.sh` to your home directory (either with the same name, or renamed as `.git-prompt.sh`) in order for the environment variables discussed below to have any effect on your shell prompt.

###The Standard `git-prompt.sh` Environment Variables
The following list describes the effects of the standard `git-prompt.sh` environment variables on the display of git repository information in the shell prompt. The core functionality of these environment variables has been preserved by the extended version of this script. The default values of all environment variables used in this extended `git-prompt.sh` script result in the standard, out-of-the-box display of git repository information (which is usually just the currently checked out branch name of the git repository).

Many of the effects of the standard `git-prompt.sh` environment variables can be changed or extended through the use and setting of additional environment variables supported by this extended `git-prompt.sh` script.

GIT_PS1_SHOWDIRTYSTATE
:   If this environment variable is set to a non-empty value, unstaged and staged changes will be shown next to the current branch name for the git repository.
:   Unstaged files are denoted with a red `*` and staged changes are denoted with a green `+`. These characters can be replaced using the extended environment variables discussed in the sections that follow. 
:   You can configure the display of this information per-repository with the `bash.showDirtyState` git repository configuration variable. This git configuration repository variable defaults to `true` once this environment variable is set. To change a particular repository to not show this information after setting this environment variable, run the command:

        git config bash.showDirtyState=false
inside the git repository.

GIT_PS1_SHOWUNTRACKEDFILES
:   If this environment variable to a non-empty value, a character representing that there are untracked files in the repository  will be displayed next to the current branch name for the git repository.
:   Untracked files are denoted with a red `%` sign. This character can be replaced using the extended environment variables discussed in the sections that follow.
:   You can configure the display of this information per-repository with the `bash.showUntrackedFiles` git configuration variable. This git repository configuration variable defaults to `true` once this environment variable is set. To not show this information for a repository after setting this environment variable, run the command:

        git config bash.showUntrackedFiles=false
inside the git repository.

GIT_PS1_SHOWSTASHSTATE
:   If this environment variable is set to a non-empty value, a character representing whether or not any stashes exist in the repository will be displayed next to the current branch name for the git repository.
:   If there are any stashes present in the current repository, this will be denoted with a blue `$`. This character can be replaced using the extended environment variables discussed in the sections that follow.

GIT_PS1_SHOWUPSTREAM
:   If you would like to see the difference between `HEAD` and its upstream, set this environment variable to `auto`.  A `<` indicates you are behind, `>` indicates you are ahead, `<>` indicates you have diverged, and `=` indicates that there is no difference between your copy of the branch and the upstream branch. You can further control behaviour of displaying upstream branch information by setting this environment variable to a space-separated list of values shown in the table below:
:   | Value | Description |
|:--------|:---------------------------------------------------------------------------------------------------------|
| verbose | Shows the number of commits your copy of the branch is ahead/behind (+/-) of the upstream branch |
| name    | If verbose is specified, then also show the upstream abbreviation name                         |
| legacy  | Don't use the '--count' option available in recent versions of `git-rev-list`                            |
| git     | Always compare `HEAD` to `@{upstream}` |
| svn     | Always compare `HEAD` to your SVN upstream |


:   By default, `__git_ps1` will compare `HEAD` to your SVN upstream if it can find one, or `@{upstream}` otherwise.  Once you have set this environment variable, you can override it on a per-repository basis by setting the git repository configuration variable `bash.showUpstream`. To change how a particular repository shows this information after setting this environment variable, run the command:

        git config bash.showUntrackedFiles="<space-separated list of values>"
inside the git repository.

GIT_PS1_STATESEPARATOR
:   You can change the separator between the branch name and the above state symbols by setting this environment variable. The default separator is `<SP>` (a space character).

GIT_PS1_DESCRIBE_STYLE
:   If you would like to see more information about the identity of commits checked out as a detached `HEAD`, set this environment variable to one of these values:
:   | Value      | Description                                           |
|:-----------|:------------------------------------------------------|
| `contains` | Displays a value relative to a newer annotated tag as the current branch name, for example, `(v1.6.3.2~35)` |
| `branch`   | Displays a value relative to newer tag or branch as the current branch name, for example, `(master~4)`    |
| `describe` | Displays a value relative to an older annotated tag as the current branch name, for example `(v1.6.3.1-13-gdd42c2f)` |
| default    | Displays the exactly matching tag as the current branch name. |

GIT_PS1_SHOWCOLORHINTS
:   If this environment variable is set to a non-empty value, `__git_ps1` displays colored repository branch state information. The colors are based on the colored output from the `git status -sb` command.
:   Colored output of dirty state information is only available when using the output from `__git_ps1` for setting `PROMPT_COMMAND` (in _bash_) or when using `precmd` (in _zsh_).
:   > **NOTE**
> ZSH is not supported at this time. Hopefully support will be added for this shell in the near future.

GIT_PS1_HIDE_IF_PWD_IGNORED
:   If you would like `__git_ps1` to do nothing in the case when the current directory is set up to be ignored by _git_ (via a repository `.gitignore` or global ignore file), then set this environment variable value to a non-empty value. 
: You can override the effects of this environment variable on a per-repository basis by setting the git repository configuration variable`bash.hideIfPwdIgnored` to `false` by running the command

        git config bash.hideIfPwdIgnored=false
from within the repository.

###New `git-prompt.sh` Environment Variables
The following list and description of environment variables have been added to this extended version of the `git-prompt.sh` script. The default values of all of these variables results in this extended `git-prompt.sh` script working in exactly the same manner as the standard `git-prompt.sh` script provided with distributions of _git_. These variables can be broken down into two main categories:

1. Information display format strings
2. Information display colorization

####Display Format Strings
The following list describes the available format string environment variables that will allow you to customize how git repository information is displayed via `__git_ps1`.

GIT_PS1_SHOWUPSTREAM_STYLE
:   This environment variable can be set to one of the following values (the **Verbose** column indicates whether or not `GIT_PS1_SHOWUPSTREAM` contains `verbose` as one of its values):
:  | Value       | Verbose | Behind                       | Ahead             | Diverged            | Equal |
|:------------|:--------:|:----------------------------:|:-----------------:|:-------------------:|:-----:|
| default        | no       | <samp>&lt;</samp>            | <samp>&gt;</samp> | <samp>&lt;&gt;</samp> | <samp>=</samp> |
| default        | yes      | <samp>u-{count}</samp> | <samp>u+{count}</samp> | <samp>u+{count}-{count}</samp> | <samp>u=</samp>   |
| arrow       | no       | <samp>&#x2193;</samp>        | <samp>&#x2191;</samp>| <samp>&#x2193;&#x2191;</samp>      | <samp>&#x2261;</samp> |
| arrow       | yes      | <samp>&#x2193;{count}</samp> | <samp>{count}&#x2191;</samp> | <samp>{count}&#x2193;&#x2191;{count}</samp> | <samp>&#x2261;</samp> |
| rlarrowhead | no | <samp>&#x02C2;</samp> | <samp>&#x02C3;</samp> | <samp>&#x02C2;&#x02C3;</samp> | <samp>&#x2261;</samp> |
| rlarrowhead | yes | <samp>&#x02C2;{count}</samp> | <samp>{count}&#x02C3;</samp> | <samp>{count}&#x02C2;&#x02C3;{count}</samp> | <samp>&#x2261;</samp> |
| udarrowhead | no | <samp>&#x02C5;</samp> | <samp>&#x02C4;</samp> | <samp>&#x02C5;&#x02C4;</samp> | <samp>&#x2261;</samp> |
| udarrowhead | yes | <samp>&#x02C5;{count}</samp> | <samp>{count}&#x02C4;</samp> | <samp>{count}&#x02C5;&#x02C4;{count}</samp> | <samp>&#x2261;</samp> |
| rltri | no | <samp>&#x25BC;</samp> | <samp>&#x25B2;</samp> | <samp>&#x25BC;&#x25B2;</samp> | <samp>&#x2261;</samp> |
| rltri | yes | <samp>{count}&#x25BC;</samp> | <samp>&#x25B2;{count}</samp> | <samp>{count}&#x25BC;&#x25B2;{count}</samp> | <samp>&#x2261;</samp> |
| udtri | no  | <samp>&#x25C4;</samp> | <samp>&#x25BA;</samp> | <samp>&#x25C4;&#x25BA;</samp> | <samp>&#x2261;</samp> |
| udtri | yes | <samp>{count}&#x25C4;</samp> | <samp>&#x25BA;{count}</samp> | <samp>{count}&#x25C4;&#x25BA;{count}</samp> | <samp>&#x2261;</samp> |
| custom | no | <samp>{_user defined_}</samp> | <samp>{_user defined_}</samp> | <samp>{behind_glyph}{ahead_glyph}</samp> | <samp>_user defined_</samp> |
| custom | yes | <samp>{count}{_user defined_}</samp> | <samp>{_user_defined_}{count}</samp> | <samp>{count}{behind_glyph}{ahead_glyph}{count}</samp> | <samp>{_user defined_}</samp> |

: If this environment variable is not declared, null, empty, or not one of the values defined in the table above, then the value defaults to `default` in the above table.
: > **NOTE**
> In order to use any of the values except <samp>none</samp> or <samp>custom</samp>, you must use a terminal which supports UTF-8 character enocding. Likewise, if you use Unicode characters for any of the four custom glyph environment variables, your terminal must support UTF-8 character encoding.

GIT_PS1_SHOWUPSTREAM_CUSTOM_AHEAD
GIT_PS1_SHOWUPSTREAM_CUSTOM_BEHIND
GIT_PS1_SHOWUPSTREAM_CUSTOM_DIVERGED
GIT_PS1_SHOWUPSTREAM_CUSTOM_UPTODATE
:   These  four variables allow you to set the marker to be displayed for each of the four states of a local repository branch as compared to its remote upstream branch.
:   > **NOTE**  
> There's nothing stopping you from including additional text or other information in any one of these variables. However, their main intent was to display a single glyph-like character. Using anything more than a single character to display information about the status of a branch compared to its upstream counterpart may cause unpredictable behavior and is unsupported.

GIT_PS1_SHOWUPSTREAM_SEPARATOR
:   If this variable is declared and set to a non-null, non-empty value, the value of this environment variable is used between the ahead/behind information displayed when `GIT_PS1_SHOWUPSTREAM` is set to a non-empty value. For example, if `GIT_PS1_SHOWUPSTREAM_SEPARATOR=|`, a diverged branch would display as `{count}<|>{count}`.

GIT_PS1_INITIALCOMMIT
:   When `GIT_PS1_SHOWDIRTYSTATE` is set to a non-empty value, this environment variable determines the text that is displayed for a branch which has no commits (i.e. the repository is new). The default text that is displayed if this variable is not declared is `#`.

GIT_PS1_STAGEDCHANGES
:   When `GIT_PS1_SHOWDIRTYSTATE` is set to a non-empty value, this environment variable determines the text that is displayed for a branch when that branch has staged changes that need to be committed. The default text that is displayed when there are staged changes in the local repository is `+`.

GIT_PS1_UNSTAGEDCHANGES
:   When `GIT_PS1_SHOWDIRTYSTATE` is set to a non-empty value, this environment variable determines the text that is displayed for a branch when that branch has unstaged changes that need to be staged. The default text that is displayed when there are unstaged changes in the local repository is `*`.

GIT_PS1_UNTRACKEDFILES
:   When `GIT_PS1_SHOWUNTRACKEDFILES` is set to a non-empty value, this environment variable determines the text that is displayed for a branch when that branch has untracked files. The default text that is displayed when untracked files exist in the local repository is `%`.

GIT_PS1_STASHSTATE
:   When `GIT_PS1_SHOWSTASHSTATE` is set to a non-empty value, this environment variable determines the text that is displayed for a repository when that repository has changes which have been stashed. The default text that is displayed when a repository has stashed changes is `$`.

####Color Format Strings
The following list describes the available color format string environment variables that will allow you to customize how git repository information is colored when displayed via `__git_ps1` as extended in this version of `git-prompt.sh`.

GIT_PS1_DETACHEDHEAD_COLOR
:   When `GIT_PS1_SHOWCOLORHINTS` is set to a non-empty value, a detached head will be displayed in the color specified by this environment variable. If this environment variable is undeclared, the default value of `$(tput setaf 1)` (red) is used.

GIT_PS1_OKBRANCH_COLOR
:   When `GIT_PS1_SHOWCOLORHINTS` is set to a non-empty value, a branch which is set to track a valid remote branch will be displayed in the color specified by this environment variable. If this environment variable is undeclared, the default value of `$(tput setaf 2)` (green) will be used.

GIT_PS1_INITIALCOMMIT_COLOR
:   When `GIT_PS1_SHOWDIRTYSTATE` and `GIT_PS1_SHOWCOLORHINTS` are set to a non-empty value, a repository which has no commits (i.e. a new repository) will display the value of `GIT_PS1_INITIALCOMMIT` next to the branch name using the color specified by this environment variable. If this environment variable is undeclared, the default value of `$(tput setaf 2)` (green) is used.

GIT_PS1_STAGEDCHANGES_COLOR
:   When `GIT_PS1_SHOWDIRTYSTATE` and `GIT_PS1_SHOWCOLORHINTS` are set to a non-empty value, a repository which has staged changes will display the value of `GIT_PS1_STAGEDCHANGES` next to the branch name using the color specified by this environment variable. If this environment variable is undeclared, the default value of `$(tput setaf 2)` (green) is used.

GIT_PS1_UNSTAGEDCHANGES_COLOR
:   When `GIT_PS1_SHOWDIRTYSTATE` and `GIT_PS1_SHOWCOLORHINTS` are set to a non-empty value, a repository which has unstaged changes will display the value of `GIT_PS1_UNSTAGEDCHANGES` next to the branch name using the color specified by this environment variable. If this environment variable is undeclared, the default value of `$(tput setaf 1)` (red) is used.

GIT_PS1_UNTRACKEDFILES_COLOR
:   When `GIT_PS1_SHOWUNTRACKEDFILES` and `GIT_PS1_SHOWCOLORHINTS` are set to a non-empty value, a repository which has untracked files will display the value of `GIT_PS1_UNTRACKEDFILES` next to the branch name using the color specified by this environment variable. If this environment variable is undeclared, the default value of `$(tput setaf 1)` (red) is used.

GIT_PS1_STASHSTATE_COLOR
:   When `GIT_PS1_SHOWSTASHSTATE` and `GIT_PS1_SHOWCOLORHINTS` are set to a non-empty value, a repository which has stashed changes will display the value of `GIT_PS1_STASHSTATE` next to the branch name using the color specified by this environment variable. If this environment variable is undeclared, the default value of `$(tput setaf 4)` (blue) is used.

##Examples of Shell and/or Git Prompt Customization
In the following sections, several examples of variable values will be shown and the resulting shell prompt output will be demonstrated.

> Written with [StackEdit](https://stackedit.io/).