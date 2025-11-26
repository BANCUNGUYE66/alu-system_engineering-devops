# This manifest fixes the 500 Internal Server Error caused by incorrect file permissions
# on the web server's application root.

file { '/var/www/html':
  # Ensure the directory exists
  ensure  => directory,
  # Change the owner to the standard Apache user for Ubuntu
  owner   => 'www-data',
  # Change the group to the standard Apache group
  group   => 'www-data',
  # Apply the change recursively to all files and subdirectories
  recurse => true,
}
