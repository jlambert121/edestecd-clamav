# params.pp
# Set up ClamAV parameters defaults etc.
#
# @Todo: add osx support with ClamXav
#

class clamav::params {

  #### init vars ####
  $manage_user      = false
  $manage_clamd     = false
  $manage_freshclam = false


  if ($::osfamily == 'RedHat') and ($::operatingsystemrelease >= 6.0) {
    #### init vars ####
    $clamav_package    = 'clamav'

    #### user vars ####
    $user              = 'clam'
    $comment           = 'Clam Anti Virus Checker'
    $uid               = 496
    $gid               = 496
    $home              = '/var/lib/clamav'
    $shell             = '/sbin/nologin'
    $group             = 'clam'

    #### clamd vars ####
    $clamd_package     = 'clamd'
    $clamd_config      = '/etc/clamd.conf'
    $clamd_service     = 'clamd'
    $clamd_options     = {}
    $clamd_default_options = {
      LogFile => '/var/log/clamav/clamd.log',
    }

    #### freshclam vars ####
    $freshclam_config  = '/etc/freshclam.conf'
    $freshclam_options = {}
    $freshclam_default_options = {
    }
  } elsif ($::osfamily == 'Debian') and ($::operatingsystemrelease >= 12.0) {
    #### init vars ####
    $clamav_package    = 'clamav'

    #### user vars ####
    $user              = 'clamav'
    $comment           = undef
    $uid               = 496
    $gid               = 496
    $home              = '/var/lib/clamav'
    $shell             = '/bin/false'
    $group             = 'clamav'

    #### clamd vars ####
    $clamd_package     = 'clamav-daemon'
    $clamd_config      = '/etc/clamav/clamd.conf'
    $clamd_service     = 'clamav-daemon'
    $clamd_options     = {}
    $clamd_default_options = {
    }

    #### freshclam vars ####
    $freshclam_package = 'clamav-freshclam'
    $freshclam_config  = '/etc/clamav/freshclam.conf'
    $freshclam_service = 'clamav-freshclam'
    $freshclam_options = {}
    $freshclam_default_options = {
    }
  } else {
    fail("The ${module_name} module is not supported on a ${::osfamily} based system with version ${::operatingsystemrelease}.")
  }

}