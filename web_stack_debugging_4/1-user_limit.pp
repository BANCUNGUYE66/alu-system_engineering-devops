# This manifest fixes the 'Too many open files' error for the holberton user
# by increasing the hard and soft file descriptor limits.

file_line { 'holberton_soft_limit':
  ensure => present,
  path   => '/etc/security/limits.conf',
  # Set the soft limit for nofile to 10000
  line   => 'holberton soft nofile 10000',
  match  => '^holberton soft nofile',
}

file_line { 'holberton_hard_limit':
  ensure => present,
  path   => '/etc/security/limits.conf',
  # Set the hard limit for nofile to 10000
  line   => 'holberton hard nofile 10000',
  match  => '^holberton hard nofile',
  require => File_line['holberton_soft_limit'],
}

# The challenge implies a system-wide fix, so we also ensure the limits are applied
# to the session login (usually managed by /etc/pam.d/common-session or similar)
exec { 'apply-limits':
  command => 'sysctl -p',
  path    => ['/usr/bin', '/bin'],
  # This Exec requires the limits.conf file changes to be effective first.
  require => File_line['holberton_hard_limit'],
}
