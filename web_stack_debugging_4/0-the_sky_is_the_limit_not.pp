# This manifest fixes the Nginx high concurrency failure by increasing resource limits.

# 1. Increase the worker file resource limit (worker_rlimit_nofile)
# This allows Nginx to handle more file descriptors/connections system-wide.
file_line { 'nginx-file-limit':
  ensure => present,
  path   => '/etc/nginx/nginx.conf',
  # The default is usually below 1024; we set it high.
  line   => 'worker_rlimit_nofile 40000;',
  after  => 'worker_processes auto;',
}

# 2. Increase the maximum connections per worker (worker_connections)
# This controls the max connections a single worker process can handle.
file_line { 'nginx-worker-connections':
  ensure => present,
  path   => '/etc/nginx/nginx.conf',
  # We find the 'events' block and replace the connection limit inside it.
  line   => '    worker_connections 40000;',
  match  => '    worker_connections 768;', # Assuming default Ubuntu value is 768 or similar
  after  => 'events {',
}

# 3. Ensure the fix takes effect by restarting Nginx
exec { 'nginx-restart':
  command => '/etc/init.d/nginx restart',
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  require => [
      File_line['nginx-file-limit'], 
      File_line['nginx-worker-connections']
  ],
}
