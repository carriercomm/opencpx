package VSAP::Server::Sys::Service::Control::Linux::Postfix;

use base VSAP::Server::Sys::Service::Control::Linux::RC;

##############################################################################

our $VERSION = '0.12';

##############################################################################

sub new
{
    my $class = shift;
    my %args = @_;
    $args{servicename} = 'postfix';
    $args{script} = '/etc/init.d/postfix';
    my $this = $class->SUPER::new(%args);
    bless $this, $class;
}

##############################################################################

sub last_started
{
    my $self = shift;

    my $pidfile = '/var/spool/postfix/pid/master.pid';
    my $pid = $self->get_pid($pidfile);

    return 0 unless ($pid);

    my $mtime = (stat($pidfile))[9];
    return $mtime;
}

##############################################################################

sub version
{
    my $version = "0.0.0.0";
    my $status = `/usr/sbin/postconf -d mail_version`;
    if ($status =~ /mail_version = ([0-9\.]*)/i) {
        $version = $1;
    }
    return $version;
}

##############################################################################
1;

__END__

=head1 NAME

VSAP::Server::Sys::Service::Control::Linux::Postfix - Module allowing control of postfix software

=head1 SYNOPSIS

  use VSAP::Server::Sys::Service::Control::Postfix;

  my $control = new VSAP::Server::Sys::Service::Postfix;

  # Start vsapd
  $control->start;

  # Stop vsapd
  $control->stop;

  # Restart vsapd
  $control->restart;

  # Enable vsapd to start when machine boots.
  $control->enable;

  # Disable vsapd from starting when machine boots.
  $control->disable;

  do_something()
    if ($control->is_available);

  # Check if vsapd is enabled.
  do_something()
    if ($control->is_enabled);

  # Check if vsapd is running.
  do_something()
    if ($control->is_running);


=head1 DESCRIPTION

This is a simple object which extends the I<VSAP::Server::Sys::Service::Control::Linux::RC object> in
order to provide control for the apache service.

=head1 METHODS

See the methods defined in I<VSAP::Server::Sys::Service::Control::Base::RC>.

=head1 SEE ALSO

VSAP::Server::Sys::Service::Control, VSAP::Server::Sys::Service::Control::Linux::RC

=head1 EXPORT

None by default.

=head1 AUTHOR

James Russo and Rus Berrett

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011 by MYNAMESERVER, LLC

No part of this module may be duplicated in any form without written
consent of the copyright holder.

=cut
