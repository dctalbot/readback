class AddCartNameToSignoffs < ActiveRecord::Migration
  def change
    add_column :signoffs, :with_cart_name, :boolean, default: false, null: false
    add_column :signoff_instances, :with_cart_name, :boolean, default: false, null: false
    add_column :signoff_instances, :cart_name, :text
  end
end
