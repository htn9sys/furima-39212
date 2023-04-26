# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false,              |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false,              |
| family_name        | string | null: false,              |
| given_name         | string | null: false,              |
| family_name_kana   | string | null: false,              |
| given_name_kana    | string | null: false,              |
| birthday           | date   | null: false,              |

### Association

- has_many :items
- has_many :destination

## items テーブル

| Column                   | Type       | Options                        |
| ------------------------ | ---------- | ------------------------------ |
| name                     | string     | null: false,                   |
| category_id[:genre_id]   | integer    | null: false,                   |
| condition_id[:genre_id]  | integer    | null: false,                   |
| postage_id[:genre_id]    | integer    | null: false,                   |
| sender_id[:genre_id]     | integer    | null: false,                   |
| prefecture_id[:genre_id] | integer    | null: false,                   |
| explanation              | text       | null: false,                   |
| user_id                  | references | null: false, foreign_key: true |
| price                    | integer    | null: false,                   |

### Association

- has_one :destination
- belongs_to :user

## destinations テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| purchase_date | date       |                                |
| user_id       | references | null: false, foreign_key: true |
| item_id       | references | null: false, foreign_key: true |
| send_id       | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- belongs_to :send

## sends テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| post_code      | string     | null: false,                   |
| prefecture_id  | integer    | null: false,                   |
| municipality   | string     | null: false,                   |
| address        | string     | null: false,                   |
| building       | string     |                                |
| phone_number   | string     | null: false,                   |
| item_id        | references | null: false, foreign_key: true |
| destination_id | references | null: false, foreign_key: true |

### Association

- has_one :destination