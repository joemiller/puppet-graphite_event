require 'puppet'
require 'yaml'
require 'socket'
require 'time'

Puppet::Reports.register_report(:graphite_event) do

  configfile = File.join([File.dirname(Puppet.settings[:config]), "graphite_event.yaml"])
  raise(Puppet::ParseError, "graphite_event report config file #{configfile} not readable") unless File.exist?(configfile)
  config = YAML.load_file(configfile)
  GRAPHITE_SERVER = config[:graphite_server]
  GRAPHITE_PORT = config[:graphite_port]
  PATH_PREFIX = config[:path_prefix]
 
  desc <<-DESC
  Sends the number of changes to graphite. Can be used to help correlate
  puppet changes to other data in graphite.
  DESC

  def send_metric payload
    socket = TCPSocket.new(GRAPHITE_SERVER, GRAPHITE_PORT)
    socket.puts payload
    socket.close
  end

  # NOTE: We only send an update to graphite if the number of changes is > 0.
  # we do this so that this data can be graphed with the drawAsInfinite()
  # function. This allows you to overlay puppet change events on other
  # graphs.  See here for more info on graphing 'events':
  # http://codeascraft.etsy.com/2011/02/15/measure-anything-measure-everything/
  def process
    return if self.metrics.nil?  # failed reports may have no metrics? be safe.
    changes = self.metrics['changes']['total']

    if changes > 0
        epochtime = Time.now.utc.to_i
        host_as_underscores = self.host.gsub(/\./, '_')
        name = "#{PATH_PREFIX}.#{host_as_underscores}" 

        send_metric "#{name} #{changes} #{epochtime}"
    end
  end
end
