# Execute command from the app container by the current user
alias dapi='docker-compose exec --user "$(id -u):$(id -g)" api'

# Execute command from specified container
alias df='docker-compose exec'

# Execute command from specified container by the current user
alias down='docker-compose exec --user "$(id -u):$(id -g)"'

# Run artisan commands
alias da='docker-compose exec --user "$(id -u):$(id -g)" api php artisan'

# Testing aliases
alias dt='docker-compose exec app vendor/bin/pest'
alias dtf='docker-compose exec app vendor/bin/pest --filter'
