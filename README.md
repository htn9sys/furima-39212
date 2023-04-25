# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| family_name        | string | null: false |
| given_name         | string | null: false |
| family_name_kana   | string | null: false |
| given_name_kana    | string | null: false |
| bithday            | date   | null: false |

### Association

- has_many :items
- has_many :destinations
- has_many :comments

## items テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| name        | string     | null: false,                   |
| category    | string     | null: false,                   |
| condition   | text       | null: false,                   |
| postage     | integer    | null: false,                   |
| sender      | string     | null: false,                   |
| explanation | text       | null: false,                   |
| image       | string     | null: false,                   |
| user        | references | null: false, foreign_key: true |

### Association

- has_many :destinations
- belongs_to :user
- has_one :send

## destinations テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| purchase_date | date       |                                |
| user          | references | null: false, foreign_key: true |
| item          | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

## sends テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| post_code    | string     | null: false,                   |
| prefectures  | string     | null: false,                   |
| municipality | string     | null: false,                   |
| address      | string     | null: false,                   |
| building     | string     |                                |
| phone_number | string     | null: false,                   |
| item_id      | references | null: false, foreign_key: true |

### Association

- belongs_to :send

## comments テーブル

| Column      | Type       | Options           |
| ----------- | ---------- | ----------------- |
| text        | text       | null: false,      |
| user        | references | foreign_key: true |
| destination | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :destination