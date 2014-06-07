Configuring my workstations with puppet
=======================================

The intent is similar to [Boxen][] but I am using Linux and have used
a simpler system. The idea is to keep configuration of all my
workstations here. In fact, the configuration is partial as I
synchronize my homes with [Unison][].

It is quite unlikely to do anything right for you.

[Boxen]: https://boxen.github.com/
[Unison]: http://www.cis.upenn.edu/~bcpierce/unison/

This requires:

 - Debian unstable
 - `puppet` package

Debian is installed using the Jessie installer, asking to use the
whole disk in a guided partitioning scheme with encryption and
separate partitions for everything. Then:

 - delete `/usr`
 - delete `/home`
 - delete `/`
 - delete swap
 - create `/home` with about 50GB
 - create `/` with about 10GB
 - don't create `/usr`, a separate `/usr` is likely to be difficult to
   handle in the future.
 - create swap, with a max of 8GB. Even suspend to disk doesn't
   require the whole memory.

Only install the following roles:

 - laptop tools (if needed)
 - base system tools
 - SSH server
