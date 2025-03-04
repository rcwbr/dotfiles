# rcwbr dotfiles<a name="rcwbr-dotfiles"></a>

[dotfiles](https://dotfiles.github.io/) for environment personalization

<!-- mdformat-toc start --slug=github --maxlevel=6 --minlevel=1 -->

- [rcwbr dotfiles](#rcwbr-dotfiles)
  - [Usage](#usage)
    - [Local](#local)
    - [GitHub Codespaces](#github-codespaces)
    - [VSCode devcontainers](#vscode-devcontainers)
    - [Dotfiles updater usage](#dotfiles-updater-usage)
    - [Modifying dotfiles](#modifying-dotfiles)
  - [VSCode settings usage](#vscode-settings-usage)
    - [VSCode settings sync configuration](#vscode-settings-sync-configuration)
    - [Codespaces settings sync configuration](#codespaces-settings-sync-configuration)
  - [Contributing](#contributing)
    - [devcontainer](#devcontainer)
      - [devcontainer basic usage](#devcontainer-basic-usage)
      - [devcontainer Codespaces usage](#devcontainer-codespaces-usage)
      - [devcontainer pre-commit usage](#devcontainer-pre-commit-usage)
    - [CI/CD](#cicd)
    - [Settings](#settings)

<!-- mdformat-toc end -->

## Usage<a name="usage"></a>

While dotfiles are inherently for personalization, much of this repo is built to be reusable. The
`dotfiles` subdirectory isolates the actual personalization/configuration files, while the lifecycle
and installation tooling outside this repo is fully reusable (e.g. by forking or copying this repo).

> :warning: The `local-install` script includes the reference to this repo as a hardcoded value;
> this must be altered if forked/copied.

### Local<a name="local"></a>

Unlike other use-cases, application to local environments requires explicitly cloning this repo.
This is facilitated by the `local-install` script, which may be triggered via curl:

```bash
curl https://raw.githubusercontent.com/rcwbr/dotfiles/refs/tags/0.3.0/local-install | bash
```

To apply a version of this repo other than the default branch, `local-install` may be invoked with
the `DOTFILES_VERSION` variable set to a git reference. For example, to apply dotfiles from a
release tag:

```bash
export DOTFILES_VERSION=0.3.0
curl https://raw.githubusercontent.com/rcwbr/dotfiles/refs/tags/0.3.0/local-install | bash
```

To update the version of the dotfiles applied to a local environment,
[use the dotfiles updater](#dotfiles-updater-usage).

The `local-install` tool clones this repo to `~/.dotfiles`. To clone and configure from another
location, simply `git clone` this repo and run the `./install` script manually from that location.

### GitHub Codespaces<a name="github-codespaces"></a>

Follow
[these instructions](https://docs.github.com/en/codespaces/setting-your-user-preferences/personalizing-github-codespaces-for-your-account#enabling-your-dotfiles-repository-for-codespaces)
to configure Codespaces to use this repo.

> 1. In the upper-right corner of any page on GitHub, click your profile photo, then click Settings.
> 1. In the "Code, planning, and automation" section of the sidebar, click Codespaces.
> 1. Under "Dotfiles", select Automatically install dotfiles so that GitHub Codespaces automatically
>    installs your dotfiles into every new codespace you create.
> 1. Use the dropdown to choose the repository you want to install dotfiles from.

Codespaces will start with a clone of the default branch of this repo, and
[will execute the `install` script](https://docs.github.com/en/codespaces/setting-your-user-preferences/personalizing-github-codespaces-for-your-account#dotfiles)
to load files into the environment. The `DOTFILES_VERSION` variable is not applicable in this
context.

### VSCode devcontainers<a name="vscode-devcontainers"></a>

VSCode editors on the host system will leverage this repo if configured per the
[Local usage](#local). To configure this repo as dotfiles for VSCode _devcontainers_, follow these
steps:

1. Open Preferences: Open User Settings
1. Search for "dotfiles"
1. In the `Dotfiles: Repository` field, paste this repo's URL:
   `https://github.com/rcwbr/dotfiles.git`
1. (Optional) Set the `Dotfiles: Target Path` field to `~/.dotfiles` for consistency with
   [Local usage](#local)
1. Restart any running devcontainers for this change to take effect

> :warning: Note that if a devcontainer mounts its user's home directory (as a bind or a volume),
> VSCode will not be able to automatically clone the repo fresh on each restart, and
> [the `dotfiles_update` tool must be used](#dotfiles-updater-usage).

> :warning: The `DOTFILES_VERSION` variable is not applicable in this context.

### Dotfiles updater usage<a name="dotfiles-updater-usage"></a>

Most environments for dotfiles are short-lived and manual updating is not necessary. However,
dotfile applications to local host systems, dotfiles may become out of date and require updating. To
assist with this, the `install` script prepares a `dotfiles_update` executable to pull repo updates
and apply.

> :warning: The `dotfiles_update` tool is prepared in the `~/.local/bin` directory. If this is not
> added to the `PATH` variable by system configuration or dotfiles, it will not be found as a
> command. However, it may always be invoked as `~/.local/bin/dotfiles_update`

```bash
# Update dotfiles to the latest of the version ref initially applied:
dotfiles_update
```

The `dotfiles_update` tool can be instructed to retrieve a specific version of the dotfiles repo,
using the `DOTFILES_VERSION` variable. For example, to pin to a release tag:

```bash
export DOTFILES_VERSION=0.3.0
dotfiles_update
```

### Modifying dotfiles<a name="modifying-dotfiles"></a>

To modify dotfiles from any envrionment, start by simply making the changes as you would normally.
Since files are symlinked from the home directory, your changes will be reflected in the local clone
of this repo. Then, navigate to the repo (usually `~/.dotfiles`), create a branch, commit, and push.
For example, to update `~/.aliases.sh`:

```bash
code ~/.aliases.sh # Edit aliases
cd ~/.dotfiles
git checkout -b update-aliases
git add dotfiles
git commit -m "feat: add alias for new function"
git push
```

To add a new dotfile, similarly create the file as usual, but before adding files for commit, copy
the file to the dotfiles subdirectory. For example, to add a `~/.gitconfig` file:

```bash
cp ~/.gitconfig ~/.dotfiles/dotfiles
```

## VSCode settings usage<a name="vscode-settings-usage"></a>

While settings for VSCode are tracked in this repo, they are not configured via dotfiles mechanism.
Instead, [VSCode Settings Sync](https://code.visualstudio.com/docs/editor/settings-sync) is used to
maintain consistent settings across environments.

To apply the settings tracked in this repo to settings sync, first follow configuration
[for VSCode](#vscode-settings-sync-configuration) or
[for Codespaces](#codespaces-settings-sync-configuration). Then, manually copy the content from this
repo into the relevant configuration:

1. Open `Preferences: Open User Settings (JSON)` and paste in the contents of
   `.vscode/user-settings.json`
1. Open `Preferences: Open Keyboard Shortcuts (JSON)` and paste in the contents of
   `.vscode/user-keybindings.json`

Vice-versa, to update tracked settings or keybindings from the current synced state, open the JSON
preferences and copy their content to the respective repo files.

### VSCode settings sync configuration<a name="vscode-settings-sync-configuration"></a>

To configure settings sync in a local environment, follow
[the steps described in the guide](https://code.visualstudio.com/docs/editor/settings-sync), and log
in using GitHub.

### Codespaces settings sync configuration<a name="codespaces-settings-sync-configuration"></a>

To configure settings sync in Codespaces, follow
[the steps described in the guide](https://docs.github.com/en/codespaces/setting-your-user-preferences/personalizing-github-codespaces-for-your-account#settings-sync),
and log in using GitHub.

## Contributing<a name="contributing"></a>

### devcontainer<a name="devcontainer"></a>

This repo contains a [devcontainer definition](https://containers.dev/) in the `.devcontainer`
folder. It leverages the
[devcontainer cache build tool](https://github.com/rcwbr/devcontainer-cache-build) and
[layers defined in the dockerfile-partials repo](https://github.com/rcwbr/dockerfile-partials).

#### devcontainer basic usage<a name="devcontainer-basic-usage"></a>

The [devcontainer cache build tool](https://github.com/rcwbr/devcontainer-cache-build) requires
[authentication to the GitHub container registry](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry#authenticating-to-the-container-registry).

#### devcontainer Codespaces usage<a name="devcontainer-codespaces-usage"></a>

For use with Codespaces, the `*_CONTAINER_REGISTRY_*` GHCR access credentials must be stored as
Codespaces secrets (see
[instructions](https://github.com/rcwbr/devcontainer-cache-build/?tab=readme-ov-file#initialize-script-github-container-registry-setup)),
as must values for `USER`, and `UID` (see
[useradd Codespaces usage](https://github.com/rcwbr/dockerfile-partials/blob/main/README.md#useradd-codespaces-usage)).

#### devcontainer pre-commit usage<a name="devcontainer-pre-commit-usage"></a>

By default, the devcontainer configures [pre-commit](https://pre-commit.com/) hooks in the
repository to ensure commits pass basic testing. This includes enforcing
[conventional commit messages](https://www.conventionalcommits.org/en/v1.0.0/) as the standard for
this repository, via [commitlint](https://github.com/conventional-changelog/commitlint).

### CI/CD<a name="cicd"></a>

This repo uses the [release-it-gh-workflow](https://github.com/rcwbr/release-it-gh-workflow), with
the file-bumper image defined as its automation.

It leverages the
[devcontainer-cache-build workflow](https://github.com/rcwbr/devcontainer-cache-build/blob/main/.github/workflows/devcontainer-cache-build.yaml)
to pre-generate devcontainer images, which are also used for the linting enforcement
[pre-commit workflow](https://github.com/rcwbr/dockerfile-partials/blob/main/.github/workflows/pre-commit.yaml).

### Settings<a name="settings"></a>

The GitHub repo settings for this repo are defined as code using the
[Probot settings GitHub App](https://probot.github.io/apps/settings/). Settings values are defined
in the `.github/settings.yml` file. Enabling automation of settings via this file requires
installing the app.

The settings applied are as recommended in the
[release-it-gh-workflow usage](https://github.com/rcwbr/release-it-gh-workflow/blob/4dea4eaf328b60f92dab1b5bd2a63daefa85404b/README.md?plain=1#L58),
including tag and branch protections, GitHub App and environment authentication, and required
checks.
