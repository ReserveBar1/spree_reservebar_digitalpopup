Spree::OrdersController.class_eval do
  layout :determine_layout, only: [:edit, :show]
end
