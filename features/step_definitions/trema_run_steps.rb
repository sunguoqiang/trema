#
# Author: Yasuhito Takamiya <yasuhito@gmail.com>
#
# Copyright (C) 2008-2011 NEC Corporation
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License, version 2, as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#


When /^I try trema run "([^"]*)" with following configuration:$/ do | command, config |
  @trema_log = `mktemp`.chomp
  Thread.start do
    Tempfile.open( "trema.conf" ) do | conf |
      conf.puts config
      conf.flush
      system "./trema run \"#{ command }\" -c #{ conf.path } -v > #{ @trema_log } 2>&1"
    end
  end
end


When /^I try trema run with following configuration \(log = "([^"]*)"\):$/ do | log_name, config |
  Thread.start do
    Tempfile.open( "trema.conf" ) do | trema_conf |
      trema_conf.puts config
      trema_conf.flush
      log = File.join( Trema.log_directory, log_name )
      system "./trema run -c #{ trema_conf.path } --verbose > #{ log } 2>&1"
    end
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End: