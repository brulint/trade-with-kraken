
(defpackage :trade-with-kraken
  (:use :cl)
  (:export :get-public
           :post-private)
  )

(in-package :trade-with-kraken)

;; todo: check file exists                                              
(with-open-file (stream "kraken.key")
  (defparameter *api-key* (read-line stream nil))
  (defparameter *api-secret* (read-line stream nil)))

(defun signature (method &optional parameters)
  (let* ((nonce (cl-kraken/src/time:generate-kraken-nonce))
         (path (concatenate 'string "/0/private/" method))
         (uri (concatenate 'string "https://api.kraken.com" path))
         (parameters (acons "nonce" nonce parameters))
         (signature (cl-kraken/src/cryptography:signature path nonce parameters *api-secret*))
         (headers `(("api-key" . ,*api-key*) ("api-sign" . ,signature))))
    (values uri parameters headers)))

(defun get-public (method &optional parameters)
  (let ((uri (concatenate 'string "https://api.kraken.com/0/public/" method)))
    (drakma:http-request uri :parameters parameters)))

(defun post-private (method &optional parameters)
  (multiple-value-bind (uri parameters headers) (signature method parameters)
    (drakma:http-request uri :method :post :parameters parameters :additional-headers headers)))

