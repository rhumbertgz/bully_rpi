use Mix.Config
config :logger, level: :debug

import_config "#{Mix.Project.config[:target]}.exs"
