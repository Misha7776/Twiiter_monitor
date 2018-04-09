web: bundle exec puma -t 5:5 -p ${PORT:-300} -e ${RACK_ENV:-development}
release: bundle exec rake db:migrate
worker: bundle exec sidekiq -e production -c 3
