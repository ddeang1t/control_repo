class minecraft {
  file {'/opt/minecraft':
    ensure => directory,
  }
  file { '/opt/minecraft/server.jar':
    ensure => file,
    source => 'https://piston-data.mojang.com/v1/objects/8f3112a1049751cc472ec13e397eade5336ca7ae/server.jar',
    before => Service['minecraft'],
  }
  package {'java':
    ensure => present,
  }
  file {'/opt/minecraft/eula.txt':
    ensure => file,
    content => 'eula=true',
  }
  file {'/etc/systemd/system/minecraft.service':
    ensure => file,
    source => 'puppet:///modules/minecraft/minecraft.service',
  }
  file {'/opt/minecraft/jdk19install':
    ensure => file,
    source => 'puppet:///modules/minecraft/jdk19install',
    mode => '0755',
    before => Service['minecraft'],
  }
  exec {'jdk19install':
    command => '/opt/minecraft/jdk19install',
    before => Service['minecraft'],
  }
  service {'minecraft':
    ensure => running,
    enable => true,
    require => [Package['java'],File['/opt/minecraft/eula.txt'],File['/etc/systemd/system/minecraft.service'],File['/opt/minecraft/jdk19install']],
  }
}
  
