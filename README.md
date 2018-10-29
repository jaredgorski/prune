# prune
Interactive git branch pruning tool


```

██╗███╗   ██╗    ██████╗ ██████╗  ██████╗  ██████╗ ██████╗ ███████╗███████╗███████╗
██║████╗  ██║    ██╔══██╗██╔══██╗██╔═══██╗██╔════╝ ██╔══██╗██╔════╝██╔════╝██╔════╝
██║██╔██╗ ██║    ██████╔╝██████╔╝██║   ██║██║  ███╗██████╔╝█████╗  ███████╗███████╗
██║██║╚██╗██║    ██╔═══╝ ██╔══██╗██║   ██║██║   ██║██╔══██╗██╔══╝  ╚════██║╚════██║
██║██║ ╚████║    ██║     ██║  ██║╚██████╔╝╚██████╔╝██║  ██║███████╗███████║███████║
╚═╝╚═╝  ╚═══╝    ╚═╝     ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝
                                                                                   

```

### Currently working on:
- Tests
- Creating installer
- Building out the client (Supporting 2FA, adding features, cleaning up etc.)
- Adding `soft`, `interactive`, and `all` prune modes

### To try it out:
Since there is no installer yet, simply clone this repository to your computer and add the following to your `.bashrc` file:

```
export PRUNEPATH=<path to local clone>
source $PRUNEPATH/main.sh
```

#### Features currently supported:
- **local prune** `prune -l -f` : Simply deletes local branches that do not exist on the remote (requires `-f`)

**NOTE:** Prune currently requires `gnu-sed` to be installed. If you do not have it, you will be prompted to install it via Homebrew.


Please feel free to open issues or ask questions! I am available at [jaredgorski6@gmail.com](mailto:jaredgorski6@gmail.com)
