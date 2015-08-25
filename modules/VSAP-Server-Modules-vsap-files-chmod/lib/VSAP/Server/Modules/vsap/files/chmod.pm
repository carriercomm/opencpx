
use VSAP::Server::Modules::vsap::globals;
##############################################################################

our $VERSION = '0.12';

our %_ERR    = (
                 NOT_AUTHORIZED          => 100,

    my $recurse = $xmlobj->child('recurse') ?
    my $recurse_X = $xmlobj->child('recurse_X') ?

    $path = "/" . $path unless ($path =~ m{^/});  # prepend with /
        # add apache run user
        push(@ulist, $VSAP::Server::Modules::vsap::globals::APACHE_RUN_USER);
                # vsap user can only manipulate files owned by self or by
                      return;
                      return;
        $root_node->appendTextChild(recurse_option_valid => $recurse_option_valid);






a single file.
will also need to use the "virtual path name" to a file; no '<user>'
A query made by a Domain Administrator or End User on a file homed
in their own home directory.
If the path name is accessible (see NOTES), information about the file
mode bits and ownership will be returned.  If the path name is a
directory and is a candidate for a recursive modify mode action, a
boolean value (0|1) will be returned as the value for the
'<recurse_option_valid>' node.
The following example generically represents the structure of a typical
    <mode>
To set (i.e. modify) the file mode bits for a file, the new file mode
need simply be coupled with the path name and (optional) user name.
Specify the new file mode using a '<mode>' node with appropriately
If the path name represents a directory, then you may also (optionally)
The following template represents a the generic form of a request to
    <mode>
      </owner>
      </group>
      <world>
If the file is accessible (see NOTES), the file mode bits will be updated
or an error will be returned.   A successful update will be indicated by
whether it exists or not.  However, End Users are restricted access (or
'jailed') to their own home directory tree.  Domain Administrators are
likewise restricted, but to the home directory trees of themselves and
their end users.  Any attempts to get information about or modify
properties of files that are located outside of these valid directories




