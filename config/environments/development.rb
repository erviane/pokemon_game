require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Make code changes take effect immediately without server restart.
  config.enable_reloading = true
  config.eager_load = false
  config.consider_all_requests_local = true
  config.server_timing = true

  # Enable/disable Action Controller caching. Run rails dev:cache to toggle.
  if Rails.root.join("tmp/caching-dev.txt").exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true
    config.public_file_server.headers = { "cache-control" => "public, max-age=#{2.days.to_i}" }
  else
    config.action_controller.perform_caching = false
  end
  config.cache_store = :memory_store

  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
  config.action_mailer.default_url_options = { host: "localhost", port: 3000 }

  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.active_record.verbose_query_logs = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  config.action_view.annotate_rendered_view_with_filenames = true

  # Fail loudly on a missing translation instead of rendering "Translation missing".
  config.i18n.raise_on_missing_translations = true
end
