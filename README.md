puppet-graphite_event
=====================

Description
-----------

A puppet report processor for sending events to a 
[graphite](http://graphite.wikidot.com/) server.

This report processor will send the number of changes made during a puppet
run into a graphite server. The data can then be overlaid onto other metrics
to help correlate events.  Use the `drawAsInfinite()` function in graphite 
to draw the events as vertical lines.

![example-graph-image](http://adamzap.com/random/landslide.png)

For example, in the diagram above the load average from a group of servers 
is plotted. Blue vertical linesmark a point in time when puppet modified 
resources on a host in the group. We can see that immediately following a
a puppet change the load spiked on one of the servers. This can be 
very valuable information.

Similar software
----------------

This module is only meant to send change events to graphite. If you would 
like to send all metric data to graphite, please see
[puppet-graphite](https://github.com/nareshov/puppet-graphite) by Naresh V.


Requirements
------------

* `Puppet`. (Only tested on 2.7 but likely works on 2.6 and possibly 0.25)
* A [graphite](http://graphite.wikidot.com/) server^

Installation & Usage
--------------------

1. Install puppet-graphite_event as a module in your puppet master's module
   path (eg: `/etc/puppet/modules/puppet-graphite_event`)

2. Copy the included graphite_event.yaml to your puppet master's config
   dir (eg: `/etc/puppet/`). Then update the `graphite_server`, `graphie_port`,
   and `path_prefix` variables.
   
   Metrics sent to graphite will use the path: `<path_prefix>.fqdn_with_underscores`.
   
3.  Enable pluginsync and reports on your master and clients in `puppet.conf`

        [master]
        report = true
        reports = graphite_event  # can specify multiple, ie: `store, graphite_event`
        pluginsync = true
        
        [agent]
        report = true
        pluginsync = true

4.  Restart your puppet master.

Author
------

joe miller.  http://joemiller.me (11/5/2011)

Derived from [puppet-graphite](https://github.com/nareshov/puppet-graphite) by Naresh V. <nareshov@gmail.com>
Derived from [puppet-ganglia](https://github.com/jamtur01/puppet-ganglia) by James Turnbull <james@lovedthanlost.net>

Original License
----------------

    Author:: James Turnbull (<james@lovedthanlost.net>)
    Copyright:: Copyright (c) 2011 James Turnbull
    License:: Apache License, Version 2.0

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

License of this derived work
----------------------------

    Same as above plus:
    Author:: Joe Miller (<joeym@joeym.net>)
    Copyright:: Copyright (c) 2011 Joe Miller
    License:: Apache License, Version 2.0
