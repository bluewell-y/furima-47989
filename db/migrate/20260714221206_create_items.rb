class CreateItems < ActiveRecord::Migration[7.0] # バージョン（7.0等）は環境により異なります
  def change
    create_table :items do |t|
      # 商品名（文字列、空欄NG）
      t.string     :name,                null: false
      
      # 商品の説明（長いテキスト、空欄NG）
      t.text       :info,                null: false
      
      # カテゴリー（ActiveHashのIDを保存、整数型、空欄NG）
      t.integer    :category_id,         null: false
      
      # 商品の状態（ActiveHashのIDを保存、整数型、空欄NG）
      t.integer    :sales_status_id,     null: false
      
      # 配送料の負担（ActiveHashのIDを保存、整数型、空欄NG）
      t.integer    :shipping_fee_status_id, null: false
      
      # 発送元の地域（ActiveHashのIDを保存、整数型、空欄NG）
      t.integer    :prefecture_id,       null: false
      
      # 発送までの日数（ActiveHashのIDを保存、整数型、空欄NG）
      t.integer    :scheduled_delivery_id, null: false
      
      # 価格（整数型、空欄NG）
      t.integer    :price,               null: false
      
      # 出品したユーザー（外部キー、空欄NG）
      t.references :user,                null: false, foreign_key: true

      t.timestamps
    end
  end
end