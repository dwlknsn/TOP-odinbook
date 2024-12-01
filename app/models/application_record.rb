class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def dom_id(prefix = nil)
    ActionView::RecordIdentifier.dom_id(self, prefix)
  end
end
