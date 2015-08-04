class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :question
      t.integer :position

      t.timestamps null: false
    end
  end
end
