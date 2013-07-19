=====================
Using the radius Roll
=====================

Using the radius Roll
#####################

The RAIDUS roll preconfigures a set of unix groups which are used to manage
RDIUS users.

All users which are part of the group radiususers are disable from local login
on the machine and are used by the radiusserver to authenticate users.
On some swtich if the user is part of switchadmin group it will get super
users access to the switch, if it is switchlogin the user will only be
logged in as a standard users.

To create a radius user, it should be created suing the following command from
the root account:

::

    useradd -m -g radiususers test
    passwd test

The user should be added to the group switchadmin editing the file /etc/group.
If a user wants to use One Time Password he should:

::

    su - test
    google-authenticator

and scan the bar code on the screen. When he logs in one of the switch he will use
his password and append at the end the one time code from his screen.
If the user does not run the google-authenticator command it will use just
his own password to login.

Some swtich support only 8 characters long password which means that if you are using
google OTP on top of that you are left with only a 2 character long password.

Example of switch configurations
################################

In this section we present some example of switch configuration to make the
switch authenticate with the radius server.

The swtich SMC TigerSwitch 8624 T uses the following directive.

::

    radius-server host RADIUS_server_password
    radius-server key NAS_password
    authentication login radius local

The swtich SMC TigerSwitch 8748L2 uses the following (newer directive) directive (its firmware supports multiple RADIUS servers).

::

    radius-server 1 host RADIUS_server_password
    radius-server key NAS_password
    authentication login radius local

The Switch Arista DCS-7148S-R can be configured for Radius with the following command. (Imp! It does not enforce authorization level, which mean that if the radiususers is in the group switchlogin it will have enable access) (ip route 0.0.0.0/0 gateway_IP to set the default gateway).

::

    radius-server key 0 yoursecretkey
    radius-server host host_server
    aaa authentication login default group radius local

.. toctree::
   :maxdepth: 1

