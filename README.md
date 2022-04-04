## users テーブル

| Column             | Type   | Options                    |
| ------------------ | ------ | -------------------------- |
| email              | string | null: false, unique: true  |
| encrypted_password | string | null: false                |
| name               | string | null: false                |

- has_many :items, through: :orders
- has_many :orders


## items テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | -------------------------------|
| name           | string     | null: false                    |
| price          | integer    | null: false                    |
| status         | string     | null: false                    |
| brand          | string     | null: false                    |
| category       | string     | null: false                    |
| delivery_price | integer    | null: false                    |
| delivery_days  | integer    | null: false                    |
| delivery_area  | string     | null: false                    |
| user_id        | references | null: false, foreign_key: true |

- belongs_to :users, through: :orders
- has_many :orders


## orders テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| user_id     | references | null: false  foreign_key: true |
| item_id     | references | null: false, foreign_key: true |
| delivery_id | references | null: false, foreign_key: true |

- belongs_to :users
- belongs_to :items
- has_one :deliveries


## deliveries テーブル

| Column      | Type    | Options     |
| ----------- | --------| ------------|
| postcode    | integer | null: false |
| prefecture  | text    | null: false |
| city        | text    | null: false |
| block       | text    | null: false |
| building    | text    | null: false |
| phonenumber | integer | null: false |

- belongs_to :orders
