require "chef/provider"
require File.join(File.dirname(__FILE__), "client")
require File.join(File.dirname(__FILE__), "cluster_data")

class Chef
  class Provider
    class ClusterRebal < Provider
      include Couchbase::Client

      def load_current_resource
        @current_resource = Resource::ClusterRebal.new @new_resource.name
        @current_resource.ejectedNodes @new_resource.ejectedNodes
        @current_resource.knownNodes @new_resource.knownNodes
        @current_resource.username @new_resource.username
        @current_resource.password @new_resource.password

      end
      
      def action_rebalance
	  post "/controller/rebalance", rebal_params
          @new_resource.updated_by_last_action true
          Chef::Log.info "#{@new_resource} modified"
      end        

      def rebal_params
        {
          "ejectedNodes" => new_resource.ejectedNodes,
          "knownNodes" => new_resource.knownNodes
        }
      end
 
    end
  end
end
