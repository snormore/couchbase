require "chef/resource"
require File.join(File.dirname(__FILE__), "credentials_attributes")

class Chef
  class Resource
    class ClusterRebal < Resource
      include Couchbase::CredentialsAttributes

      def knownNodes(arg=nil)
        set_or_return(:knownNodes, arg, :kind_of => String, :name_attribute => true)
      end

      def ejectedNodes(arg=nil)
        set_or_return(:ejectedNodes, arg, :kind_of => String, :name_attribute => true)
      end

      def username(arg=nil)
        set_or_return(:username, arg, :kind_of => String, :name_attribute => true)
      end

      def password(arg=nil)
        set_or_return(:password, arg, :kind_of => String, :name_attribute => true)
      end

      def initialize(*)
        super
        @action = :rebalance
        @allowed_actions.push :rebalance
        @resource_name = :cluster_rebal
      end
    end
  end
end
