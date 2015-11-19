class ChangeDefaultToTrue < ActiveRecord::Migration
  def change
    change_column_default :links, :status, false
  end
end
