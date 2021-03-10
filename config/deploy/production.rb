#FIXME replace 1.2.3.4 with your IP address
server '15.237.108.77', user: 'ubuntu', roles: %w[web app db]
set :rails_env, 'production'