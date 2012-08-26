class AddStatusToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :delivery_status, :string, default: 'queued'
    add_column :messages, :last_status_update, :datetime
    add_column :messages, :opens, :integer, default: 0
    add_column :messages, :clicks, :integer, default: 0
  end
end
