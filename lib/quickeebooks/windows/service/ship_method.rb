require 'quickeebooks/windows/service/service_base'

module Quickeebooks
  module Windows
    module Service
      class ShipMethod < Quickeebooks::Windows::Service::ServiceBase

        def list(filters = [], page = 1, per_page = 20, sort = nil, options = {})
          fetch_collection(Quickeebooks::Windows::Model::ShipMethod, nil, filters, page, per_page, sort, options)
        end

        def create(ship_method)
          
          # XML is a wrapped 'object' where the type is specified as an attribute
          #    <Object xsi:type="Invoice">
          xml_node = ship_method.to_xml(:name => 'Object')
          xml_node.set_attribute('xsi:type', 'ShipMethod')

          xml = Quickeebooks::Shared::Service::OperationNode.new.add do |content|
            content << "<ExternalRealmId>#{self.realm_id}</ExternalRealmId>#{xml_node}"
          end
          
          perform_write(Quickeebooks::Windows::Model::ShipMethod, xml)
        end
        
      end
    end
  end
end
