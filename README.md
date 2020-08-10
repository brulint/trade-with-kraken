# trade-with-kraken

because Cl-Kraken use Dexador and Dexador takes so so long to detect that the network is unreachable

# use

put one per line api-key and api-secret in kraken.key
load trade-with-kraken.lisp in repl

public request:

```(map 'string #'code-char (trade-with-kraken:get-public "Ticker" '(("pair" . "XXBTZEUR"))))```

private request:

```(map 'string #'code-char (trade-with-kraken:post-private "TradeBalance" '(("asset" . "ZEUR"))))```
