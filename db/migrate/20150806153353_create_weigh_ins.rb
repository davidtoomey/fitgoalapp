class CreateWeighIns < ActiveRecord::Migration
  def change
    create_table :weigh_ins do |t|
      t.integer :user_id
      t.integer :weight

      t.timestamps null: false
    end
  end
end
