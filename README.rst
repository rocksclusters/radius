=====================
Using the radius Roll
=====================

General Usage Guidelines
########################

The RAIDUS roll preconfigures a set of unix groups which are used to manage
RADIUS users.

All users which are part of the group radiususers are disable from local login
on the machine and are used by the RADIUS Server to authenticate users on remote
Network Access Server (NAS).
On some swtich if the user is part of switchadmin group it will get super
users access to the switch, if it is part of switchlogin group it will only be
logged in as a standard users.

To create a radius user the following commands should be used from the root account:

::

    useradd -m -g radiususers test
    passwd test

The user should be added to the group switchadmin editing the file /etc/group.
If a user wants to use a One Time Password solution based on the `google-authenticator <http://code.google.com/p/google-authenticator/>`_
he should set up his OTP key with the following:

::

    su - test
    google-authenticator

and scan the bar code on the screen. When he logs in one of the switch he should
type his password (the one set up with passwd) and then appends the one time code
currently disaplyed on the phone screen.
If a RADIUS user did not set up the google-authenticator it can login just with his own
password.

Some swtich support only 8 characters long password which means that if you are using
google OTP on top of that you are left with only a 2 character long password. If a user
is configured with a longer password then it will not be able to authenticate on those
switches.

Example of switch configurations
################################

In this section we present some example of switch configuration to make the
switch authenticate with the radius server.

- The swtich SMC TigerSwitch 8624 T uses the following directive. This switch support only 8 characters long password.
  ::
      radius-server host RADIUS_server_password
      radius-server key NAS_password
      authentication login radius local

- The swtich SMC TigerSwitch 8748L2 uses the following (newer directive) directive (its firmware supports multiple RADIUS servers). This switch support only 8 characters long password.
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

