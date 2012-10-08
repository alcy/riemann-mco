require 'riemann/client'
module MCollective
  class Discovery
    class Riemanndisc
      def self.discover(filter, timeout, limit=0, client=nil)
        
        options = client.options[:discovery_options]
        query = options[0]
        raise "No query specified" unless query
        if options[1] 
          riemann_host = options[1]
        else
          riemann_host = "127.0.0.1"
        end

        r = Riemann::Client.new(:host => "#{riemann_host}")
        results = r[query]
        hosts = []
        results.each { |arr|
          h = Hash[*arr]
          hosts << h[:host]
        }
        
        hosts
      end
    end
  end
end

        
