class minecraft {
  file {'/opt/minecraft':
    ensure => directory,
  }
  file { '/opt/minecraft/server.jar':
    ensure => file,
    source => 'https://piston-data.mojang.com/v1/objects/8f3112a1049751cc472ec13e397eade5336ca7ae/server.jar',
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
  }
  exec {'jdk19install':
    command => '/opt/minecraft/jdk19install',
  }
  service {'minecraft':
    ensure => running,
    enable => true,
  }
}
  
