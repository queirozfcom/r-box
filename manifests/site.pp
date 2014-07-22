
$username = 'vagrant'

Exec { 
  path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/","/usr/local/bin" ]
} 

# a command to run system updates
exec { 'sys_update':
  command => "apt-get update --fix-missing",
}

class git {
  package{'git-core':
    ensure => 'installed',
    require => Exec['sys_update'],
  }
}

class basic_gui{
  package{'xfce':
    require => Exec['sys_update'],
    ensure => 'installed'       
  } ->
  package {'lightdm':
    ensure => 'installed',    
  } ->
  package {'lightdm-gtk-greeter':
    ensure => 'installed',
  } ->
  file {'/etc/lightdm/lightdm.conf':
    ensure => 'present',
    owner => 'root',
    content => "[SeatDefaults] \n greeter-session=lightdm-gtk-greeter\n",
  } ->
  service {'lightdm':
    ensure => 'running',
    enable => true,
  } 
}

class fix_broken{
  exec{'fix-broken-command':
    command => 'apt-get -f install --assume-yes',
  }
}

class chrome{
  require fix_broken
  exec{'download chrome deb':
    command => 'wget https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb',
    cwd => "/home/${username}",
    creates => "/home/${username}google-chrome-stable_current_i386.deb",
  } ->
  exec{'install chrome':
    command => 'dpkg -i google-chrome-stable_current_i386.deb',
    cwd => "/home/${username}",
    creates => "/usr/bin/google-chrome",
  } -> 
  exec{'add shortcuts to desktop':
    command => "ln -s /usr/bin/google-chrome /home/${username}/Desktop/google-chrome",
    creates => "/home/${username}/Desktop/google-chrome",
  } ->
  exec{'set permissions':
    command =>"chmod +x /home/${username}/Desktop/*",
    provider => 'shell',
  }
}

class r_stuff{
  package{'r-base':
    require => Exec['sys_update'],
    ensure => 'installed'
  } ->
  # required for rstudio
  package{'libjpeg62':
    ensure => 'installed'
  } ->
  exec{'download rstudio':
    command => 'wget http://download1.rstudio.org/rstudio-0.98.953-i386.deb',
    cwd => "/home/${username}",
    creates => "/home/${username}/rstudio-0.98.953-i386.deb",
    user => "${username}",
  } ->
  exec{'install rstudio':
    require => Class['fix_broken'],  
    command => 'dpkg -i http://download1.rstudio.org/rstudio-0.98.953-i386.deb',
  } ->
  exec{'add shortcut':
    command => "ln -s /usr/bin/rstudio /home/${username}/Desktop/rstudio",
    creates => "/home/${username}/Desktop/rstudio",
  } ->
  exec{'set permissions on desktop':
    command =>"chmod +x /home/${username}/Desktop/rstudio",
    provider => 'shell',  
  } ->
  # these are needed for stuff like devtools
  package{'libcurl4-gnutls-dev':
    ensure => 'installed',
  } ->
  package{'libcurl4-nss-dev':
    ensure => 'installed',
  } ->
  package{'libcurl4-openssl-dev':
    ensure => 'installed'
  }

}

include git
include fix_broken
include chrome
include basic_gui
include r_stuff