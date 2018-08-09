class AddSmsOnToDjs < ActiveRecord::Migration[5.2]
  def change
    add_column :djs, :sms_on, :bool
  end
end
