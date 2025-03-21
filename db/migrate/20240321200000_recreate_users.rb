class RecreateUsers < ActiveRecord::Migration[8.0]
  def change
    drop_table :users if table_exists?(:users)
    
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.datetime :check_in_time, null: false
      t.timestamps null: false
    end
  end
end 