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
- has_many :destinations

## items テーブル

| Column                   | Type       | Options                        |
| ------------------------ | ---------- | ------------------------------ |
| name                     | string     | null: false,                   |
| category_id              | integer    | null: false,                   |
| condition_id             | integer    | null: false,                   |
| postage_id               | integer    | null: false,                   |
| sender_id                | integer    | null: false,                   |
| prefecture_id            | integer    | null: false,                   |
| explanation              | text       | null: false,                   |
| user                     | references | null: false, foreign_key: true |
| price                    | integer    | null: false,                   |

### Association

- has_one :destination
- belongs_to :user

## destinations テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| user          | references | null: false, foreign_key: true |
| item          | references | null: false, foreign_key: true |
| send          | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :send

## addresses テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| post_code      | string     | null: false,                   |
| prefecture_id  | integer    | null: false,                   |
| municipality   | string     | null: false,                   |
| address        | string     | null: false,                   |
| building       | string     |                                |
| phone_number   | string     | null: false,                   |
| item_id        | integer    | null: false,                   |
| destination    | references | null: false, foreign_key: true |

### Association

- belongs_to :destination