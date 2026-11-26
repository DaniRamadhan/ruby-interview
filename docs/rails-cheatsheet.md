RAILS CHEATSHEET
================
Jalankan semua perintah dari root project: d:\10.atask\ruby-interview


SETUP
-----
bundle install                  # install gem dari Gemfile (seperti mvn install)
bundle add nama_gem             # tambah gem + install
rails -v                        # cek versi rails
ruby -v                         # cek versi ruby


MENJALANKAN
-----------
rails s                         # jalankan server -> http://localhost:3000
rails c                         # console (REPL, sudah terhubung ke DB)
rails c --sandbox               # console, semua perubahan dibatalkan saat exit
rails routes                    # lihat semua endpoint
rails test                      # jalankan test

Ctrl + C                        # stop server
exit                            # keluar console


GENERATE
--------
rails g model User name:string email:string:uniq
rails g model Wallet 'owner:references{polymorphic}'
rails g model Session user:references token:string:uniq
rails g migration AddPhoneToUsers phone:string
rails g controller Api::V1::Wallets

rails destroy model Wallet      # hapus file hasil generate

Arti penulisan kolom:
  name:string                   -> varchar
  email:string:uniq             -> varchar + unique index
  amount:decimal                -> numeric (BigDecimal)
  user:references               -> user_id + index + foreign key
  'owner:references{polymorphic}' -> owner_type + owner_id + index

Catatan: di PowerShell, argumen yang ada {} wajib pakai kutip '...'


DATABASE
--------
rails db:create                 # buat database
rails db:migrate                # jalankan migration yang belum jalan
rails db:rollback               # batalkan 1 migration terakhir
rails db:rollback STEP=3        # batalkan 3 migration terakhir
rails db:migrate:status         # cek migration mana yang sudah jalan
rails db:seed                   # jalankan db/seeds.rb
rails db:reset                  # drop + create + load schema + seed
rails db:drop                   # hapus database

Aturan edit migration:
  - belum di-migrate              -> bebas edit
  - sudah migrate, lokal saja     -> rollback dulu, edit, migrate lagi
  - sudah di-push / dipakai orang -> JANGAN edit, buat migration baru

Kalau edit migration yang sudah jalan lalu db:migrate, Rails diam saja
(tidak error, tapi perubahan tidak masuk ke DB).

File penting:
  db/migrate/     -> file migration
  db/schema.rb    -> snapshot DB, otomatis, jangan diedit
  db/seeds.rb     -> data awal

Opsi kolom di migration:
  t.string :email, null: false
  t.decimal :amount, precision: 15, scale: 2
  t.references :owner, polymorphic: true, index: { unique: true }
  t.references :source_wallet, foreign_key: { to_table: :wallets }
  t.timestamps
  add_index :users, :email, unique: true
  add_check_constraint :transactions, "amount > 0", name: "amount_positive"


CEK KODE (pengganti "compile")
------------------------------
ruby -c app/models/user.rb      # cek sintaks 1 file saja
rails zeitwerk:check            # muat semua file app/ -> "All is good!" (paling mirip mvn compile)
rails c --sandbox               # coba perilaku langsung
bin/rubocop                     # cek gaya penulisan
bin/rubocop -a                  # perbaiki gaya otomatis
rails test                      # jalankan test

Ruby tidak di-compile, jadi error seperti salah nama method
baru muncul saat file dimuat / baris dijalankan.


CONSOLE
-------
User.count
User.first
User.find(1)
User.find_by(email: "a@b.com")
User.where(name: "Budi").order(:created_at)
User.create!(name: "Budi", email: "budi@mail.com", password: "secret")
reload!                         # muat ulang kode setelah diedit


WAKTU
-----
Time.current                    # pakai ini, bukan Time.now
Date.current                    # pakai ini, bukan Date.today
Time.zone.parse("2026-11-25 10:00")
24.hours.from_now
3.days.ago
Time.current.beginning_of_day

DB menyimpan waktu dalam UTC, Rails yang konversi otomatis.


TROUBLESHOOTING WINDOWS
-----------------------
ruby/rails/psql tidak dikenali di VS Code
  -> tutup semua jendela VS Code, buka lagi

refresh PATH tanpa restart:
  $env:Path = [Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [Environment]::GetEnvironmentVariable("Path","User")

Failed to build gem native extension
  -> ridk install, pilih 3

password authentication failed (Postgres)
  -> $env:DB_PASSWORD = "password_kamu"

Postgres tidak bisa connect
  -> services.msc, start postgresql-x64-16
