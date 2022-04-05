## users テーブル

| Column             | Type    | Options                    |
| ------------------ | ------- | -------------------------- |
| nickname           | string  | null: false                |
| email              | string  | null: false, unique: true  |
| encrypted_password | string  | null: false                |
| last_name          | string  | null: false                |
| first_name         | string  | null: false                |
| last_name_kana     | string  | null: false                |
| first_name_kana    | string  | null: false                |
| birth_date         | date    | null: false                |

- has_many :items
- has_many :orders


## items テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | -------------------------------|
| title          | string     | null: false                    |
| price          | integer    | null: false                    |
| description    | text       | null: false                    |
| category_id    | integer    | null: false                    |
| item_status_id | integer    | null: false                    |
| ship_cost_id   | integer    | null: false                    |
| ship_day_id    | integer    | null: false                    |
| ship_area_id   | integer    | null: false                    |
| user           | references | null: false, foreign_key: true |

- belongs_to :user
- has_one :order


## orders テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| user     | references | null: false  foreign_key: true |
| item     | references | null: false, foreign_key: true |

- belongs_to :user
- belongs_to :item
- has_one :delivery


## deliveries テーブル

| Column       | Type       | Options                        |
| ------------ | -----------| -------------------------------|
| postcode     | string     | null: false                    |
| ship_area_id | integer    | null: false                    |
| city         | string     | null: false                    |
| block        | string     | null: false                    |
| phonenumber  | string     | null: false                    |
| order        | references | null: false, foreign_key: true | 

- belongs_to :order
