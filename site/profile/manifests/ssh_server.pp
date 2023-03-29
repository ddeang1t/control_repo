class profile::ssh_server {
  package {'openssh-server':
    ensure => present,
  }
  service { 'sshd':
    ensure => 'running',
    enable => 'true',
  }
  ssh_authorized_key { 'root@master.puppet.vm':
    ensure => present,
    user   => 'root',
    type   => 'ssh-rsa',
    key    => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCdAIwvseyS9RbOnnE21kXBSvsli1fjE9okMnmDecBVQ5KGmVb724Pd8sOuskGEU1llQtW4ELaqadwnmbilIRDG5cS3qb2o6yVEE1DI6ADvadDU3V5hCYnqbVYjT/cYCIFCQhZJvUCEsa8Zbb5nGhYITuHGtwIm/bB4w5XwIu3aMdmeePX5qoCqdL9VvBS9mE9P1jLn9gqEn3wCGW6NvZcj07mq2T3IZOxn5+Q5pOl/19DFDwr6YbOr/R9/9uTdWjgSHnoDIdIttWJfA/YNLwsfYilm707FTj+hI7EpwxY5iLkbvJ4Ecc5xgCqtG6QThfDnWhKh80bWihbKhq8+kXhh',
  }
}
