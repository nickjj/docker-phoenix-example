# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a
Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

### Changed

- `tailwind.config.js` now uses `'/app/lib/hello_web/**/*.*ex'` to match Elixir and all template types

#### Languages and services

- Update `Elixir` to `1.12.2`

#### Back-end dependencies

- Update `ecto_sql` to `3.7.0`
- Update `excoveralls` to `0.14.2`
- Update `phoenix_ecto` to `4.4.0`
- Update `phoenix_html` to `3.0.2`
- Update `phoenix_live_dashboard` to `0.5.0`
- Update `phoenix_live_reload` to `1.3.3`
- Update `phoenix_live_view` to `0.16.0`
- Update `phoenix` to `1.5.11`
- Update `plug_cowboy` to `2.5.1`
- Update `telemetry_metrics` to `0.6.1`

#### Front-end dependencies

- Update `@babel/core` to `7.15.0`
- Update `@babel/preset-env` to `7.15.0`
- Update `@babel/register` to `7.15.3`
- Update `autoprefixer` to `10.3.1`
- Update `copy-webpack-plugin` to `9.0.1`
- Update `css-loader` to `6.2.0`
- Update `css-minimizer-webpack-plugin` to `3.0.2`
- Update `mini-css-extract-plugin` to `2.2.0`
- Update `phoenix_live_view` to `0.16.0`
- Update `phoenix` to `1.5.11`
- Update `postcss-loader` to `6.1.1`
- Update `postcss` to `8.3.6`
- Update `tailwindcss` to `2.2.7`
- Update `webpack-cli` to `4.8.0`
- Update `webpack` to `5.51.1`

## [0.2.0] - 2021-06-18

### Added

- `bin/rename-project` script to assist with renaming the project

### Changed

- Use the Docker Compose spec in `docker-compose.yml` (removes `version:` property)
- Update Tailwind from `2.1.1` to `2.2.2`
- Update all Webpack related dependencies to their latest versions
- Update Elixir from `1.11.4` to `1.12.1`
- Update PostgreSQL from `13.2` to `13.3`
- Update `phoenix` from `1.5.8` to `1.5.9`
- Update `ecto_sql` from `3.6.0` to `3.6.2`
- Update `floki` from `0.27.x` to `0.31.x`
- Update `plug_cowboy` from `2.4.1` to `2.5.0`
- Update `postgrex` from `0.15.8` to `0.15.9`
- Update `excoveralls` from `0.14.0` to `0.14.1`
- Update `credo` from `1.5.5` to `1.5.6`
- Update `phoenix_live_view` from `0.15.4` to `0.15.7`

## [0.1.0] - 2021-04-15

### Added

- Everything!

[Unreleased]: https://github.com/nickjj/docker-phoenix-example/compare/0.2.0...HEAD
[0.2.0]: https://github.com/nickjj/docker-phoenix-example/compare/0.1.0...0.2.0
[0.1.0]: https://github.com/nickjj/docker-phoenix-example/releases/tag/0.1.0
