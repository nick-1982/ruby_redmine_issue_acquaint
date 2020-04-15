class CreateAcquaints < ActiveRecord::Migration
  def change
    create_table :acquaints do |t|
      t.references :issue, foreign_key: true, null: false, null: false
      t.references :user, foreign_key: true, blank: false, null: false
      t.boolean :status, default: false, null: false
    end
    add_index :acquaints, [:issue_id, :user_id], :unique => true
    add_index :acquaints, :status
  end
end
