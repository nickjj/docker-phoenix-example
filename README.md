# An example Phoenix + Docker app

![CI](https://github.com/nickjj/docker-phoenix-example/workflows/CI/badge.svg?branch=main)

You could use this example app as a base for your new project or as a guide to
Dockerize your existing Phoenix app.

The example app is minimal but it wires up a number of things you might use in
a real world Phoenix app, but at the same time it's not loaded up with a
million personal opinions.

For the Docker bits, everything included is an accumulation of Docker best
practices based on building and deploying dozens of assorted Dockerized web
apps since late 2014.

**This app is using Phoenix 1.5.8 and Elixir 1.11.4**. The screenshot doesn't get
updated every time I bump the versions:

[![Screenshot](.github/docs/screenshot.jpg)](https://github.com/nickjj/docker-phoenix-example/blob/main/.github/docs/screenshot.jpg?raw=true)

## Table of contents

- [Tech stack](#tech-stack)
- [Notable opinions and extensions](#notable-opinions-and-extensions)
- [Running this app](#running-this-app)
- [Files of interest](#files-of-interest)
  - [`.env`](#env)
  - [`run`](#run)
- [Making this app your own](#making-this-app-your-own)
- [Updating dependencies](#updating-dependencies)
- [See a way to improve something?](#see-a-way-to-improve-something)
- [Additional resources](#additional-resources)
  - [Learn more about Docker and Phoenix](#learn-more-about-docker-and-phoenix)
  - [Deploy to production](#deploy-to-production)
- [About the author](#about-the-author)

## Tech stack

If you don't like some of these choices that's no problem, you can swap them
out for something else on your own.

### Back-end

- [PostgreSQL](https://www.postgresql.org/)

### Front-end

- [Webpack](https://webpack.js.org/)
- [TailwindCSS](https://tailwindcss.com/)
- [Heroicons](https://heroicons.com/)

#### But what about JavaScript?!

Picking a JS library is a very app specific decision because it depends on
which library you like and it also depends on if your app is going to be
mostly EEx templates with sprinkles of JS or an API back-end.

This isn't an exhaustive list but here's a few reasonable choices depending on
how you're building your app:

- <https://stimulus.hotwire.dev/>
- <https://github.com/alpinejs/alpine>
- <https://vuejs.org/>
- <https://reactjs.org/>
- <https://jquery.com/>

On the bright side with Webpack being set up you can use any (or none) of these
solutions very easily. You could follow a specific library's Webpack
installation guides to get up and running in no time.

Personally I'm going to be using LiveView with StimulusJS in most newer
projects.

## Notable opinions and packages

Phoenix is a healthy mix of being both opinionated and unopinionated but I
find in most apps I'm adding the same things over and over. Here's a few note
worthy additions and changes.

- **Mix and releases**:
    - When `MIX_ENV` is set to `dev` then the server will be run with mix
    - When `MIX_ENV` is set to `prod` a release will be built and used to run your server
    - All of this is automated through a multi-stage Dockerfile and build ARGs
- **Static analysis and testing**:
    - *[credo](https://github.com/rrrene/credo)* helps create more consistent code
    - *[excoveralls](https://github.com/parroty/excoveralls)* for getting detailed test coverge reports
- **Controllers**:
    - Add `page` controller to render a `/` page and `/up` health check endpoint
- **Views**:
    - Add `view_helpers` to store shared view helpers (such as the `flash_class` function that's included)
- **Config**:
    - Extract a bunch of configuration settings into environment variables
    - The `.env` file stores all environment variables
    - Put all config settings with environment variables in `config/runtime.exs` (works with releases)
- **Phoenix defaults that are changed**:
    - Cookies are encrypted
    - A `lib/hello/release.ex` module has been added to run migrations with releases
    - `.formatter.exs` has been configured to use 80 character line lengths
    - An empty `.iex.exs` file has been created so you can customize your IEx sessions however you see fit
    - The project was generated with `--live` but the `live/` directory was removed
    - Both regular and live view flash messages are set up to use a for comprehension
    - CSS, JS and image links are referenced with `Routes.static_url` to support optionally using a CDN
    - Webpack's watcher is handled by Webpack directly
- **Front-end assets**:
    - Custom `502.html` and `maintenance.html` pages
    - Generate favicons using modern best practices

Besides the Elixir / Phoenix app itself:

- Docker support has been added which would be any files having `*docker*` in
  its name
- GitHub Actions have been set up

## Running this app

You'll need to have [Docker installed](https://docs.docker.com/get-docker/).
It's available on Windows, macOS and most distros of Linux. If you're new to
Docker and want to learn it in detail check out the [additional resources
links](#learn-more-about-docker-and-phoenix) near the bottom of this
README.

If you're using Windows, it will be expected that you're following along inside
of [WSL or WSL
2](https://nickjanetakis.com/blog/a-linux-dev-environment-on-windows-with-wsl-2-docker-desktop-and-more).
That's because we're going to be running shell commands. You can always modify
these commands for PowerShell if you want.

#### Clone this repo anywhere you want and move into the directory:

```sh
git clone https://github.com/nickjj/docker-phoenix-example hellophoenix
cd hellophoenix

# Optionally checkout a specific tag, such as: git checkout 0.1.0
```

#### Copy a few example files because the real files are git ignored:

```sh
cp .env.example .env
cp docker-compose.override.yml.example docker-compose.override.yml
```

#### Build everything:

*The first time you run this it's going to take 5-10 minutes depending on your
internet connection speed and computer's hardware specs. That's because it's
going to download a few Docker images and build the Elixir + Yarn dependencies.*

```sh
docker-compose up --build
```

Now that everything is built and running we can treat it like any other Phoenix
app.

Did you receive an error about a port being in use? Chances are it's because
something on your machine is already running on port 8000. Check out the docs
in the `.env` file for the `DOCKER_WEB_PORT_FORWARD` variable to fix this.

#### Check it out in a browser:

Visit <http://localhost:8000> in your favorite browser.

Not seeing any CSS? That means Webpack is still compiling. Give it
a few more seconds and reload. It should self resolve.

#### Formatting your code base:

```sh
# You can check to see if any code is not formatted correctly.
./run format:check

# You can also auto-fix any malformed code (both commands call mix format).
./run format
```

*We'll go over that ./run script in a bit!*

#### Analyzing your code base:

```sh
# You should get a report back saying there's no issues.
./run credo
```

#### Running the test suite:

```sh
# You should see all passing tests. Warnings are typically ok.
./run test

# You can also get test coverage by running coveralls.
./run coveralls
```

#### Stopping everything:

```sh
# Stop the containers and remove a few Docker related resources associated to this project.
docker-compose down
```

You can start things up again with `docker-compose up` and unlike the first
time it should only take seconds.

## Files of interest

I recommend checking out most files and searching the code base for `TODO:`,
but please review the `.env` and `run` files before diving into the rest of the
code and customizing it. Also, you should hold off on changing anything until
we cover how to customize this example app's name with an automated script
(coming up next in the docs).

### `.env`

This file is ignored from version control so it will never be commit. There's a
number of environment variables defined here that control certain options and
behavior of the application. Everything is documented there.

Feel free to add new variables as needed. This is where you should put all of
your secrets as well as configuration that might change depending on your
environment (specific dev boxes, CI, production, etc.).

### `run`

You can run `./run` to get a list of commands and each command has
documentation in the `run` file itself.

It's a shell script that has a number of functions defined to help you interact
with this project. It's basically a `Makefile` except with less limitations.
For example as a shell script it allows us to pass any arguments to another
program.

This comes in handy to run various Docker commands because sometimes these
commands can be a bit long to type. Feel free to add as many convenience
functions as you want. This file's purpose is to make your experience better!

*If you get tired of typing `./run` you can always create a shell alias with
`alias run=./run` in your `~/.bash_aliases` or equivalent file. Then you'll be
able to run `run` instead of `./run`.*

## Making this app your own

The app is named `hello` right now but chances are your app will be a different
name. Since the app is already created we'll need to do a find / replace on a
few variants of the string "hello" and update a few Docker related resources.

You can do that from the command line without needing to install any extra
dependencies by following the instructions below.

#### Remove the original Docker resources:

When the hello app was first upped with Docker Compose a new database, user and
password was created automatically based on the values of certain environment
variables.

Along with that a few Docker resources were created too. Those need to be
updated. The easiest way to do that is by removing the old Docker resources and
deleting the database. We can do all of that in 1 command.

*Don't worry, you won't have to wait 5-10 minutes again when you up your newly
named project. Docker still has that information safely tucked away and it can
be re-used in projects with different names.*

```sh
# This removes the PostgreSQL database volume along with a few other Docker
# resources that were created and are associated to the hello app.
docker-compose down -v
```

#### Run the customize script included in this repo:

You should run [this
script](https://github.com/nickjj/docker-phoenix-example/blob/main/run) from
inside of this git repo. It's going to:

- Perform a number of find / replace actions
- Optionally initialize a new git repo for you

*Afterwards you can delete this script because its only purpose is to assist in
helping you customize this project's name without depending on any complicated
project generator tools or 3rd party dependencies.*

```sh
# The script takes 2 arguments.
#
# The first one is the lower case version of your app's name, such as myapp or
# my_app depending on your preference.
#
# The second one is used for your app's module name. For example if you used
# myapp or my_app for the first argument you would want to use MyApp here.
./customize myapp MyApp
```

If you're not comfy running the script or it doesn't work for whatever reasons
you can [check it
out](https://github.com/nickjj/docker-phoenix-example/blob/main/run) and
perform the actions manually. It's mostly running a find / replace across files
and then renaming a few directories and files.

#### Start and setup the project:

This won't take as long as before because Docker can re-use most things.

```sh
docker-compose up --build
```

#### Sanity check to make sure everything is formatted and the tests still pass:

It's always a good idea to make sure things are in a working state before
adding custom changes.

```sh
# You can run this from the same terminal as before.
./run format
./run credo
./run test
```

If everything passes now you can optionally `git add -A && git commit -m
"Initial commit"` and start customizing your app. Alternatively you can wait
until you develop more of your app before committing anything. It's up to you!

#### Tying up a few loose ends:

You'll probably want to create a fresh `CHANGELOG.md` file for your project. I
like following the style guide at <https://keepachangelog.com/> but feel free
to use whichever style you prefer.

Since this project is MIT licensed you should keep my name and email address in
the `LICENSE` file to adhere to that license's agreement, but you can also add
your name and email on a new line.

If you happen to base your app off this example app or write about any of the
code in this project it would be rad if you could credit this repo by linking
to it. If you want to reference me directly please link to my site at
<https://nickjanetakis.com>. You don't have to do this, but it would be very
much appreciated!

## Updating dependencies

Let's say you've customized your app and it's time to make a change to your
`mix.exs` or `package.json` file.

Without Docker you'd normally run `mix deps.get` or `yarn install`. With Docker
it's basically the same thing and since these commands are in our `Dockerfile`
we can get away with doing a `docker-compose build` but don't run that just
yet.

#### In development:

You can run `./run mix:outdated` or `./run yarn:outdated` to get a list of
outdated dependencies based on what you currently have installed. Once you've
figured out what you want to update, go make those updates in your `mix.exs`
and / or `assets/package.json` file.

Then to update your dependencies you can run `./run mix:install` or `./run
yarn:install`. That'll make sure any lock files get copied from Docker's image
(thanks to volumes) into your code repo and now you can commit those files to
version control like usual.

You can check out the
[run](https://github.com/nickjj/docker-phoenix-example/blob/main/run) file to see
what these commands do in more detail.

#### In CI:

You'll want to run `docker-compose build` since it will use any existing lock
files if they exist. You can also check out the complete CI test pipeline in
the [run](https://github.com/nickjj/docker-phoenix-example/blob/main/run) file
under the `ci:test` function.

#### In production:

This is usually a non-issue since you'll be pulling down pre-built images from
a Docker registry but if you decide to build your Docker images directly on
your server you could run `docker-compose build` as part of your deploy
pipeline.

## See a way to improve something?

If you see anything that could be improved please open an issue or start a PR.
Any help is much appreciated!

## Additional resources

Now that you have your app ready to go, it's time to build something cool! If
you want to learn more about Docker, Phoenix and deploying a Phoenix app here's
a couple of free and paid resources. There's Google too!

### Learn more about Docker and Phoenix

#### Official documentation 

- <https://docs.docker.com/>
- <https://hexdocs.pm/phoenix/Phoenix.html>

#### Courses

- [https://diveintodocker.com](https://diveintodocker.com?ref=docker-phoenix-example)
  is a course I created which goes over the Docker and Docker Compose
  fundamentals

### Deploy to production

I'm creating an in-depth course related to deploying Dockerized web apps. If
you want to get notified when it launches with a discount and potentially get
free videos while the course is being developed then [sign up here to get
notified](https://nickjanetakis.com/courses/deploy-to-production).

## About the author

- Nick Janetakis | <https://nickjanetakis.com> | [@nickjanetakis](https://twitter.com/nickjanetakis)

I'm a self taught developer and have been freelancing for the last ~20 years.
You can read about everything I've learned along the way on my site at
[https://nickjanetakis.com](https://nickjanetakis.com/).

There's hundreds of [blog posts / videos](https://nickjanetakis.com/blog/) and
a couple of [video courses](https://nickjanetakis.com/courses/) on web
development and deployment topics. I also have a
[podcast](https://runninginproduction.com) where I talk with folks about
running web apps in production.
