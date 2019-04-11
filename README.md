# Shell Prompt Customization Scripts

<!-- Unfortunately, GitHub doesn't support t Pagedown def_list module, nor the TOC module. So there will be a lot of HTML in this markdown document. :(
[TOC]
-->
These scripts aim to provide the user the ability to more easily and flexibly change their shell (bash and zsh) and git repository prompts.
> **NOTE**  
> <i><abbr title="Z-Shell">zsh</abbr></i> is not currently supported, but support is planned to be included.

## Using the Shell Prompt Customization Scripts

To use the Shell Prompt customization scripts, simply copy `sh-prompt.sh` and/or `git-prompt.sh` files to your home directory. On linux, this is typcially accessed by using the alias `~`. On Windows&reg;, your home directory is typically located at `C:\Windows\Users\<your username>`. You can quickly go to the location of your home directory by typing `%USERPROFILE%` into the location bar in Windows Explorer.

When putting these files into your home directory, you can optionally rename the scripts to `.sh-prompt.sh` and `.git-prompt.sh`.

Finally, an example `.bashrc` file is provided in this repository. You can use it as is (by copying it also to your home directory), or take the bits and pieces that you need to customize your shell prompt, adding them to your existing `.bashrc` file. The example `.bashrc` file contains many environment variables that are commented out. This example script shows you all the available environment variables you can set in your `.bashrc` to affect the display of your shell prompt. The value shown for each commented out variable is the default value for the variable used by the scripts when the variable is undeclared and/or empty or null. See below or read the comments in the individual `sh-prompt.sh` and `git-prompt.sh` scripts for more information.

The version of `git-prompt.sh` that is supplied with this repository has been modified to allow you to customize the display of git repository information in your shell prompt in more ways than the original `git-prompt.sh` script allows.

## Customizing Your Shell Prompt
This section will outline how you can use `sh-prompt.sh` to customize your shell prompt. This section won't discuss customizing the git repository portion of the shell prompt (that will be covered under **Customzing Your Git Format String** below).

The following sections define the environment variables you can set in your `.bashrc` file to customize your shell prompt. Examples of various customizations will be shown afterwards.

As stated in **Using the Shell Prompt Customization Scripts**, you must copy `sh-prompt.sh` to your home directory (either with the same name, or renamed as `.sh-prompt.sh`) and be sourced from your `.bashrc` file (which is typically in the same location) in order for the environment variables discussed below to have any effect on your shell prompt.

