# rcwbr dotfiles<a name="rcwbr-dotfiles"></a>

[dotfiles](https://dotfiles.github.io/) for environment personalization

<!-- mdformat-toc start --slug=github --maxlevel=6 --minlevel=1 -->

- [rcwbr dotfiles](#rcwbr-dotfiles)
  - [Usage](#usage)
    - [Local](#local)
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
curl https://raw.githubusercontent.com/rcwbr/dotfiles/refs/tags/0.1.0/local-install | bash
```

To apply a version of this repo other than the default branch, `local-install` may be invoked with
the `DOTFILES_VERSION` variable set to a git reference. For example, to apply dotfiles from a
release tag:

```bash
export DOTFILES_VERSION=0.1.0
curl https://raw.githubusercontent.com/rcwbr/dotfiles/refs/tags/0.1.0/local-install | bash
```

To update the version of the dotfiles applied to a local environment,
[use the dotfiles updater](#dotfiles-updater-usage).

The `local-install` tool clones this repo to `~/.dotfiles`. To clone and configure from another
location, simply `git clone` this repo and run the `./install` script manually from that location.

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
