## Overview

Library to handle double entry accounting with Elixir.

## Creating Accounts

```elixir
book = Buchhalter.book('main')

book = Buchhalter.account(book, "assets.cash")
book = Buchhalter.account(book, "revenue.sales")
```

## Recording an entry

```elixir

book =
  Buchhalter.entry(book,
    description: "Sold fridge",
    date: Date.utc_today(),
    transactions: [
      %Buchhalter.Transaction{account: "assets.cash", amount: 1_000.00},
      %Buchhalter.Transaction{"revenue.sales", -1_000.00}
  ])
Buchhalter.commit(book)

# To type less you can use tuples where first item is account and second is amount
book =
  Buchhalter.entry(book,
    description: "Sold fridge",
    date: Date.utc_today(),
    transactions: [
      {"assets.cash", 1_000.00},
      {"revenue.sales", -1_000.00}
  ])
Buchhalter.rollback(book) # Removes transaction from stack

# You can skip transaction value on the other side and it will figure it out
book =
  Buchhalter.entry(book,
    description: "Sold a kitchen table",
    date: Date.utc_today(),
    transactions: [
      {"assets.cash", 100.00},
      {"assets.accounts_receivable", 50.00},
      "revenue.sales" # this will be -150.00
  ])
Buchhalter.commit(book)

```

## Getting balance for account

```elixir

{:ok, %Buchhalter.Money{amount: 1100.00}} = Buchhalter.balance(book, "assets.cash")
{:ok, %Buchhalter.Money{amount: 50.00}} = Buchhalter.balance(book, "assets.accounts_receivable")

{:ok, %Buchhalter.Money{amount: -1150.00}} = Buchhalter.balance(book, "revenue.sales")

# To get balance for multiple account category. Just step back in account tree.
{:ok, %Buchhalter.Money{amount: 1150.00}} = Buchhalter.balance(book, "assets")

```

## Getting list of entries

```elixir

# To return all the entries
[%Buchhalter.Entry{description: "Sold fridge"},
 %Buchhalter.Entry{description: "Sold a kitchen table"}] = Buchhalter.entries(book)

# To return only entries for specific account
[%Buchhalter.Entry{description: "Sold a kitchen table"}] =
  Buchhalter.entries(book, account: "assets.accounts_receivable")
```
