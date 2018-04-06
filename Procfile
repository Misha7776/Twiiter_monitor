release: bundle exec rake: db:migrate
web: bundle exec puma -t 5:5 -p ${PORT:-300} -e ${RACK_ENV:-development}
sidekiq: bundle exec sidekiq
