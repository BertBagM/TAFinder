class CreateApplicationMessages < ActiveRecord::Migration
  def change
    create_table :application_messages do |t|
      t.text :message

      t.timestamps null: false
    end
  end
end
