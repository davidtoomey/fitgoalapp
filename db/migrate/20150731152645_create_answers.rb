class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :question_id
      t.integer :choice_id

      t.timestamps null: false
    end
  end
end