### Shell Prompt Textual Format String Variables
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
    <p>If you don't want to display the username portion of the shell prompt, omit the '<samp>u</samp>' format specifier when setting <samp>SH_PS1_FORMAT_STRING</samp>. See below for more details.</p>
  </dd>
  <dd>
      <p><b>EXAMPLE</b></p>
      <pre class="prettyprint"><code class="language-bash hljs">SH_PS1_USERNAME="\n$(tput setaf 170)$MSYSTEM \u"</code></pre>
      <p>On a MINGW64 system (such as <a href="https://git-for-windows.github.io/">Git for Windows</a>, this results in MINGW64 being displayed in a light purple (when using a 256-color terminal) followed by a space, followed by the bash username of the current interactive user.</p>
  </dd>
  <dt>SH_PS1_USER_HOST_SEPARATOR</dt>
  <dd>
    <p>Sets the string to be used for separating the <i>username</i> from the <i>hostname</i> when displaying the shell prompt.</p>
    <p>If not declared, null, or empty, then this defaults to the '<samp>@</samp>' character. Otherwise, the value defined is used between the <i>username</i> and <i>hostname</i> portions of the shell prompt format string.</p>
    <p>If for whatever reason you want no separator between the <i>username</i> and <i>hostname</i> portions of the shell prompt, then omit the '<samp>z</samp>' format specifier in <samp>SH_PS1_FORMAT_STRING<samp> instead. See below for more details.</p>
</dd>
<dt>SH_PS1_HOSTNAME</dt>
<dd>
  <p>Sets the string to be used for the <i>hostname</i> portion of the prompt string.</p>
  <p>If not declared, null, or empty, then this defaults to the hostname placeholder token for the shell prompt. Otherwise, the <i>hostname</i> portion of the shell prompt will contain this text.</p>
  <blockquote>
    <p><b>NOTE</b></p>
    <p>If the format string does not contain the hostname placeholder token (<samp>\h</samp> for <i>bash</i>, for example), then the <i>hostname</i> will not be displayed; however, any other text in this variable will still be displayed.</p>
  </blockquote>
  <p>If you don't want to display the <i>hostname</i> portion of the shell prompt,  omit the '<samp>h</samp>' format specifier in <samp>SH_PS1_FORMAT_STRING</samp>.  See below for more details.
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
  <p>If you don't want to display the PWD portion of the shell prompt,  omit the '<samp>w</samp>' format specifier in <samp>SH_PS1_FORMAT_STRING</samp>.  See below for more details.
  <p>
</dd>
<dt>SH_PS1_PROMPT</dt>
<dd>
  <p>Sets the string to be used for the <i>prompt</i> portion of the prompt string (i.e. the '<samp>$</samp>' or '<samp>#</samp>' that is displayed indicating the shell is ready for user input).</p>
  <p>If not declared, null, or empty, then this variable defaults to '<samp>\n\$&lt;SP&gt;</samp>' for the shell prompt (i.e. a '<samp>$</samp>' on a new line followed by a space).</p>
  <p>Any other text can be used for this variable. But as you may have noticed, something must be displayed. There is no way to not have some sort of prompt be displayed (without altering <samp>sh-prompt.sh</samp> itself).</p>
</dd>
<dt>SH_PS1_FORMAT_STRING</dt>
<dd>
  <p>Defines the tokens that define what portions of the bash prompt should be displayed, and in what order. The <samp>SH_PS1_PROMPT</samp> is always appended to this string.</p>
  <p>If this variable is undeclared, null, or empty, it defaults to <samp>"uzhwv"</samp>. By default, this results in the following prompt:</p>
  <pre>username@host pwd [git_repository_info]
$</pre>
  <p>If you are not inside a git repository (or <code>__git_ps1</code> is not defined), then the <samp>[git_repository_info]</samp> is not displayed.</p>
  <p>The meaning of each of the format specifier tokens is listed in the table below:</p>
  <table summary="SH_PS1_FORMAT_STRING format token descriptions.">
	  <thead>
	    <tr>
	      <th scope="col">Format Token</th>
	      <th scope="col">Description</th>
	    </tr>
	  </thead>
	  <tbody>
	    <tr>
	      <td align="center"><samp>u</samp></td>
	      <td>Gets relpaced with <samp>SH_PS1_USERNAME</samp></td>
	    </tr>
	    <tr>
	      <td align="center"><samp>z</samp></td>
	      <td>Gets replaced with <samp>SH_PS1_USER_HOST_SEPARATOR</samp></td>
	    </tr>
	    <tr>
	      <td align="center"><samp>h</samp></td>
	      <td>Gets replaced with <samp>SH_PS1_HOSTNAME</samp></td>
	    </tr>
	    <tr>
	      <td align="center"><samp>w</samp></td>
	      <td>Gets replaced with <samp>SH_PS1_PWD</samp></td>
	    </tr>
	    <tr>
	      <td align="center"><samp>v</samp></td>
	      <td>If <code>__git_ps1</code> is defined, and you are in a directory that houses a <i>git</i> repository, then this token is indicates where the <i>git</i> repository information will be displayed in your shell prompt.</td>
	    </tr>
	  </tbody>
	</table>
    <p>Some notes regarding the use of this variable:</p>
    <ol>
      <li>You can place these tokens in any order.</li>
      <li>This variable should only contain these tokens and no other text. Any other text included in this variable may result in unpredictable and unsupported behavior.</li>
      <li>Any spacing and formatting you require for your desired shell prompt should be defined through the individual format string variables (e.g. the <samp>SH_PS1_*</samp> variables) discussed above.</li>
    </ol>
  </dd>
</dl>

> **NOTE**  
> Unless you require or desire complex shell prompt colorization, you should place most color information for the various aspects of your prompt in the color format string variables discussed in the next section.
>  
> Remember, the more text you provide in the various pieces of your prompt (including any color information), the slower it will be to display your prompt.
> 
> Finally, remember, you should not place any other text in the <samp>SH_PS1_FORMAT_STRING</samp> variable except for the tokens that were listed in the table above. Any other text in this environment variable will most likely result in your prompt not working as expected, if at all.

###Shell Prompt Color Format String Variables
The environment variables listed below can be used to customize the colorization of various parts of your shell prompt. You should refrain from including any textual information in these format strings (unless you want or need more complex customization of portions of your shell prompt). Any text other than _command-substitution_ calls to `tput` (or ANSI/VT-100 color escape sequences) may result in unpredictable behavior of this script and is stricty unsupported.

Just remember, the more text you display in your prompt, the slower it will be to display the prompt. This includes any color information you decide to include in these color format strings.

<dl>
  <dt>SH_PS1_DONT_COLORIZE_PROMPT</dt>
  <dd>
    <p>If set to <samp>1</samp>, the shell prompt will not be colorized (unless any textual format strings discussed in the section above contain any color information themselves).</p>
    <p>If this variable is not declared or has any value other than <samp>1</samp> (including null), then the bash prompt will be colorized.</p>
  </dd>
  <dt>SH_PS1_USERNAME_COLOR</dt>
  <dd>
    <p>Sets the color the <i>username</i> portion of the shell prompt.</p>
    <p>If this variable is not declared and <samp>SH_PS1_DONT_COLORIZE_PROMPT</samp> is not set to <samp>1</samp>, the default color is green, <code>&#x24;(tput setaf 2)</code>. Otherwise, if this variable is null or empty, it results in <code>$(tput sgr0)</code>. Otherwise the value of the variable is used in the shell prompt.</p>
  </dd>
  <dt>SH_PS1_USER_HOST_SEPARATOR_COLOR</dt>
  <dd>
    <p>Sets the color for the text which separates the <i>username</i>/<i>hostname</i> portions of the shell prompt.</p>
    <p>If this variable is not declared and <samp>SH_PS1_DONT_COLORIZE_PROMPT</samp> is not set to <samp>1</samp>, the default color is green, <code>&#x24;(tput setaf 2)</code>. Otherwise, if this variable is null or empty, it results in <code>$(tput sgr0)</code>.  Otherwise the value of the variable is used in the shell prompt.</p>
  </dd>
  <dt>SH_PS1_HOSTNAME_COLOR</dt>
  <dd>
    <p>Sets the color for the <i>hostname</i> portion of the shell prompt.</p>
    <p>If this variable is not declared and <samp>SH_PS1_DONT_COLORIZE_PROMPT</samp> is not set to <samp>1</samp>, the default color is green, <code>&#x24;(tput setaf 2)</code>. Otherwise, if this variable is null or empty, it results in <code>$(tput sgr0)</code>. Otherwise the value of the variable is used in the shell prompt.</p>
  </dd>
  <dt>SH_PS1_PWD_COLOR</dt>
  <dd>
    <p>Sets the color for the <i>present working directory</i> (PWD) portion of the shell prompt.</p>
    <p>If this variable is not declared and <samp>SH_PS1_DONT_COLORIZE_PROMPT</samp> is not set to <samp>1</samp>, the default color is dim yellow, <code>&#x24;(tput setaf 3)</code> (or brown, as I think it was called for 8/16-color mode). Otherwise, if this variable is null or empty, it results in <code>$(tput sgr0)</code>. Otherwise the value of the variable is used in the shell prompt.</p>
  </dd>
  <dt>SH_PROMPT_COLOR</dt>
  <dd>
    <p>Set the color for the <i>prompt</i> portion of the shell prompt (e.g. typically the '<samp>$</samp'> or '<samp>#</samp>' that appears indicating the shell is ready and  awaiting user input).</p>
    <p>If this variable is not declared, is null, or empty, then the prompt string's resulting color is <code>$(tput sgr0)</code>. Otherwise the value of the variable is used in the shell prompt.</p>
  </dd>
</dl>

> **WARNING**  
> There's nothing stopping you from placing other text in the variables discussed above, but they're intended to contain only color information for the various pieces of the prompt string. 
> 
> You can experiment with values other than purely color information, but you do so at your own risk.

## Customzing Your Git Format String
`git-prompt.sh` only affects the display of your shell prompt when you are currently in a directory which contains a _git_ repository.

The customized version of `git-prompt.sh` included in this repository allows for enhanced customization of your git repository format string. In the sections that follow, the standard environment variables will be discussed (those that natively come with the `git-prompt.sh` script as supplied by git) and the variables that this customized version of `git-prompt.sh` allow to be set.

As stated above in **Using the Shell Prompt Customization Scripts**, you must copy `git-prompt.sh` to your home directory (either with the same name, or renamed as `.git-prompt.sh`) in order for the environment variables discussed below to have any effect on your shell prompt.

### The Standard `git-prompt.sh` Environment Variables
The following list describes the effects of the standard `git-prompt.sh` environment variables on the display of git repository information in the shell prompt. The core functionality of these environment variables has been preserved by the extended version of this script. The default values of all environment variables used in this extended `git-prompt.sh` script result in the standard, out-of-the-box display of git repository information (which is usually just the currently checked out branch name of the git repository).

Many of the effects of the standard `git-prompt.sh` environment variables can be changed or extended through the use and setting of additional environment variables supported by this extended `git-prompt.sh` script.

<dl>
  <dt>GIT_PS1_SHOWDIRTYSTATE</dt>
  <dd>
    <p>If this environment variable is set to a non-empty value, unstaged and staged changes will be shown next to the current branch name for the <i>git</i> repository.</p>
    <p>Unstaged files are denoted with a red '<samp>*</samp>' and staged changes are denoted with a green '<samp>+</samp>'. These characters can be replaced using the extended environment variables discussed in the sections that follow.</p>
    <p>You can configure the display of this information per repository with the <samp>bash.showDirtyState</samp> <i>git</i> repository configuration variable. This <i>git</i> configuration repository variable defaults to <samp>true</samp> once this environment variable is set. To change a repository to not show this information after this environment variable has been set, run the following command inside the <i>git</i> repository:</p>
    <pre class="prettyprint"><code class="language-bash hljs">$ git config bash.showDirtyState=false</code></pre>
  </dd>
  <dt>GIT_PS1_SHOWUNTRACKEDFILES</dt>
  <dd>
    <p>If this environment variable to a non-empty value, a character representing that there are untracked files in the repository  will be displayed next to the current branch name for the <i>git</i> repository.</p>
    <p>Untracked files are denoted with a red '<samp>%</samp>' sign. This character can be replaced using the extended environment variables discussed in the sections that follow.</p>
    <p>You can configure the display of this information per repository with the <samp>bash.showUntrackedFiles</samp> <i>git</i> configuration variable. This <i>git</i> repository configuration variable defaults to <samp>true</samp> once this environment variable is set. To change a repository to not show this information after setting this environment variable, run the following command inside the <i>git</i> repository:</p>
    <pre class="prettyprint"><code class="language-bash hljs">$ git config bash.showUntrackedFiles=false</code></pre>
  </dd>
  <dt>GIT_PS1_SHOWSTASHSTATE</dt>
  <dd>
    <p>If this environment variable is set to a non-empty value, a character representing whether or not any stashes exist in the repository will be displayed next to the current branch name for the <i>git</i> repository.</p>
    <p>If there are any stashes present in the current repository, this will be denoted with a blue '<samp>$</samp>'. This character can be replaced using the extended environment variables discussed in the sections that follow.</p>
  </dd>
  <dt>GIT_PS1_SHOWUPSTREAM</dt>
  <dd>
    <p>If you would like to see the difference between <samp>HEAD</samp> and its upstream, set this environment variable to <code>auto</code>.  A '<samp>&lt;</samp>' indicates you are behind, '<samp>&gt;</samp'> indicates you are ahead, '<samp>&lt;&gt;</samp>' indicates you have diverged, and '<samp>=</samp>' indicates that there is no difference between your copy of the branch and the upstream branch. You can further control behaviour of displaying upstream branch information by setting this environment variable to a space-separated list of values shown in the table below:</p>
    <table summary="Valid values and their description for GIT_PS1_SHOWUPSTREAM">
      <thead>
        <tr>
          <th scope="col">Value</th>
          <th scope="col">Description</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><samp>verbose</samp></td>
          <td>Shows the number of commits your copy of the branch is ahead/behind (+/-) of the upstream branch.</td>
        </tr>
        <tr>
          <td><samp>name</samp></td>
          <td>If verbose is specified, then also showthe upstream abbreviation name.</td>
        </tr>
        <tr>
          <td><samp>legacy</samp></td>
          <td>Don't use the <code>--count</code> option available in recent versions of <code>git-rev-list</code></td>
        </tr>
        <tr>
          <td><samp>git</samp></td>
          <td>Always compare <samp>HEAD</samp> to <samp>@{upstream}</samp></td>
        </tr>
        <tr>
          <td><samp>svn</samp></td>
          <td>Always compare <samp>HEAD</samp> to your SVN upstream</td>
        </tr>
      </tbody>
    </table>
    <p>By default, <code>__git_ps1</code> will compare <samp>HEAD</samp> to your SVN upstream if it can find one, or <samp>@{upstream}</samp> otherwise.  Once you have set this environment variable, you can override it on a per repository basis by setting the <i>git</i> repository configuration variable <samp>bash.showUpstream</samp>. To change how a particular repository shows this information after setting this environment variable, run the following command inside the repository:</p>
    <pre class="prettify">
        # Running this command sets bash.showUntrackedFiles to its default value.
        # Of course, you can use any of the values from the table above.
        $ git config bash.showUntrackedFiles="git"
    </pre>
  </dd>
  <dt>GIT_PS1_STATESEPARATOR</dt>
  <dd>
    <p>You can change the separator between the branch name and the above state symbols by setting this environment variable. The default separator is <samp>&lt;SP&gt;</samp> (a space character).</p>
  </dd>
  <dt>GIT_PS1_DESCRIBE_STYLE</dt>
  <dd>
    <p>If you would like to see more information about the identity of commits checked out as a detached <samp>HEAD</samp>, set this environment variable to one of these values:</p>
    <table summary="Valid values for the GIT_PS1_DESCRIBE_STYLE environment variable.">
      <thead>
        <tr>
          <th scope="col">Value</th>
          <th scope="col">Description</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><samp>contains</samp></td>
          <td>Displays a value relative to a newer annotated tag as the current branch name. For example: <samp>(v1.6.3.2~35)</samp>.</td>
        </tr>
        <tr>
          <td><samp>branch</samp></td>
          <td>Displays a value relative to a newer tag or branch as the current branch name. For example: <samp>(master~4)</samp></td>
        </tr>
        <tr>
          <td><samp>describe</samp></td>
          <td>Displays a value relative to an older annotated tag as the current branch name. For example: <samp>(v1.6.3.1-13-gdd42c2f)</samp></td>
        </tr>
        <tr>
          <td><samp>default</samp></td>
          <td>displays the exactly matching tag (or shortened commit SHA) as the current branch name.</td>
        </tr>
      </tbody>
    </table>
  </dd>
  <dt>GIT_PS1_SHOWCOLORHINTS</dt>
  <dd>
    <p>If this environment variable is set to a non-empty value, <code>__git_ps1</code> displays colored repository branch state information. The colors are based on the colored output from the <code>git status -sb</code> command.</p>
    <p>Colored output of dirty state information is only available when using the output from <code>__git_ps1</code> for setting <code>PROMPT_COMMAND</code> (in <i>bash</i>) or when using <code>precmd</code> (in <i>zsh</i>).</p>
    <blockquote>
      <p><b>NOTE</b></p>
      <p><i><abbr title="Z-Shell">zsh</abbr></i> is not supported at this time. Hopefully support will be added for this shell in the near future.</p>
    </blockquote>
  </dd>
  <dt>GIT_PS1_HIDE_IF_PWD_IGNORED</dt>
  <dd>
    <p>If you would like <code>__git_ps1</code> to do nothing in the case when the current directory is set up to be ignored by _git_ (via a repository <samp>.gitignore</samp> or global ignore file), then set this environment variable value to a non-empty value.</p>
    <p>You can override the effects of this environment variable on a per repository basis by setting the <i>git</i> repository configuration variable <samp>bash.hideIfPwdIgnored</samp> to <code>false</code> by running the following command from within the repository:</p>
    <pre class="prettyprint"><code class="language-bash hljs">$ git config bash.hideIfPwdIgnored=false</code></pre>
  </dd>
</dl>

### New `git-prompt.sh` Environment Variables

The following list and description of environment variables have been added to this extended version of the `git-prompt.sh` script. The default values of all of these variables results in this extended `git-prompt.sh` script working in exactly the same manner as the standard `git-prompt.sh` script provided with distributions of _git_. These variables can be broken down into two main categories:

1. Information display format strings
2. Information display colorization

#### Display Format Strings
The following list describes the available format string environment variables that will allow you to customize how git repository information is displayed via `__git_ps1`.
<dl>
  <dt>GIT_PS1_SHOWUPSTREAM_STYLE</dt>
  <dd>
    <p>This environment variable can be set to one of the values listed in the following table. In the table below, the <b>Verbose</b> column indicates whether or not <samp>GIT_PS1_SHOWUPSTREAM</samp> contains <code>verbose</code> as one of its values. <samp>{ac}</samp> means <i>ahead count</i>, <samp>{bc}</samp> means <i>behind count</i>, and <samp>{b-ud}</samp> means <i>behind user defined</i> and <samp>{a-ud}</samp> means <i>ahead user defined</i>.</p>
    <table summary="Valid GIT_PS1_SHOWUPSTREAM_STYLE values and the resulting output.">
      <thead>
        <tr>
          <th align="center" scope="col">Value</th>
          <th align="center" cope="col">Verbose</th>
          <th align="center" scope="col">Behind</th>
          <th align="center" scope="col">Ahead</th>
          <th align="center" scope="col">Diverged</th>
          <th align="center" scope="col">Up-to-Date</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><samp>default</samp></td>
          <td align="center">No</td>
          <td align="center"><samp>&lt;</samp></td>
          <td align="center"><samp>&gt;</samp></td>
          <td align="center"><samp>&lt;&gt;</samp></td>
          <td align="center"><samp>=</samp></td>
        </tr>
        <tr>
          <td><samp>default</samp></td>
          <td align="center">Yes</td>
          <td align="center"><samp>u-{bc}</samp></td>
          <td align="center"><samp>u+{ac}</samp></td>
          <td align="center"><samp>u+{ac}-{bc}</samp></td>
          <td align="center"><samp>u=</samp></td>
        </tr>
        <tr>
	      <td><samp>arrow</samp></td>
	      <td align="center">No</td>
	      <td align="center"><samp>&#x2193;</samp></td>
	      <td align="center"><samp>&#x2191;</samp></td>
	      <td align="center"><samp>&#x2193;&#x2191;</samp></td>
	      <td align="center"><samp>&#x2261;</samp></td>
	    </tr>
	    <tr>
	      <td><samp>arrow</samp></td>
	      <td align="center">Yes</td>
	      <td align="center"><samp>{bc}&#x2193;</samp></td>
	      <td align="center"><samp>&#x2191;{ac}</samp></td>
	      <td align="center"><samp>{bc}&#x2193;&#x2191;{ac}</samp></td>
	      <td align="center"><samp>&#x2261;</samp></td>
	    </tr>
	    <tr>
		  <td><samp>rlarrowhead</samp>
		  <td align="center">No</td>
		  <td align="center"><samp>&#x02C2;</samp></td>
		  <td align="center"><samp>&#x02C3;</samp></td>
		  <td align="center"><samp>&#x02C2;&#x02C3;</samp></td>
		  <td align="center"><samp>&#x2261;</samp></td>
		</tr>
		<tr>
		  <td><samp>rlarrowhead</samp>
		  <td align="center">Yes</td>
		  <td align="center"><samp>{bc}&#x02C2;</samp></td>
		  <td align="center"><samp>&#x02C3;{ac}</samp></td>
		  <td align="center"><samp>{bc}&#x02C2;&#x02C3;{ac}</samp></td>
		  <td align="center"><samp>&#x2261;</samp></td>
		</tr>
		<tr>
		  <td><samp>udarrowhead</samp>
		  <td align="center">No</td>
		  <td align="center"><samp>&#x02C5;</samp></td>
		  <td align="center"><samp>&#x02C4;</samp></td>
		  <td align="center"><samp>&#x02C5;&#x02C4;</samp></td>
		  <td align="center"><samp>&#x2261;</samp></td>
		</tr>
		<tr>
		  <td><samp>udarrowhead</samp>
		  <td align="center">Yes</td>
		  <td align="center"><samp>{bc}&#x02C5;</samp></td>
		  <td align="center"><samp>&#x02C4;{ac}</samp></td>
		  <td align="center"><samp>{bc}&#x02C5;&#x02C4;{ac}</samp></td>
		  <td align="center"><samp>&#x2261;</samp></td>
		</tr>
		<tr>
		  <td><samp>rltri</samp></td>
		  <td align="center">No</td>
		  <td align="center"><samp>&#x25C4;</samp></td>
		  <td align="center"><samp>&#x25BA;</samp></td>
		  <td align="center"><samp>&#x25C4;&#x25BA;</samp></td>
		  <td align="center"><samp>&#x2261;</samp></td>
		</tr>
		<tr>
		  <td><samp>rltri</samp></td>
		  <td align="center">Yes</td>
		  <td align="center"><samp>{bc}&#x25C4;</samp></td>
		  <td align="center"><samp>&#x25BA;{ac}</samp></td>
		  <td align="center"><samp>{bc}&#x25C4;&#x25BA;{ac}</samp></td>
		  <td align="center"><samp>&#x2261;</samp></td>
		</tr>
		<tr>
		  <td><samp>udtri</samp></td>
		  <td align="center">No</td>
		  <td align="center"><samp>&#x25BC;</samp></td>
		  <td align="center"><samp>&#x25B2;</samp></td>
		  <td align="center"><samp>&#x25BC;&#x25B2;</samp></td>
		  <td align="center"><samp>&#x2261;</samp></td>
		</tr>
		<tr>
		  <td><samp>udtri</samp></td>
		  <td align="center">Yes</td>
		  <td align="center"><samp>{bc}&#x25BC;</samp></td>
		  <td align="center"><samp>&#x25B2;{ac}</samp></td>
		  <td align="center"><samp>{bc}&#x25BC;&#x25B2;{ac}</samp></td>
		  <td align="center"><samp>&#x2261;</samp></td>
		</tr>
		<tr>
		  <td><samp>custom</samp>
		  <td align="center">No</td>
		  <td align="center"><samp>{b-ud}</samp></td>
		  <td align="center"><samp>{a-ud}</samp></td>
		  <td align="center"><samp>{b-ud}{a-ud}</samp></td>
		  <td align="center"><samp>{ud}</samp></td>
		</tr>
		<tr>
		  <td><samp>custom</samp>
		  <td align="center">Yes</td>
		  <td align="center"><samp>{bc}{b-ud}</samp></td>
		  <td align="center"><samp>{a-ud}{ac}</samp></td>
		  <td align="center"><samp>{bc}{b-ud}{a-ud}{ac}</samp></td>
		  <td align="center"><samp>{ud}</samp></td>
		</tr>
	  </tbody>
	</table>
	<p>If this environment variable is not declared or is null or empty or not one of the values defined in the table above, then the value defaults to <code>default</code> in the above table.</p>
	<blockquote>
	  <p><b>NOTE</b></p>
	  <p>In order to use any of the values except <code>default</code> or <code>custom</code>, you must use a terminal which supports UTF-8 character encoding. Likewise, if you use Unicode characters for any of the four custom glyph environment variables, your terminal must support UTF-8 character encoding.</p>
	</blockquote>
  </dd>
  <dt>GIT_PS1_SHOWUPSTREAM_CUSTOM_AHEAD</dt>
  <dt>GIT_PS1_SHOWUPSTREAM_CUSTOM_BEHIND</dt>
  <dt>GIT_PS1_SHOWUPSTREAM_CUSTOM_DIVERGED</dt>
  <dt>GIT_PS1_SHOWUPSTREAM_CUSTOM_UPTODATE</dt>
  <dd>
    <p>These  four variables allow you to set the marker to be displayed for each of the four states of a local repository branch as compared to its remote upstream branch.</p>
    <blockquote>
      <p><b>NOTE</b></p>
      <p>There's nothing stopping you from including additional text or other information in any one of these variables. However, their main intent was to display a single glyph-like character. Using anything more than a single character to display information about the status of a branch compared to its upstream counterpart may cause unpredictable behavior and is unsupported.</p>
    </blockquote>
  </dd>
  <dt>GIT_PS1_SHOWUPSTREAM_SEPARATOR</dt>
  <dd>
    <p>If this variable is declared and set to a non-null, non-empty value, the value of this environment variable is used between the ahead/behind information displayed when <samp>GIT_PS1_SHOWUPSTREAM</samp> is set to a non-empty value. For example, if <code>GIT_PS1_SHOWUPSTREAM_SEPARATOR="|"</code>, a diverged branch would display as <samp>{bc}&lt;|&gt;{ac}</samp>.
    </p>
  </dd>
  <dt>GIT_PS1_INITIALCOMMIT</dt>
  <dd>
    <p>When <samp>GIT_PS1_SHOWDIRTYSTATE</samp> is set to a non-empty value, this environment variable determines the text that is displayed for a branch which has no commits (i.e. the repository is new). The default text that is displayed if this variable is not declared is '<samp>#</samp>'.</p>
  </dd>
  <dt>GIT_PS1_STAGEDCHANGES</dt>
  <dd>
    <p>When <samp>GIT_PS1_SHOWDIRTYSTATE</samp> is set to a non-empty value, this environment variable determines the text that is displayed for a branch when that branch has staged changes that need to be committed. The default text that is displayed when there are staged changes in the local repository is '<samp>+</samp>'.</p>
  </dd>
  <dt>GIT_PS1_UNSTAGEDCHANGES</dt>
  <dd>
    <p>When <samp>GIT_PS1_SHOWDIRTYSTATE</samp> is set to a non-empty value, this environment variable determines the text that is displayed for a branch when that branch has unstaged changes that need to be staged. The default text that is displayed when there are unstaged changes in the local repository is '<samp>*</samp>'.</p>
  </dd>
  <dt>GIT_PS1_UNTRACKEDFILES</dt>
  <dd>
    <p>When <samp>GIT_PS1_SHOWUNTRACKEDFILES</samp> is set to a non-empty value, this environment variable determines the text that is displayed for a branch when that branch has untracked files. The default text that is displayed when untracked files exist in the local repository is '<samp>%</samp>'.</p>
  </dd>
  <dt>GIT_PS1_STASHSTATE</dt>
  <dd>
    <p>When <samp>GIT_PS1_SHOWSTASHSTATE</samp> is set to a non-empty value, this environment variable determines the text that is displayed for a repository when that repository has changes which have been stashed. The default text that is displayed when a repository has stashed changes is '<samp>$</samp>'.</p>
  </dd>
  <dt>GIT_PS1_SHOWSHORTSHA</dt>
  <dd>When set to <code>1</code>, this shows the short SHA commit id for the current branch's <samp>HEAD</samp> according to the format specified in <samp>GIT_PS1_SHORTSHA_FORMAT</samp>.</dd>
  <dt>GIT_PS1_SHORTSHA_FORMAT</dt>
  <dd>This environment variable allows you to determine how the short SHA commit id for the current branche's <samp>HEAD</samp> is displayed. The default value is <code>({s})</code>, e.g. <samp>(8e38bf4)</samp>. Note that <code>{s}</code> reperesents the placeholder for the SHA. So you cannot use <code>{s}</code> in any part of the value of this variable unless you want it to be replaced with the short SHA. You can specify color information in the <samp>GIT_PS1_SHORTSHA_COLOR</samp> environment variable.</dd>
  <dt>GIT_PS1_BRANCH_FORMAT</dt>
  <dd>
	<p>This environment variable contains tokens that determines the display order of git branch information in your shell prompt. The table below shows the tokens that this variable supports, and their meaning.</p>
    <table summary="GIT_PS1_BRANCH_FORMAT token descriptions.">
      <thead>
        <tr>
          <th scope="col">Format Token</th>
		  <th scope="col">Description</th>
		</tr>
	  </thead>
	  <tbody>
	    <tr>
		  <td align="center"><samp>h</samp></td>
		  <td>If <samp>GIT_PS1_SHOWSHORTSHA</samp> is set to <code>1</code>, this token displays the short form of the SHA commit ID of the <samp>HEAD</samp> ref for the current branch, using the format specified in <samp>GIT_PS1_SHORTSHA_FORMAT</samp>. The default value of this variable is <code>0</code>.</td>
		</tr>
		<tr>
		  <td align="center"><samp>b</samp></td>
		  <td>This token is replaced with the current repository's checked out branch name.</td>
		</tr>
		<tr>
		  <td align="center"><samp>s</samp></td>
		  <td>When <samp>GIT_PS1_SHOWBRANCHSTATE</samp> is set to <code>1</code>, this token is replaced with the current branch's state information (e.g. (un)staged commits, untracked files, etc.).</td>
	    </tbody>
      </table>
	  <p>The default value of this variable if it is undeclared or empty or null is <code>bs</code>, i.e. show the branch name and the branch state information (if enabled by the value of <samp>GIT_PS1_SHOWBRANCHSTATE</samp>).</p>
	  <blockquote>
	    <p><b>WARNING</b></p>
		<p>Do not use any other text inside this variable other than the tokens listed in the table above. Do not provide any additional formatting in this variable. If you add additional text or formatting to this variable, your prompt likely will not display properly.</p>
      </blockquote>
	</dd>
  <dt>GIT_PS1_BRANCHSTATE_FORMAT</dt>
  <dd>
  <p>When <samp>GIT_PS1_SHOWDIRTYSTATE</samp>, <samp>GIT_PS1_SHOWUNTRACKEDFILES</samp>, and/or <samp>GIT_PS1_SHOWSTASHSTATE</samp> are set to a non-empty value, this environment variable can contain tokens which specify in what order the branch state information for the branch will appear.</p>
  <p>If this variable is undeclared, null, or empty, it defaults to <samp>"wisu"</samp>. By default, this results in the following branch information being displayed:</p>
  <pre>feature/my_special_feature *+$%</pre>
  <p>The meaning of each of the format tokens is listed in the table below:</p>
  <table summary="GIT_PS1_BRANCHSTATE_FORMAT token descriptions.">
	  <thead>
	    <tr>
	      <th scope="col">Format Token</th>
	      <th scope="col">Description</th>
	    </tr>
	  </thead>
	  <tbody>
	    <tr>
	      <td align="center"><samp>w</samp></td>
	      <td>Causes the string defined in <samp>GIT_PS1_UNSTAGEDCHANGES</samp> to be displayed when your working index contains unstaged changes.
	      </td>
	    </tr>
	    <tr>
	      <td align="center"><samp>i</samp></td>
	      <td>Causes the string defined in <samp>GIT_PS1_STAGEDCHANGES</samp> to be displayed when your index contains staged changes.
	      </td>
	    </tr>
	    <tr>
	      <td align="center"><samp>s</samp></td>
	      <td>Causes the string defined in <samp>GIT_PS1_STASHSTATE</samp> to be displayed when your repository contains stashed changesets.
	      </td>
	    </tr>
	    <tr>
	      <td align="center"><samp>u</samp></td>
	      <td>Causes the string defined in <samp>GIT_PS1_UNTRACKEDFILES</samp> to be displayed when your working index contains untracked files.
	      </td>
	    </tr>
	  </tbody>
	</table>
    <p>Some notes regarding the use of this variable:</p>
    <ol>
      <li>You can place these tokens in any order.</li>
      <li>This variable should only contain these tokens and no other text. Any other text included in this variable may result in unpredictable and unsupported behavior.</li>
      <li>Any spacing and formatting you require for your desired git repository branch dirty state should be defined through the individual format string variables discussed above and the color format string variables discussed in the following section..</li>
    </ol>
  </dd>
  <dt>GIT_PS1_SHOWBRANCHSTATE</dt>
  <dd>
    <p>This environment variable determines when branch state information will be displayed. Valid values are shown in the table below.</p>
    <table summary="Valid GIT_PS1_SHOWBRANCHSTATE values.">
      <thead>
        <tr>
          <th scope="col">Value</th>
          <th scope="col">Description</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td align="center"><code>default</code></td>
          <td>If any value is provided for this variable other than those listed in this table, this value applies. When this environment variable is set to <code>default</code>, branch state information is displayed normally (i.e. only when there are (un)staged commits, untracked files, or stashed changesets are the indicators displayed).</td>
        </tr>
        <tr>
          <td align="center"><code>always</code></td>
          <td>When <samp>GIT_PS1_SHOWCOLORHINTS</samp> is set to a non-null, non-empty value and one or more of <samp>GIT_PS1_SHOWDIRTYSTATE</samp>, <samp>GIT_PS1_SHOWSTASHSTATE</samp> or <samp>GIT_PS1_SHOWUNTRACKEDFILES</samp> are set to a non-null, non-empty value, the enabled indicators are always shown in the color specified by <samp>GIT_PS1_CLEANSTATE_COLOR</samp>, which defaults to <code>$(tput setf 7)</code>.</td>
        </tr>
      </tbody>
    </table>
  </dd>
  <dt>GIT_PS1_SHOWSTATE_COUNTS</dt>
  <dd>
    <p>This environment variable, when set to <code>1</code> will show the number of added/deleted files, unstaged changes, and untracked files to the left of the defined branch state indicators.</p>
	<blockquote>
	  <p><b>WARNING</b></p>
	  <p>Enabling this option <em>will</em> significantly slow down the display of your prompt after executing commands when inside a git repository. Only enable this option if your repository is small and you really really want to see this information.</p>
	</blockquote>
  </dd>
</dl>

#### Color Format Strings
The following list describes the available color format string environment variables that will allow you to customize how git repository information is colored when displayed via `__git_ps1` as extended in this version of `git-prompt.sh`.

<dl>
  <dt>GIT_PS1_DETACHEDHEAD_COLOR</dt>
  <dd>When <samp>GIT_PS1_SHOWCOLORHINTS</samp> is set to a non-empty value, a detached head will be displayed in the color specified by this environment variable. If this environment variable is undeclared, the default value of <code>$(tput setaf 1)</code> (red) is used.</dd>
  <dt>GIT_PS1_OKBRANCH_COLOR</dt>
  <dd>When <samp>GIT_PS1_SHOWCOLORHINTS</samp> is set to a non-empty value, a branch which is set to track a valid remote branch will be displayed in the color specified by this environment variable. If this environment variable is undeclared, the default value of <code>$(tput setaf 2)</code> (green) will be used.</dd>
  <dt>GIT_PS1_CLEANSTATE_COLOR</dt>
  <dd>
    <p>When <samp>GIT_PS1_SHOWBRANCHSTATE</samp> is set to <code>always</code>, the enabled branch status indicators are displayed in this color. For example, if you have configured GIT_PS1_SHOWDIRTYSTATE to a non-null, non-empty value, then the <samp>GIT_PS1_DIRTYSTATE</samp> indicator (that is displayed for unstaged commits) will always be shown. The default value of this variable if not declared or null or empty is <code>$(tput setf 7)</code>.
    </p>
    <p>This allows, for example, indicators to be shown in a "dimmed" state (when the branch is clean); and then when commits are staged or untracked files exist, the indicator "lights up" according to the  color values assigned to the appropriate status indicator color variables.
    </p>
    <p>This color is only used when one of <samp>GIT_PS1_NOSTAGEDCHANGES_COLOR</samp>, <samp>GIT_PS1_NOUNSTAGEDCHANGES_COLOR</samp>, <samp>GIT_PS1_NOUNTRACKEDFILES_COLOR</samp>, or <samp>GIT_PS1_NOSTASHSTATE_COLOR</samp> are not declared or have a null or empty value.
    </p>
  </dd>
  <dt>GIT_PS1_INITIALCOMMIT_COLOR</dt>
  <dd>When <samp>GIT_PS1_SHOWDIRTYSTATE</samp> and <samp>GIT_PS1_SHOWCOLORHINTS</samp> are set to a non-empty value, a repository which has no commits (i.e. a new repository) will display the value of <samp>GIT_PS1_INITIALCOMMIT</samp> next to the branch name using the color specified by this environment variable. If this environment variable is undeclared, the default value of <code>$(tput setaf 2)</code> (green) is used.</dd>
  <dt>GIT_PS1_STAGEDCHANGES_COLOR</dt>
  <dd>When <samp>GIT_PS1_SHOWDIRTYSTATE</samp> and <samp>GIT_PS1_SHOWCOLORHINTS</samp> are set to a non-empty value, a repository which has staged changes will display the value of <samp>GIT_PS1_STAGEDCHANGES</samp> next to the branch name using the color specified by this environment variable. If this environment variable is undeclared, the default value of <code>$(tput setaf 2)</code> (green) is used.</dd>
  <dt>GIT_PS1_NOSTAGEDCHANGES_COLOR</dt>
  <dd>When <samp>GIT_PS1_SHOWCOLORHINTS</samp>, <samp>GIT_PS1_SHOWDIRTYSTATE</samp> are declared and have a non-null, non-empty value and <samp>GIT_PS1_SHOWBRANCHSTATE</samp> is set to <code>always</code>, this color is used to display the <samp>GIT_PS1_STAGEDCHANGES</samp> indicator when there are no staged changes on the branch.</dd>
  <dt>GIT_PS1_UNSTAGEDCHANGES_COLOR</dt>
  <dd>When <samp>GIT_PS1_SHOWDIRTYSTATE</samp> and <samp>GIT_PS1_SHOWCOLORHINTS</samp> are set to a non-empty value, a repository which has unstaged changes will display the value of <samp>GIT_PS1_UNSTAGEDCHANGES</samp> next to the branch name using the color specified by this environment variable. If this environment variable is undeclared, the default value of <code>$(tput setaf 1)</code> (red) is used.</dd>
  <dt>GIT_PS1_NOUNSTAGEDCHANGES_COLOR</dt>
  <dd>When <samp>GIT_PS1_SHOWCOLORHINTS</samp>, <samp>GIT_PS1_SHOWDIRTYSTATE</samp> are declared and have a non-null, non-empty value and <samp>GIT_PS1_SHOWBRANCHSTATE</samp> is set to <code>always</code>, this color is used to display the <samp>GIT_PS1_UNSTAGEDCHANGES</samp> indicator when there are no unstaged changes on the branch.</dd>
  <dt>GIT_PS1_UNTRACKEDFILES_COLOR</dt>
  <dd>When <samp>GIT_PS1_SHOWUNTRACKEDFILES</samp> and <samp>GIT_PS1_SHOWCOLORHINTS</samp> are set to a non-empty value, a repository which has untracked files will display the value of <samp>GIT_PS1_UNTRACKEDFILES</samp> next to the branch name using the color specified by this environment variable. If this environment variable is undeclared, the default value of <code>$(tput setaf 1)</code> (red) is used.</dd>
  <dt>GIT_PS1_NOUNTRACKEDFILES_COLOR</dt>
  <dd>When <samp>GIT_PS1_SHOWCOLORHINTS</samp>, <samp>GIT_PS1_SHOWDIRTYSTATE</samp> are declared and have a non-null, non-empty value and <samp>GIT_PS1_SHOWBRANCHSTATE</samp> is set to <code>always</code>, this color is used to display the <samp>GIT_PS1_UNTRACKEDFILES</samp> indicator when there are no untracked files on the branch.</dd>
  <dt>GIT_PS1_STASHSTATE_COLOR</dt>
  <dd>When <samp>GIT_PS1_SHOWSTASHSTATE</samp> and <samp>GIT_PS1_SHOWCOLORHINTS</samp> are set to a non-empty value, a repository which has stashed changes will display the value of <samp>GIT_PS1_STASHSTATE</samp> next to the branch name using the color specified by this environment variable. If this environment variable is undeclared, the default value of <code>$(tput setaf 4)</code> (blue) is used.</dd>
  <dt>GIT_PS1_NOSTASHSTATE_COLOR</dt>
  <dd>When <samp>GIT_PS1_SHOWCOLORHINTS</samp>, <samp>GIT_PS1_SHOWDIRTYSTATE</samp> are declared and have a non-null, non-empty value and <samp>GIT_PS1_SHOWBRANCHSTATE</samp> is set to <code>always</code>, this color is used to display the <samp>GIT_PS1_STASHSTATE</samp> indicator when there are no stashed changesets for the repository.</dd>
  <dt>GIT_PS1_SHORTSHA_COLOR</dt>
  <dd>When <samp>GIT_PS1_SHOWCOLORHINTS</samp> and <samp>GIT_PS1_SHOWSHORTSHA</samp> are enabled, the color defined in this variable is used when displaying the short SHA in the <i>git</i> branch information. The default value is <code>$(tput setaf 3)</code>.</dd>
</dl>

## Examples of Shell and/or Git Prompt Customization
In the following sections, several examples of variable values will be shown and the resulting shell prompt output will be demonstrated.

**TODO: Add examples here.**

## Notes

1. The available "glyphs" that you choose for various parts of the Git string prompt depend on the font you've chosen to use for your terminal window. For example, the font Consolas has a rather limited set of Unicode characters to choose from, while another font such as DejaVu Sans Mono has many Unicode glyphs to choose from.
2. The modifications made to `git-prompt.sh` may not be compatable with Z-Shell (zsh). Leave me an issue tracker if you find that to be the case. Better yet, submit a pull request.

## Planned, Future Enhancements

1. Test the modifications in ZSH. They appear that they should work out of the box, but no formal testing has yet been performed.
2. Create a "build system" that would allow for creating a "theme" that would then generate the required environment variable values and example code which could be placed in your `.bashrc`.
3. Create a set of pre-defined "themes".
4. Look into customizing other git scripts colors (e.g. git status).
    * I find the default red and green colors a bit too dark and saturated for my liking (too hard to see on a black background), which is what spawned these customizations to begin with.
	* I looked through the `git config --help` documentation, and apparently there are many options that can be set to change the colors output by various scripts; so I won't reinvent the wheel unless I am able to provide customizations above and beyond what the standard tools allow you to do and which will add value and which will not have a significant impact on the amount of time it takes to process the command.
5. Look into contributing these customizations to Git for Windows. Is there any interest in providing this level of customizability in Git for Windows proper (or perhaps even git itself)??
    * I'm open to comments on this. If there's little to no interest, then I'll just keep these customizations here.

> Written with [StackEdit](https://stackedit.io/).
