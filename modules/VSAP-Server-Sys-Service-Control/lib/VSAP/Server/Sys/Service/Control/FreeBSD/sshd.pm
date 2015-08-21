package VSAP::Server::Sys::Service::Control::FreeBSD::sshd;

use base VSAP::Server::Sys::Service::Control::FreeBSD::RC;

##############################################################################

our $VERSION = '0.01';

##############################################################################

sub new
{
    my $class = shift;
    my %args = @_;
    $args{servicename} = 'sshd';
    my $this = $class->SUPER::new(%args);
    bless $this, $class;
}

##############################################################################

sub is_available
{
    my $self = shift;

    return 1;
}

##############################################################################

sub is_running
{
    my $self = shift;

    my $pid = $self->get_pid('/var/run/sshd.pid');
    return 0 unless ($pid);
    return 1 if kill 0, $pid;
    return 0;
}

##############################################################################

sub last_started
{
    my $self = shift;

    my $pid = $self->get_pid('/var/run/sshd.pid');
    return 0 unless ($pid);
    my $mtime = (stat('/var/run/sshd.pid'))[9];
    return $mtime;
}

##############################################################################

sub start
{
    my $self = shift;

    my $rc = $self->run_script('. /usr/local/etc/rc.subr; . /etc/defaults/rc.conf; source_rc_confs; ${sshd_program:-/usr/sbin/sshd} ${sshd_flags}');

    # Lets give it some time to start..
    my $cnt = 0;
    while ($cnt++ < 3 && ! $self->is_running) { sleep 1; }

    return $rc;
}

##############################################################################

sub stop
{
    my $self = shift;

    my $pid = $self->get_pid('/var/run/sshd.pid');
    return 1 unless ($pid);
    return 1 if kill 15, $pid;
    return 0;
}

##############################################################################

sub version
{
    my $version = "0.0.0.0";
    my $status = `/usr/sbin/sshd -v 2>&1`;
    if ($status =~ m#OpenSSH_(.*?)[,-\s]#i) {
        $version = $1;
    }
    return $version;
}

##############################################################################
1;

__END__

=head1 NAME

VSAP::Server::Sys::Service::Control::sshd - Module allowing control of sshd service.

=head1 SYNOPSIS

  use VSAP::Server::Sys::Service::Control::sshd;

  my $control = new VSAP::Server::Sys::Service::sshd;

  # Start sshd
  $control->start;

  # Stop sshd
  $control->stop;

  # Restart sshd
  $control->restart;

  # Enable sshd to start when machine boots.
  $control->enable;

  # Disable sshd from starting when machine boots.
  $control->disable;

  do_something()
    if ($control->is_available);

  # Check if sshd is enabled.
  do_something()
    if ($control->is_enabled);

  # Check if sshd is running.
  do_something()
    if ($control->is_running);


=head1 DESCRIPTION

This object contains the specific methods to stop/stop/enable/disable sshd. It is
typically used by the I<VSAP::Server::Sys::Service::Control> module.

=head1 METHODS

=head2 stop
    Stops sshd.

=head2 start
    Starts sshd.

=head2 enable
    Enable sshd to startup automatically.

=head2 disable
    Disable sshd to startup automatically.

=head2 is_enabled
    Determine if sshd is currently configured to startup automatically.

=head2 is_running
    Determine if sshd is currently running.

=head2 is_available
    Determine if sshd is currently available. Meaning, is it installed.

=head1 SEE ALSO

VSAP::Server::Sys::Service::Control

=head1 EXPORT

None by default.

=head1 AUTHOR

James Russo

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2006 by MYNAMESERVER, LLC

No part of this module may be duplicated in any form without written
consent of the copyright holder.

=cut
