=====================
Using the radius Roll
=====================

General Usage Guidelines
########################

The RADIUS roll preconfigures a set of unix groups which are used to manage
RADIUS users.

All users who have as their primary group radiususers are disabled from local login
on the machine. Users must be a member of the this group so that the  RADIUS Server 
can authenticate users on remote Network Access Server (NAS).
On some switches, if the user is part of switchadmin group it will get super
users access to the switch, if it is part of switchlogin group it will only be
logged in as a standard users.

To create a radius user the following commands should be used from the root account:

::

    useradd -m -g radiususers testuser
    passwd testuser

The user should be added to the group switchadmin by

::
	usermod -a -G switchadmin testuser

If a user wants to use a One Time Password solution based on the `google-authenticator <http://code.google.com/p/google-authenticator/>`_
Then, one should follow the guidelines for setting up an OTP key in the Rocks base users guide. The following
is an example for a testuser

::

    su - testuser
    google-authenticator
    exit
    mv ~test/.google-authenticator /export/google-authenticator/testuser
    chown root.root /export/google-authenticator/testuser

The user shoudl scan the bar code on the screen when google-authenticator presents the QR code. 
When he logs in one of the switch he should
type his password (the one set up with passwd) and then appends the one time code
currently displayed on the phone screen.
If a RADIUS user did not set up the google-authenticator he/she can login just with his own
password.

Some switches support only passwords upto 8 characters in length, This means that if you are using
google OTP on top of that you are left with only a password that is two characters in length. If a user
is configured with a longer password then it will not be able to authenticate on those
switches.

Example of switch configurations
################################

In this section we present some examples of switch configuration to make the
switch authenticate with the radius server.

- The swtich SMC TigerSwitch 8624 T uses the following directive. This switch support only 8 characters long password.
  ::
      radius-server host RADIUS_server_password
      radius-server key NAS_password
      authentication login radius local

- The switch SMC TigerSwitch 8748L2 uses the following (newer directive) directive (its firmware supports multiple RADIUS servers). This switch supports only passwords upto 8 characters long.
  ::
      radius-server 1 host RADIUS_server_password
      radius-server key NAS_password
      authentication login radius local

- The Switch Arista DCS-7148S-R can be configured for Radius with the following command. (Imp! It does not enforce authorization level, which mean that if the radiususers is in the group switchlogin it will have enable access) (ip route 0.0.0.0/0 gateway_IP to set the default gateway).
  ::
      radius-server key 0 yoursecretkey
      radius-server host host_server
      aaa authentication login default group radius local

.. toctree::
   :maxdepth: 1

