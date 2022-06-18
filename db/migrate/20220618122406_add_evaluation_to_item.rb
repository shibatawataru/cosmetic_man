class AddEvaluationToItem < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :evaluation, :float
  end
end
