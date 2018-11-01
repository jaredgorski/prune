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
export PRUNEPATH=<path to cloned directory>
source $PRUNEPATH/main.sh
```

#### Features currently supported:
- **local prune** `prune -l -f` : Simply deletes local branches that do not exist on the remote (requires `-f`)


Please feel free to open issues or ask questions! I am available at [jaredgorski6@gmail.com](mailto:jaredgorski6@gmail.com)
