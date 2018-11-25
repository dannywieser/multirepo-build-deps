# multirepo-build-deps

When working with code split amongst multiple repositories, an effective strategy can be to add package.json dependencies referencing git repos directly, such as:

```json
"@myorg/my-other-repo": "git://github.com/myorg/my-other-repo.git#v1.0.0",
```

or to reference in-progress work on a feature branch

```json
"@myorg/my-other-repo": "git://github.com/myorg/my-other-repo.git#feature/a-feature-branch",
```

However, the issue with this strategy occurs when the code in that repo needs to be built/transpiled in order to be used by the dependent repo.

This package provides a simple script that can be used to run a yarn script on a package inside node_modules to prepare it for usage as a dependency.

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
