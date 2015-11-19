class Link < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :title
      t.string :url
      t.boolean :status, default: true
    end
  end
end
