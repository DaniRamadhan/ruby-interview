# Wallet API

Rails 8.1 (API) + PostgreSQL.

## Kebutuhan

- Ruby 3.3
- PostgreSQL 16

## Environment variable

| Nama | Wajib | Default | Keterangan |
|---|---|---|---|
| `DB_PASSWORD` | tidak | `postgres` | Password user `postgres` |
| `RAPIDAPI_KEY` | tidak | - | API key untuk `LatestStockPrice` |

## Menjalankan

```
bundle install
bin/rails db:setup
bin/rails server
```

Akun seed:

| Email | Password |
|---|---|
| budi@mail.com | password123 |
| sari@mail.com | password123 |

## LatestStockPrice

Lokasi: `lib/latest_stock_price`. Konfigurasi: `config/initializers/latest_stock_price.rb`.

```ruby
client = LatestStockPrice::Client.new
client.price_all
client.price("RELIANCE")
client.prices(["RELIANCE", "TCS"])
```

API `suneetk92/latest-stock-price` di RapidAPI sudah tidak tersedia (`404 API doesn't exists`).
