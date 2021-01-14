# chocolate
### automatic command runner

chocolate will run commands when files change. 
you choose the files and the commands.

### examples

rebuild a project if source files change

```
$ find src/ | chocolate sh -c 'make'
```

rebuild a project if a source file changes or is added to the src/ directory

```
$ while sleep 0.1; do find src -name '*.c' | chocolate -d make; done
```

commit sudoku after a file is updated

```
$ find . -type f | chocolate -p 'kill $PPID'
```

