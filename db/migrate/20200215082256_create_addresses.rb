class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      # references
      t.references :user,                 null: false, foreign_key: true
      t.references :area,                 null: false, foreign_key: true

      # enum
      t.integer    :status_num,           null: false, limit: 1, unsigned: true,default: 0

      # values
      t.string     :first_name,           null: false
      t.string     :last_name,            null: false
      t.string     :first_name_kana,      null: false
      t.string     :last_name_kana,       null: false
      t.string     :postal_number,        null: false
      t.string     :city,                 null: false
      t.string     :number,               null: false
      t.string     :building,             null: true
      t.string     :telephone_number,     null: false

      t.timestamps
    end
  end
end
