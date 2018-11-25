# multirepo-build-deps

When working with code split amongst multiple repositories, an effective strategy can be to add package.json dependencies referencing git repos directly, such as:

```json
"@myorg/my-other-repo": "git://github.com/myorg/my-other-repo.git#v1.0.0",
```

or to reference in-progress work on a feature branch

```json
"@myorg/my-other-repo": "git://github.com/myorg/my-other-repo.git#feature/a-feature-branch",
```

However, the issue with this strategy occurs when the code in that repo needs to be built/transpiled in order to be used by the dependent repo. For example, code written in TypeScript needs to be transpiled to js, and code using it will likely rely on types that are only generated at build time.

This package provides a simple script that can be used to run a yarn script on a package inside node_modules to prepa

## requirements

This package currently relies on yarn being installed (the shell scripts here use yarn internally to install dependencies and run scripts).

## build-deps

This script assumes that you are installing multiple dependencies scoped for an organization, and will process each sub-package inside that org and execute a build script for that repo.

The most effective way to use this script is to add it as the `postinstall` script inside package.json

```json
    "postinstall": "build-deps @myorg"
```

By default, this will execute *yarn* and run the command `build`. A second parameter can be provided to choose a different command

```json
    "postinstall": "build-deps @myorg another-command"
```

## watch-deps

This scripts is useful when you have multiple dependencies inside an org that you have symlinked using `yarn link` during development. It allows you to run a single command to trigger a watch inside all linked dependency repos for the org.

Example usage: `yarn watch-deps $myorg`

Note that this will only trigger the watch command if the dependency is found to be a link. This assumes that for a non-linked package that a one-time build on install (`build-deps`) will suffice.

```json
    "watch-deps": "watch-deps @myorg"
```

OR 

```json
    "watch-deps": "watch-deps @myorg my-watch-command"
```