class ModifyColumnItemIdToTrades < ActiveRecord::Migration[5.2]
  def up
    remove_foreign_key(:trades, :items)
    remove_index(:trades, name: :index_trades_on_item_id)
    add_index(:trades, :item_id, unique: true)
    add_foreign_key(:trades, :items)
  end

  def down
    remove_foreign_key(:trades, :items)
    remove_index(:trades, name: :index_trades_on_item_id)
    add_index(:trades, :item_id)
    add_foreign_key(:trades, :items)
  end
end
