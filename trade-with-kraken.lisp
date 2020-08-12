(defpackage :trade-with-kraken
  (:use :cl)
  (:import-from :cl-kraken/src/time :generate-kraken-nonce)
  (:import-from :cl-kraken/src/http :post-http-headers)
  (:export :signature))

(in-package :trade-with-kraken)

(with-open-file (stream "kraken.key")
  (defparameter *api-key* (read-line stream nil))
  (defparameter *api-secret* (read-line stream nil)))

(defun signature (method &optional parameters)
  (let* ((path (concatenate 'string "/0/private/" method))
	 (uri (concatenate 'string "https://api.kraken.com" path))
	 (nonce (generate-kraken-nonce))
	 (parameters (acons "nonce" nonce parameters))
	 (headers (post-http-headers path nonce parameters
				     *api-key* *api-secret*)))
    (values uri parameters headers)))

