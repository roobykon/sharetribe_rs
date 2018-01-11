set :stage, :staging
set :rails_env, "staging"

set :branch, ENV['BRANCH'] || "master"
set :deploy_to, "/home/sharetribe/web/sharetribe-rs.roobykon.com"

append :linked_files, "config/database.yml", "config/config.yml", "config/staging.sphinx.conf", "config/puma.rb"
append :linked_dirs, "db/sphinx", "node_modules", "client/node_modules", "app/assets/webpack", "app/assets/javascripts/i18n", "client/app/i18n", "client/app/route", "public/assets", "public/webpack", "public/system", "log", "tmp"

server 'sharetribe-rs.roobykon.com', port: 22, user: 'sharetribe', roles: %w{app web db}
