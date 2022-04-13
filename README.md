# trade-with-kraken

another package to trade with kraken

to contact kraken, you have two possibilities:
- a get request to get public data
- a post request with encrypted signature to get private data or to send orders

__public request__

you have the choice between drakma and dexador to send the request

```lisp
(map 'string #'code-char
     (drakma:http-request "https://api.kraken.com/0/public/Ticker?pair=XXBTZEUR"))
```

```lisp
(dex:get "https://api.kraken.com/0/public/Ticker?pair=XXBTZEUR")
```

__private request__

after putting api-key and api-secret (one per line, without quotation marks) in the file kraken.key and loading trade-with-kraken.lisp in repl, you're ready to use.

__function signature__

returns arguments needed to send a http resquet

```lisp
(trade-with-kraken:signature "TradeBalance" '(("asset" . "ZEUR")))
```

you have always the choice between drakma and dexador to send the request

```lisp
(map 'string #'code-char
     (multiple-value-bind (uri parameters headers) 
         (trade-with-kraken:signature "TradeBalance" '(("asset" . "ZEUR")))
       (drakma:http-request uri :method :post :parameters parameters :additional-headers headers)))
```
```lisp
(multiple-value-bind (uri content headers) 
    (trade-with-kraken:signature "TradeBalance" '(("asset" . "ZEUR")))
  (dex:post uri :content content :headers headers))
```

because Dexador takes so so long to detect that the network is unreachable, i will continue with drakma, but you do as you want ;)



to be continued.

