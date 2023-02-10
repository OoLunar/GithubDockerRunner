# Github Docker Runner
Runs the Github Actions Runner in a Docker image.

# Setup
To install a new runner, you'll need a Github Runner token (which expire an hour after creation!) and the https link to the repository you want to run the runner on. Once you've copied and pasted the two variables into the `docker-compose.yml` file, you can run the following command to start the runner:

    docker-compose up -d

Because the runner is running in a Docker container, you can run it on any machine that supports Docker. This means you can run it on a Raspberry Pi, a VPS, or even a local machine. The sole requirement of this tool is that there is a Docker volume mounted to the `/home/runner` directory, **otherwise the Github Runner will not be able to persist its data and you will have to reconfigure with a new Github Runner token every time you restart the container.**

## Obtaining the token
You can get the token from the repository settings page, under Settings > Actions > Runners. Select "create a new runner", and copy the token provided at the very bottom.

## Obtaining the repository URL
The repository URL can be found on the same line as the Github Runner token from the previous step. If you still cannot find it, you can copy and paste the link to your repository from the browser:

- `https://github.com/OoLunar/GithubDockerRunner`
- `https://github.com/<username>/<repository>`

Note that the repository URL must be the HTTPS link, not the SSH link. Additionally note how the repository URL does not contain the `.git` extension.

## Runner name
The Github runner registers itself using the hostname of the machine it is running on. If you want to change the name of the runner, you can do so by changing the hostname of the container. In the `docker-compose.yml`, change the `hostname` field to whatever you want the runner to be named. By default it is `docker_runner`. If there is already a runner with the same name, the runner will replace the existing runner with itself.

# Running
Once you've configured the `docker-compose.yml` file, you can run the following command to start the runner:

    docker-compose up -d

The runner will go download the 2.300 version of the Github Runner only once, and then start running. You can check the status of the runner by running the following command:

    docker-compose logs

You may also remove the `GITHUB_TOKEN` and `GITHUB_REPOSITORY` environment variables in the `docker-compose.yml` file as they are only required for the initial setup/first run.

# Using Docker in the runner
To use Docker inside of a Docker container, you first must add a volume to the Docker socket. This can be done by adding the following line to the `volumes` section of the `docker-compose.yml` file:

    - /var/run/docker.sock:/var/run/docker.sock

# Updating
The Github Runner has an auto-updater built in and updates itself automatically. Whenever a new version of the Github Runner is released, the runner will update itself and exit the application, causing the container to restart due to the `unless-stopped` policy.

# Credits
This repository uses the LGPL-3.0 license, which can be found in the `LICENSE` file. This repository was created by [OoLunar](https://github.com/OoLunar) and was tested by [InFTord](https://github.com/InFTord).