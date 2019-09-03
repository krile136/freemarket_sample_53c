# README


## usersテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|phone|integer|null: false|
|password|string|null: false|
|profile|string||
|last_name|string|null: false|
|first_name|string|null: false|
|last_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birth_year|integer|null: false|
|birth_month|integer|null: false|
|birth_day|integer|null: false|
|postal_code|integer|null: false|
|prefecture_id|references|null: false, foreign_key: true|
|city_id|references|null: false, foreign_key: true|
|address|string|null: false|
|building|string||
|icon|string||
|active|boolean||
|receivable|int||

### Association
- has_many :items, dependent: :destroy
- has_many :postpays
- has_many :receivables
- has_many :comments
- has_many :likes, dependent: :destroy
- has_many :receivables
- has_many :evaluations
- has_many :points
- has_many :todos
- has_many :buyed_items, foreign_key: "buyer_id", class_name: "Item"
- has_many :saling_items, -> { where("buyer_id is NULL") }, foreign_key: "saler_id", class_name: "Item"
- has_many :sold_items, -> { where("buyer_id is not NULL") }, foreign_key: "saler_id", class_name: "Item"
- has_one :delivery_address, dependent: :destroy
- has_one :creditcard, dependent: :destroy
- belongs_to :prefecture（Active_hash)
- belongs_to :city（Active_hash)


## itemsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, add_index|
|price|integer|null: false,|
|description|text|null: false|
|condition|int|null: false|
|fee_type|int|null: false|
|delivery_method|int|null: false|
|pay_method|int||
|receive|boolean||
|sold_date|datetime|null: false|
|user_id|references|null: false, foreign_key: true|
|buyer_id|references|null: false, foreign_key: true|
|saller_id|references|null: false, foreign_key: true|
|brand_id|references|null: false, foreign_key: true|
|brand_group_id|references|null: false, foreign_key: true|
|prefecture_id|references|null: false, foreign_key: true|
|size_id|references|null: false, foreign_key: true|
|category_id|references|null: false, foreign_key: true|
|delivery_day|references|null: false, foreign_key: true|

### Association
- has_many :images, dependent: :destroy
- has_many :comments
- has_many :likes
- belongs_to :postpays
- belongs_to :brand
- belongs_to :brand_group
- belongs_to :category
- belongs_to :prefecture（Active_hash)
- belongs_to :buyer_id, class_name: "User"
- belongs_to :saller_id, class_name: "User"



## delivery_addressesテーブル

|Column|Type|Options|
|------|----|-------|
|delivery_last_name|string|null: false|
|delivert_first_name|string|null: false|
|delivery_last_name_kana|string|null: false|
|delivery_first_name_kana|string|null: false|
|delivery_postal_code|string|null: false|
|delivery_address|string|null: false|
|delivery_building|string||
|delivery_phone|integer|null: false|
|delivery_prefecture_id|references|null: false, foreign_key: true|
|delivery_city_id|references|null: false, foreign_key: true|
|prefecture_id|references|null: false, foreign_key: true|
|city_id|references|null: false, foreign_key: true|
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :prefecture（Active_hash)
- belongs_to :city（Active_hash)


## imagesテーブル

|Column|Type|Options|
|------|----|-------|
|name|string||
|item_id|references|null: false, foreign_key: true|

### Association
- belongs_to :item


## brandsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string||

### Association
- has_many :items


## brand_groupsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string||

### Association
- has_many :items


## categoriesテーブル

|Column|Type|Options|
|------|----|-------|
|name|string||
|ancestry|string||

### Association
- has_ancestry
- has_many :items


## imagesテーブル

|Column|Type|Options|
|------|----|-------|
|name|string||
|item_id|references|null: false, foreign_key: true|

### Association
- belongs_to :item

## prefectureテーブル（Active_hash)

|Column|Type|Options|
|------|----|-------|
|name|string||

### Association
- has_many :users
- has_many :items
- has_many :delivery_address


## citiesテーブル（Active_hash)

|Column|Type|Options|
|------|----|-------|
|name|string||

### Association
- has_many :users
- has_many :delivery_address


## postpaysテーブル

|Column|Type|Options|
|------|----|-------|
|status|boolean||
|price|integer||
|pay_limit|datatime|null: false|
|pay_method|integer||
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|

### Association
- has_many :items
- belongs_to :user


## receivablesテーブル

|Column|Type|Options|
|------|----|-------|
|status|boolean||
|price|integer||
|request_date|datatime|null: false|
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user


## commentsテーブル

|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|public|booleane||
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item


## likesテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item


## creditcardsテーブル

|Column|Type|Options|
|------|----|-------|
|credit_number|integer|null: false|
|limit_month|integer|null: false|
|limit_year|integer|null: false|
|security_number|integer|null: false|
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user


## evaluationsテーブル

|Column|Type|Options|
|------|----|-------|
|comment|text|null: false|
|evaluation|integer|null: false|
|evaluation_user_id|references|null: false, foreign_key: true|
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user


## pointsテーブル

|Column|Type|Options|
|------|----|-------|
|point|integer|null: false|
|point_limit|integer|null: false|
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user


## todosテーブル

|Column|Type|Options|
|------|----|-------|
|todo_title|string|null: false|
|todo_text|text|null: false|
|dellivery_date|integer|null: false|
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user