DESCRIPTION
===========
  A [Chef](http://wiki.opscode.com/display/chef/Home) cookbook to set the host name of a server.
  
  * works as early as the `knife bootstrap` command
  * tested on CentOS/Amazon Linux Image
  
REQUIREMENTS
============
  
  * Use the `-N host.example.com` option of the knife bootstrap command

ATTRIBUTES
==========
  
  No need to change the defaults on CentOS and related.
  
  Here are the relevant attributes if you wish to adapt to your system.
  
  ```ruby
  default[:act_hostname][:ec2_scripts] = "/usr/local/ec2"
  default[:act_hostname][:script_name] = "set-hostname"
  default[:act_hostname][:startup_script] = "/etc/rc.d/rc.local"
  ```


USAGE
=====
  
  Here is the kind of command line I use to bootstrap a fresh Amazon Linux Image server:
  
  ```
  knife bootstrap 204.236.204.73 -N dragon.actime.biz -x ec2-user -i projects/AWS/id_rsa-zed-keypair -r hostname --sudo
  ```

TODO
====
  
  * Not intended to be used as a regular recipe, i.e. outside of the knife bootstrap command
  * Assumes the /etc/rc.* style of startup scripts
    
  
 LICENSE
 =======

  Under the MIT License:
  
Copyright (C) 2012 Arnaud Meuret

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
