class CreateDailyCaloricIntakes < ActiveRecord::Migration
  def change
    create_table :daily_caloric_intakes do |t|
      t.integer :user_id
      t.integer :calories

      t.timestamps null: false
    end
  end
end
