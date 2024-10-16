# TimeManager

Welcome to the Time Manager API project.
This API is built using the Phoenix framework and is designed to provide a platform-independent solution for exchanging and storing data related to users, clocks, and working times.

Elixir: Version 1.12+ is required. Install it here.
PostgreSQL: The database used for this project is PostgreSQL. Ensure you have it installed and configured locally.



## To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).


## Commandes

  * Install dependencies from the mix.exs file or after modifying this file
  `mix deps.get`
  * Set up the database
  `mix ecto.create`
  `mix ecto.migrate`
  * Resolving database conflicts 
  `mix ecto.reset`
  * Run tests 
  `mix test`

## Docker Commands

 *Dans le dossier time_manager
  - docker-compose up --build

(pensez à modifier les infos postegres dans le fichier docker-compose.yml)


## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

