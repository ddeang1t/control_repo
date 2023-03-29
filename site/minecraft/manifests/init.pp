class minecraft (
  $url = 'https://piston-data.mojang.com/v1/objects/8f3112a1049751cc472ec13e397eade5336ca7ae/server.jar',
  $install_dir = '/opt/minecraft'
){
  file { $install_dir:
    ensure => directory,
  }
  file { "${install_dir}/server.jar":
    ensure => file,
    source => $url,
    before => Service['minecraft'],
  }
  package {'java':
    ensure => present,
  }
  file {"${install_dir}/eula.txt":
    ensure => file,
    content => 'eula=true',
  }
  file {'/etc/systemd/system/minecraft.service':
    ensure => file,
    content => epp('minecraft/minecraft.service',{
      install_dir => $install_dir,
    })
  }
  file {"${install_dir}/jdk19install":
    ensure => file,
    source => 'puppet:///modules/minecraft/jdk19install',
    mode => '0755',
    before => Service['minecraft'],
  }
  exec {'jdk19install':
    command => "${install_dir}/jdk19install",
    before => Service['minecraft'],
  }
  service {'minecraft':
    ensure => running,
    enable => true,
    require => [Package['java'],File["${install_dir}/eula.txt"],File['/etc/systemd/system/minecraft.service'],File["${install_dir}/jdk19install"]],
  }
}
  
