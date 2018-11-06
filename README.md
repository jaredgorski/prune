# prune
Interactive git branch pruning tool


![](/.media/gifs/prune-demo_soft.gif)


# Contents
- [About](#about)
- [Install](#install)
- [Usage](#usage)
  - [Currently Supported Commands](#currently-supported-commands)
- [Coming Soon](#coming-soon)
- [Contact](#contact)


# About
Prune is a powerful tool that helps you manage your git branches more effectively.

I created this tool to reduce confusion in my workflow. After long hours sending pull requests, the accumulation of branches on my projects quickly became disorienting and difficult to maintain. The solution to this was simple: create a tool that provides intuitive options for efficiently clearing dead brush from my workspace.

I hope you find it useful!


# Install

To install, simply clone this repository to your machine, navigate to the `prune` directory, execute or source `./install.sh`, and open a new shell session.


![](/.media/gifs/prune-demo_install.gif)


Alternatively, you can navigate to the directory where you would like to store this application and execute the following all-in-one command, depending on your shell:

**~/.bashrc**
```
git clone https://github.com/jaredgorski/prune.git && cd prune && source ./install.sh && source ~/.bashrc
```

**~/.zshrc**
```
git clone https://github.com/jaredgorski/prune.git && cd prune && source ./install.sh && source ~/.zshrc
```

**~/.bash_profile**
```
git clone https://github.com/jaredgorski/prune.git && cd prune && source ./install.sh && source ~/.bash_profile
```


# Usage

In prune, commands consist of the main `prune` command followed by one or more flags that determine the prune setting and provide extra functionality or security.

Here's an example of a command (running soft prune in dry mode - not yet ready, but coming soon):

```
$ prune -s -dry
```

And here it is in action:


![](/.media/gifs/prune-demo_dry.gif)


### Currently Supported Commands

| Command  `prune`+...   | Description                                                                   |
| :--------------------: | ----------------------------------------------------------------------------- |
|  `-s`          | Prunes local branches that have already been pushed and merged.                       |
|  `-a`          | Prunes all local branches. (requires force option `-f`)                               |
|  `-unpushed`   | Prunes local branches not matching a remote branch name. (requires force option `-f`) |

*Options* modify commands in order to add safety, enable functionality, or provide a preview of a given command.

| Option  `<cmd>`+...    | Description                                                                   |
| :--------------------: | ----------------------------------------------------------------------------- |
|  `-f`         | Safety precaution. Enables commands that require force to execute. This tool is destructive by nature, so make sure your work is safe. |


---


## Coming Soon
- Tests
- `dry` dry mode: lists branches to be pruned under the current command setting, but doesn't prune them
- `-t` tagged option: prunes all branches with names ending in '-prune_me'
- `-incl <pattern>`, `-excl <pattern>`includes/excludes option: prunes only branches with names matching a pattern
- `-time <duration>h/d (hours/days)` option: allows pruning anything older than a given number of hours or days
- `-i` interactive prune mode: provides index of branches for selective pruning
- `-r` remote flag: enables pruning of remote branches
- Ability to login to another Github account and prune remotes (Supporting 2FA, adding features, cleaning up etc.)

## Contact

Please feel free to open issues or ask questions! I'm available at [jaredgorski6@gmail.com](mailto:jaredgorski6@gmail.com)
